// lib/features/bible/presentation/widgets/verse_list_view.dart
// [NEW] 장(Chapter) 전체 스크롤 뷰 — 자동 스크롤 포함

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart' show ScrollDirection;
import 'package:flutter/scheduler.dart' show Ticker;
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../theme/app_spacing.dart';
import '../../../highlights/presentation/providers/highlights_providers.dart';
import '../../../settings/presentation/providers/settings_provider.dart';
import '../../domain/entities/chapter_content.dart';
import '../providers/bible_providers.dart';
import '../providers/bible_reader_provider.dart';
import 'verse_item.dart';

/// 장 전체를 스크롤 가능한 리스트 뷰로 표시.
/// 자동 스크롤, 다음/이전 장 네비게이션 포함.
class VerseListView extends ConsumerStatefulWidget {
  const VerseListView({
    required this.content,
    this.navigationFailed = false,
    super.key,
  });

  final ChapterContent content;
  final bool navigationFailed;

  @override
  ConsumerState<VerseListView> createState() => _VerseListViewState();
}

class _VerseListViewState extends ConsumerState<VerseListView>
    with WidgetsBindingObserver, TickerProviderStateMixin {
  late final ScrollController _scrollController;
  late final Ticker _autoScrollTicker;
  late final AnimationController _chapterSlideController;
  Timer? _positionSaveTimer;
  final _viewportKey = GlobalKey();
  final _verseKeys = <int, GlobalKey>{};
  int _positionSaveGeneration = 0;
  Duration? _lastAutoScrollElapsed;
  double _autoScrollPixelsPerSecond = 0;
  double _lastViewportWidth = 1;
  double _horizontalDragDistance = 0;
  bool _restoringPosition = false;
  bool _edgeNavigating = false;

  static const _horizontalNavigationThreshold = 72.0;
  static const _horizontalFlingVelocity = 650.0;
  static const _horizontalFeedbackLimit = 24.0;
  static const _positionSaveDelay = Duration(milliseconds: 500);
  static const _chapterSettleDuration = Duration(milliseconds: 180);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _scrollController = ScrollController();
    _autoScrollTicker = createTicker(_handleAutoScrollTick);
    _chapterSlideController = AnimationController.unbounded(vsync: this);
    WidgetsBinding.instance.addPostFrameCallback((_) => _restorePosition());
  }

  @override
  void dispose() {
    _savePosition();
    WidgetsBinding.instance.removeObserver(this);
    _autoScrollTicker.dispose();
    _chapterSlideController.dispose();
    _positionSaveTimer?.cancel();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(VerseListView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.navigationFailed && !oldWidget.navigationFailed) {
      _restoreAfterNavigationFailure();
    }

    final chapterChanged =
        oldWidget.content.chapterNumber != widget.content.chapterNumber ||
        oldWidget.content.book.id != widget.content.book.id;
    final presentationChanged =
        oldWidget.content.translationCode != widget.content.translationCode ||
        oldWidget.content.parallelTranslationCode !=
            widget.content.parallelTranslationCode;
    if (chapterChanged || presentationChanged) {
      _verseKeys.clear();
      _chapterSlideController.stop();
      _chapterSlideController.value = 0;
      _edgeNavigating = false;
      WidgetsBinding.instance.addPostFrameCallback((_) => _restorePosition());
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.inactive ||
        state == AppLifecycleState.paused ||
        state == AppLifecycleState.detached) {
      _savePosition();
    }
  }

  void _startAutoScroll(double pixelsPerSecond) {
    _autoScrollPixelsPerSecond = pixelsPerSecond;
    _lastAutoScrollElapsed = null;
    if (!_autoScrollTicker.isActive) _autoScrollTicker.start();
  }

  void _stopAutoScroll() {
    if (_autoScrollTicker.isActive) _autoScrollTicker.stop();
    _lastAutoScrollElapsed = null;
  }

  void _handleAutoScrollTick(Duration elapsed) {
    if (!_scrollController.hasClients) {
      _lastAutoScrollElapsed = elapsed;
      return;
    }
    final previous = _lastAutoScrollElapsed;
    _lastAutoScrollElapsed = elapsed;
    if (previous == null) return;

    final seconds =
        (elapsed - previous).inMicroseconds.clamp(0, 50000) /
        Duration.microsecondsPerSecond;
    final current = _scrollController.offset;
    final max = _scrollController.position.maxScrollExtent;
    if (current >= max) {
      _stopAutoScroll();
      return;
    }
    _scrollController.jumpTo(
      (current + _autoScrollPixelsPerSecond * seconds).clamp(0.0, max),
    );
  }

  GlobalKey _keyForVerse(int verse) =>
      _verseKeys.putIfAbsent(verse, GlobalKey.new);

  Future<void> _restorePosition() async {
    if (!mounted || !_scrollController.hasClients) return;
    _restoringPosition = true;
    try {
      final reader = ref.read(bibleReaderProvider);
      final key = _verseKeys[reader.scrollVerse];
      final verseContext = key?.currentContext;

      if (verseContext != null) {
        await Scrollable.ensureVisible(verseContext);
        if (!mounted ||
            !verseContext.mounted ||
            !_scrollController.hasClients) {
          return;
        }
        final box = verseContext.findRenderObject() as RenderBox?;
        final fractionOffset = (box?.size.height ?? 0) * reader.scrollFraction;
        _scrollController.jumpTo(
          (_scrollController.offset + fractionOffset).clamp(
            0.0,
            _scrollController.position.maxScrollExtent,
          ),
        );
      } else {
        _scrollController.jumpTo(
          reader.scrollOffset.clamp(
            0.0,
            _scrollController.position.maxScrollExtent,
          ),
        );
      }
    } finally {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _restoringPosition = false;
      });
    }
  }

  void _schedulePositionSave() {
    if (_restoringPosition || _edgeNavigating) return;
    _positionSaveGeneration++;
    if (_positionSaveTimer == null) {
      final scheduledGeneration = _positionSaveGeneration;
      _positionSaveTimer = Timer(
        _positionSaveDelay,
        () => _savePositionWhenIdle(scheduledGeneration),
      );
    }
  }

  void _savePositionWhenIdle(int scheduledGeneration) {
    _positionSaveTimer = null;
    if (scheduledGeneration != _positionSaveGeneration) {
      final latestGeneration = _positionSaveGeneration;
      _positionSaveTimer = Timer(
        _positionSaveDelay,
        () => _savePositionWhenIdle(latestGeneration),
      );
      return;
    }
    _savePosition();
  }

  void _savePosition() {
    _positionSaveTimer?.cancel();
    _positionSaveTimer = null;
    if (!mounted || !_scrollController.hasClients || _restoringPosition) {
      return;
    }
    final reader = ref.read(bibleReaderProvider);
    if (reader.bookId != widget.content.book.id ||
        reader.chapter != widget.content.chapterNumber) {
      return;
    }
    final viewport =
        _viewportKey.currentContext?.findRenderObject() as RenderBox?;
    if (viewport == null) return;
    final viewportTop = viewport.localToGlobal(Offset.zero).dy;
    var visibleVerse = widget.content.verses.first.verseNumber;
    var fraction = 0.0;

    for (final verse in widget.content.verses) {
      final box =
          _verseKeys[verse.verseNumber]?.currentContext?.findRenderObject()
              as RenderBox?;
      if (box == null || !box.hasSize) continue;
      final top = box.localToGlobal(Offset.zero).dy;
      final bottom = top + box.size.height;
      if (bottom <= viewportTop + 1) continue;
      visibleVerse = verse.verseNumber;
      fraction =
          ((viewportTop - top) / box.size.height).clamp(0.0, 1.0).toDouble();
      break;
    }
    ref
        .read(bibleReaderProvider.notifier)
        .updateReadingPosition(
          verse: visibleVerse,
          fraction: fraction,
          offset: _scrollController.offset,
        );
  }

  bool _handleScrollNotification(
    ScrollNotification notification, {
    required bool autoScrollEnabled,
    required BibleReaderNotifier readerNotifier,
  }) {
    if (notification is ScrollEndNotification) {
      _schedulePositionSave();
    } else if (notification is ScrollUpdateNotification) {
      _schedulePositionSave();
    }

    if (notification is UserScrollNotification &&
        notification.direction != ScrollDirection.idle &&
        autoScrollEnabled) {
      readerNotifier.toggleAutoScroll();
    }
    return false;
  }

  void _handleHorizontalDragStart(DragStartDetails _) {
    if (_edgeNavigating) return;
    _chapterSlideController.stop();
    _horizontalDragDistance = 0;
  }

  void _handleHorizontalDragUpdate(DragUpdateDetails details) {
    if (_edgeNavigating) return;
    _horizontalDragDistance =
        (_horizontalDragDistance + (details.primaryDelta ?? 0))
            .clamp(-_viewportWidth, _viewportWidth)
            .toDouble();
    _chapterSlideController.value =
        (_horizontalDragDistance * 0.2)
            .clamp(-_horizontalFeedbackLimit, _horizontalFeedbackLimit)
            .toDouble();
  }

  void _handleHorizontalDragEnd(
    DragEndDetails details, {
    required VoidCallback? onPrevious,
    required VoidCallback? onNext,
  }) {
    if (_edgeNavigating) return;
    final velocity = details.primaryVelocity ?? 0;
    final dragDistance = _horizontalDragDistance;
    final isCommitted =
        dragDistance.abs() >= _horizontalNavigationThreshold ||
        velocity.abs() >= _horizontalFlingVelocity;
    if (!isCommitted) {
      unawaited(_settleChapterSlide());
      return;
    }

    final isNext =
        velocity.abs() >= _horizontalFlingVelocity
            ? velocity < 0
            : dragDistance < 0;
    final navigate = isNext ? onNext : onPrevious;
    if (navigate == null) {
      unawaited(_settleChapterSlide());
      return;
    }
    navigate();
  }

  double get _viewportWidth => _lastViewportWidth;

  void _beginChapterTransition(VoidCallback navigate) {
    if (_edgeNavigating) return;
    _savePosition();
    _edgeNavigating = true;
    navigate();
    unawaited(_settleChapterSlide());
  }

  Future<void> _settleChapterSlide() async {
    await _chapterSlideController.animateTo(
      0,
      duration: _chapterSettleDuration,
      curve: Curves.easeOutCubic,
    );
    _horizontalDragDistance = 0;
  }

  void _restoreAfterNavigationFailure() {
    unawaited(
      _chapterSlideController
          .animateTo(
            0,
            duration: _chapterSettleDuration,
            curve: Curves.easeOutCubic,
          )
          .whenComplete(() {
            if (mounted) _edgeNavigating = false;
          }),
    );
  }

  @override
  Widget build(BuildContext context) {
    _lastViewportWidth = MediaQuery.sizeOf(context).width;
    final readerState = ref.watch(
      bibleReaderProvider.select(
        (state) => (
          isParallelView: state.isParallelView,
          translationCode: state.translationCode,
          parallelTranslationCode: state.parallelTranslationCode,
          selectedVerseNumbers: state.selectedVerseNumbers,
          autoScrollEnabled: state.autoScrollEnabled,
        ),
      ),
    );
    final readerNotifier = ref.read(bibleReaderProvider.notifier);
    final autoScrollSpeed = ref.watch(
      settingsProvider.select((s) => s.autoScrollSpeed),
    );
    _autoScrollPixelsPerSecond = autoScrollSpeed;

    // 자동 스크롤 상태 변경 감지
    ref.listen<BibleReaderState>(bibleReaderProvider, (prev, next) {
      if (prev?.autoScrollEnabled != next.autoScrollEnabled) {
        if (next.autoScrollEnabled) {
          _startAutoScroll(autoScrollSpeed);
        } else {
          _stopAutoScroll();
        }
      }
    });

    final content = widget.content;
    final highlightParams = (
      bookId: content.book.id,
      chapter: content.chapterNumber,
      translation: content.translationCode,
    );
    final highlights =
        ref.watch(chapterHighlightsProvider(highlightParams)).valueOrNull ??
        const [];
    final highlightColors = {
      for (final highlight in highlights) highlight.verse: highlight.color,
    };
    final parallelView =
        readerState.isParallelView &&
        readerState.translationCode != readerState.parallelTranslationCode;
    final books = ref.watch(allBooksProvider).valueOrNull ?? const [];
    final currentBookIndex = books.indexWhere(
      (book) => book.id == content.book.id,
    );
    final previousBook =
        currentBookIndex > 0 ? books[currentBookIndex - 1] : null;
    final nextBook =
        currentBookIndex >= 0 && currentBookIndex < books.length - 1
            ? books[currentBookIndex + 1]
            : null;
    final previousLabel =
        content.hasPreviousChapter
            ? '${content.chapterNumber - 1}장'
            : previousBook == null
            ? null
            : '${previousBook.abbreviationKorean} ${previousBook.chapterCount}장';
    final nextLabel =
        content.hasNextChapter
            ? '${content.chapterNumber + 1}장'
            : nextBook == null
            ? null
            : '${nextBook.abbreviationKorean} 1장';
    final onPrevious =
        content.hasPreviousChapter
            ? () => readerNotifier.goToPreviousChapter()
            : previousBook == null
            ? null
            : () => readerNotifier.navigateTo(
              bookId: previousBook.id,
              chapter: previousBook.chapterCount,
            );
    final onNext =
        content.hasNextChapter
            ? () => readerNotifier.goToNextChapter(content.book.chapterCount)
            : nextBook == null
            ? null
            : () => readerNotifier.navigateTo(bookId: nextBook.id, chapter: 1);
    final transitionToPrevious =
        onPrevious == null ? null : () => _beginChapterTransition(onPrevious);
    final transitionToNext =
        onNext == null ? null : () => _beginChapterTransition(onNext);

    return GestureDetector(
      key: const ValueKey('chapter-swipe-detector'),
      behavior: HitTestBehavior.translucent,
      onHorizontalDragStart: _handleHorizontalDragStart,
      onHorizontalDragUpdate: _handleHorizontalDragUpdate,
      onHorizontalDragCancel: () => unawaited(_settleChapterSlide()),
      onHorizontalDragEnd:
          (details) => _handleHorizontalDragEnd(
            details,
            onPrevious: transitionToPrevious,
            onNext: transitionToNext,
          ),
      child: AnimatedBuilder(
        animation: _chapterSlideController,
        builder:
            (context, child) => Transform.translate(
              key: const ValueKey('chapter-slide-transform'),
              offset: Offset(_chapterSlideController.value, 0),
              child: child,
            ),
        child: NotificationListener<ScrollNotification>(
          onNotification:
              (notification) => _handleScrollNotification(
                notification,
                autoScrollEnabled: readerState.autoScrollEnabled,
                readerNotifier: readerNotifier,
              ),
          child: SingleChildScrollView(
            key: _viewportKey,
            controller: _scrollController,
            physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics(),
            ),
            child: Column(
              children: [
                for (final verse in content.verses)
                  RepaintBoundary(
                    key: _keyForVerse(verse.verseNumber),
                    child: VerseItem(
                      verse: verse,
                      parallelVerse:
                          parallelView
                              ? content.parallelVerseAt(verse.verseNumber)
                              : null,
                      highlightColorCode: highlightColors[verse.verseNumber],
                      isSelected: readerState.selectedVerseNumbers.contains(
                        verse.verseNumber,
                      ),
                      isSelectionMode:
                          readerState.selectedVerseNumbers.isNotEmpty,
                    ),
                  ),
                _ChapterNavigation(
                  content: content,
                  previousLabel: previousLabel,
                  nextLabel: nextLabel,
                  onPrevious: transitionToPrevious,
                  onNext: transitionToNext,
                ),
                const SizedBox(height: AppSpacing.xxxxl),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ── Chapter Navigation ─────────────────────────────────────────────────

class _ChapterNavigation extends StatelessWidget {
  const _ChapterNavigation({
    required this.content,
    required this.previousLabel,
    required this.nextLabel,
    this.onPrevious,
    this.onNext,
  });

  final ChapterContent content;
  final String? previousLabel;
  final String? nextLabel;
  final VoidCallback? onPrevious;
  final VoidCallback? onNext;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.lg,
        vertical: AppSpacing.xxl,
      ),
      child: Row(
        children: [
          // 이전 장
          Expanded(
            child:
                onPrevious != null
                    ? OutlinedButton.icon(
                      onPressed: onPrevious,
                      icon: const Icon(Icons.chevron_left_rounded),
                      label: Text(
                        previousLabel!,
                        overflow: TextOverflow.ellipsis,
                      ),
                    )
                    : const SizedBox.shrink(),
          ),
          const SizedBox(width: AppSpacing.md),
          // 현재 장 표시
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.md,
              vertical: AppSpacing.xs,
            ),
            decoration: BoxDecoration(
              color: colorScheme.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
            ),
            child: Text(
              '${content.chapterNumber}장',
              style: TextStyle(
                color: colorScheme.onSurfaceVariant,
                fontSize: 12,
              ),
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          // 다음 장
          Expanded(
            child:
                onNext != null
                    ? OutlinedButton.icon(
                      onPressed: onNext,
                      icon: const Icon(Icons.chevron_right_rounded),
                      iconAlignment: IconAlignment.end,
                      label: Text(nextLabel!, overflow: TextOverflow.ellipsis),
                    )
                    : const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }
}
