// lib/features/bible/presentation/widgets/verse_list_view.dart
// [NEW] 장(Chapter) 전체 스크롤 뷰 — 자동 스크롤 포함

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../theme/app_spacing.dart';
import '../../../settings/presentation/providers/settings_provider.dart';
import '../../domain/entities/chapter_content.dart';
import '../providers/bible_reader_provider.dart';
import 'verse_item.dart';

/// 장 전체를 스크롤 가능한 리스트 뷰로 표시.
/// 자동 스크롤, 다음/이전 장 네비게이션 포함.
class VerseListView extends ConsumerStatefulWidget {
  const VerseListView({
    required this.content,
    super.key,
  });

  final ChapterContent content;

  @override
  ConsumerState<VerseListView> createState() => _VerseListViewState();
}

class _VerseListViewState extends ConsumerState<VerseListView> {
  late final ScrollController _scrollController;
  Timer? _autoScrollTimer;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _autoScrollTimer?.cancel();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(VerseListView oldWidget) {
    super.didUpdateWidget(oldWidget);
    // 장이 변경되면 맨 위로 스크롤
    if (oldWidget.content.chapterNumber != widget.content.chapterNumber ||
        oldWidget.content.book.id != widget.content.book.id) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (_scrollController.hasClients) {
          _scrollController.jumpTo(0);
        }
      });
    }
  }

  void _startAutoScroll(double pixelsPerSecond) {
    _autoScrollTimer?.cancel();
    _autoScrollTimer = Timer.periodic(
      const Duration(milliseconds: 50),
      (_) {
        if (!_scrollController.hasClients) return;
        final current = _scrollController.offset;
        final max = _scrollController.position.maxScrollExtent;
        if (current >= max) {
          _autoScrollTimer?.cancel();
          return;
        }
        _scrollController.jumpTo(
          (current + pixelsPerSecond / 20).clamp(0, max),
        );
      },
    );
  }

  void _stopAutoScroll() {
    _autoScrollTimer?.cancel();
    _autoScrollTimer = null;
  }

  @override
  Widget build(BuildContext context) {
    final readerState = ref.watch(bibleReaderProvider);
    final readerNotifier = ref.read(bibleReaderProvider.notifier);
    final autoScrollSpeed = ref.watch(
      settingsProvider.select((s) => s.autoScrollSpeed),
    );

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
    final parallelView = readerState.isParallelView &&
        readerState.translationCode != readerState.parallelTranslationCode;

    return NotificationListener<ScrollNotification>(
      // 사용자가 스크롤하면 자동 스크롤 중지
      onNotification: (notification) {
        if (notification is UserScrollNotification &&
            readerState.autoScrollEnabled) {
          readerNotifier.toggleAutoScroll();
        }
        return false;
      },
      child: CustomScrollView(
        controller: _scrollController,
        physics: const BouncingScrollPhysics(),
        slivers: [
          // 절 목록
          SliverList.builder(
            itemCount: content.verseCount,
            itemBuilder: (context, index) {
              final verse = content.verses[index];
              final parallel = parallelView
                  ? content.parallelVerseAt(verse.verseNumber)
                  : null;

              return VerseItem(
                key: ValueKey('${verse.bookId}:${verse.chapter}:${verse.verseNumber}'),
                verse: verse,
                parallelVerse: parallel,
                isSelected:
                    readerState.selectedVerseNumber == verse.verseNumber,
              );
            },
          ),

          // 장 네비게이션 버튼
          SliverToBoxAdapter(
            child: _ChapterNavigation(
              content: content,
              onPrevious: content.hasPreviousChapter
                  ? () => readerNotifier.goToPreviousChapter()
                  : null,
              onNext: content.hasNextChapter
                  ? () => readerNotifier.goToNextChapter(
                        content.book.chapterCount,
                      )
                  : null,
            ),
          ),

          const SliverToBoxAdapter(
            child: SizedBox(height: AppSpacing.xxxxl),
          ),
        ],
      ),
    );
  }
}

// ── Chapter Navigation ─────────────────────────────────────────────────

class _ChapterNavigation extends StatelessWidget {
  const _ChapterNavigation({
    required this.content,
    this.onPrevious,
    this.onNext,
  });

  final ChapterContent content;
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
            child: onPrevious != null
                ? OutlinedButton.icon(
                    onPressed: onPrevious,
                    icon: const Icon(Icons.chevron_left_rounded),
                    label: Text(
                      '${content.chapterNumber - 1}장',
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
            child: onNext != null
                ? OutlinedButton.icon(
                    onPressed: onNext,
                    icon: const Icon(Icons.chevron_right_rounded),
                    iconAlignment: IconAlignment.end,
                    label: Text(
                      '${content.chapterNumber + 1}장',
                      overflow: TextOverflow.ellipsis,
                    ),
                  )
                : const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }
}
