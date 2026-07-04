// lib/features/bible/presentation/pages/bible_reader_page.dart
// [MODIFY] 성경 읽기 메인 화면 — 완전 구현

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../shared/widgets/bible_error_widget.dart';
import '../../../../shared/widgets/loading_indicator.dart';
import '../../../../theme/app_colors.dart';
import '../../../../theme/app_spacing.dart';
import '../../../../theme/app_typography.dart';
import '../../../settings/presentation/providers/settings_provider.dart';
import '../../domain/entities/chapter_content.dart';
import '../providers/bible_providers.dart';
import '../providers/bible_reader_provider.dart';
import '../widgets/book_selector_sheet.dart';
import '../widgets/verse_list_view.dart';
import '../widgets/word_tap_bottom_sheet.dart';

class BibleReaderPage extends ConsumerWidget {
  const BibleReaderPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final readerState = ref.watch(bibleReaderProvider);
    final chapterAsync = ref.watch(currentChapterProvider);
    final settings = ref.watch(settingsProvider);

    // 단어 탭 → 바텀시트 트리거
    ref.listen<BibleReaderState>(bibleReaderProvider, (_, next) {
      if (next.tappedWord != null && context.mounted) {
        WordTapBottomSheet.show(context, next.tappedWord!);
        ref.read(bibleReaderProvider.notifier).clearWordTap();
      }
    });

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: _BibleAppBar(readerState: readerState, settings: settings),
      body: chapterAsync.when(
        loading: () => const _LoadingBody(),
        error: (error, _) => _ErrorBody(message: error.toString()),
        data: (content) => _ReaderBody(content: content),
      ),
      floatingActionButton: chapterAsync.whenOrNull(
        data: (content) => _AutoScrollFAB(content: content),
      ),
    );
  }
}

// ── App Bar ───────────────────────────────────────────────────────────

class _BibleAppBar extends ConsumerStatefulWidget
    implements PreferredSizeWidget {
  const _BibleAppBar({
    required this.readerState,
    required this.settings,
  });

  final BibleReaderState readerState;
  final dynamic settings; // AppSettings

  @override
  Size get preferredSize => const Size.fromHeight(AppSpacing.appBarHeight);

  @override
  ConsumerState<_BibleAppBar> createState() => _BibleAppBarState();
}

class _BibleAppBarState extends ConsumerState<_BibleAppBar> {
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final chapterAsync = ref.watch(currentChapterProvider);
    final notifier = ref.read(bibleReaderProvider.notifier);

    final bookName = chapterAsync.whenOrNull(
          data: (c) => c.book.nameKorean,
        ) ??
        '';
    final chapter = widget.readerState.chapter;

    return AppBar(
      titleSpacing: AppSpacing.md,
      title: GestureDetector(
        onTap: () => BookSelectorSheet.show(context),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.menu_book_rounded,
              color: colorScheme.primary,
              size: AppSpacing.iconMd,
            ),
            const SizedBox(width: AppSpacing.sm),
            Flexible(
              child: Text(
                bookName.isNotEmpty ? '$bookName $chapter장' : '성경 읽기',
                style: AppTypography.titleLarge.copyWith(
                  color: colorScheme.onSurface,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(width: AppSpacing.xs),
            Icon(
              Icons.expand_more_rounded,
              size: 18,
              color: colorScheme.onSurfaceVariant,
            ),
          ],
        ),
      ),
      actions: [
        // 번역본 배지
        GestureDetector(
          onTap: _showTranslationMenu,
          child: Container(
            margin: const EdgeInsets.only(right: AppSpacing.xs),
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.sm,
              vertical: 4,
            ),
            decoration: BoxDecoration(
              color: colorScheme.primaryContainer,
              borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
            ),
            child: Text(
              widget.readerState.translationCode,
              style: AppTypography.labelMedium.copyWith(
                color: colorScheme.onPrimaryContainer,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),

        // 대역 보기 토글
        IconButton(
          icon: Icon(
            widget.readerState.isParallelView
                ? Icons.view_agenda_rounded
                : Icons.view_column_rounded,
            color: widget.readerState.isParallelView
                ? colorScheme.primary
                : null,
          ),
          onPressed: () => notifier.toggleParallelView(),
          tooltip: '대역 보기',
        ),

        // 더보기 메뉴
        PopupMenuButton<_MenuAction>(
          icon: const Icon(Icons.more_vert_rounded),
          onSelected: _onMenuAction,
          itemBuilder: (_) => [
            const PopupMenuItem(
              value: _MenuAction.autoScroll,
              child: Row(
                children: [
                  Icon(Icons.swap_vert_rounded, size: 20),
                  SizedBox(width: 12),
                  Text('자동 스크롤'),
                ],
              ),
            ),
            const PopupMenuItem(
              value: _MenuAction.search,
              child: Row(
                children: [
                  Icon(Icons.search_rounded, size: 20),
                  SizedBox(width: 12),
                  Text('검색'),
                ],
              ),
            ),
            const PopupMenuItem(
              value: _MenuAction.share,
              child: Row(
                children: [
                  Icon(Icons.share_rounded, size: 20),
                  SizedBox(width: 12),
                  Text('공유'),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  void _showTranslationMenu() {
    final notifier = ref.read(bibleReaderProvider.notifier);
    showModalBottomSheet<void>(
      context: context,
      builder: (_) => _TranslationPicker(
        current: widget.readerState.translationCode,
        onSelect: notifier.setTranslation,
      ),
    );
  }

  void _onMenuAction(_MenuAction action) {
    final notifier = ref.read(bibleReaderProvider.notifier);
    switch (action) {
      case _MenuAction.autoScroll:
        notifier.toggleAutoScroll();
      case _MenuAction.search:
        // TASK 7 에서 구현
        break;
      case _MenuAction.share:
        // TASK 8 에서 구현
        break;
    }
  }
}

enum _MenuAction { autoScroll, search, share }

// ── Body ──────────────────────────────────────────────────────────────

class _ReaderBody extends ConsumerWidget {
  const _ReaderBody({required this.content});

  final ChapterContent content;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final readerState = ref.watch(bibleReaderProvider);

    // 절 선택 시 바텀 액션 바 표시
    return Stack(
      children: [
        VerseListView(content: content),

        // 절 선택 액션 바
        if (readerState.selectedVerseNumber != null)
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: _VerseActionBar(
              verseNumber: readerState.selectedVerseNumber!,
              bookId: content.book.id,
              chapter: content.chapterNumber,
              translationCode: content.translationCode,
            ),
          ),
      ],
    );
  }
}

class _LoadingBody extends StatelessWidget {
  const _LoadingBody();

  @override
  Widget build(BuildContext context) {
    return const Center(child: InlineLoader());
  }
}

class _ErrorBody extends StatelessWidget {
  const _ErrorBody({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xxl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.library_books_outlined,
              size: 64,
              color: colorScheme.onSurfaceVariant,
            ),
            const SizedBox(height: AppSpacing.lg),
            Text(
              '성경 데이터를 불러올 수 없습니다',
              style: AppTypography.titleMedium.copyWith(
                color: colorScheme.onSurface,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              '앱 초기화 후 성경 데이터를 임포트해야 합니다.\n\n$message',
              style: AppTypography.bodySmall.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

// ── Verse Action Bar ──────────────────────────────────────────────────

class _VerseActionBar extends ConsumerWidget {
  const _VerseActionBar({
    required this.verseNumber,
    required this.bookId,
    required this.chapter,
    required this.translationCode,
  });

  final int verseNumber;
  final int bookId;
  final int chapter;
  final String translationCode;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    final notifier = ref.read(bibleReaderProvider.notifier);

    return Container(
      padding: EdgeInsets.only(
        left: AppSpacing.lg,
        right: AppSpacing.lg,
        top: AppSpacing.md,
        bottom: AppSpacing.md +
            MediaQuery.of(context).viewInsets.bottom,
      ),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHigh,
        border: Border(
          top: BorderSide(
            color: colorScheme.outlineVariant.withAlpha(60),
          ),
        ),
      ),
      child: Row(
        children: [
          Text(
            '$verseNumber절 선택됨',
            style: AppTypography.labelMedium.copyWith(
              color: colorScheme.onSurface,
            ),
          ),
          const Spacer(),
          // 형광펜 (TASK 6)
          IconButton(
            icon: const Icon(Icons.highlight_rounded),
            tooltip: '형광펜',
            onPressed: () {
              notifier.clearVerseSelection();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('형광펜 기능은 TASK 6에서 구현됩니다'),
                  behavior: SnackBarBehavior.floating,
                ),
              );
            },
          ),
          // 북마크 (TASK 6)
          IconButton(
            icon: const Icon(Icons.bookmark_add_rounded),
            tooltip: '북마크',
            onPressed: () {
              notifier.clearVerseSelection();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('북마크 기능은 TASK 6에서 구현됩니다'),
                  behavior: SnackBarBehavior.floating,
                ),
              );
            },
          ),
          // 공유
          IconButton(
            icon: const Icon(Icons.share_rounded),
            tooltip: '공유',
            onPressed: () => notifier.clearVerseSelection(),
          ),
          // 닫기
          IconButton(
            icon: const Icon(Icons.close_rounded),
            onPressed: notifier.clearVerseSelection,
          ),
        ],
      ),
    );
  }
}

// ── Auto Scroll FAB ───────────────────────────────────────────────────

class _AutoScrollFAB extends ConsumerWidget {
  const _AutoScrollFAB({required this.content});

  final ChapterContent content;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final autoScrollEnabled = ref.watch(
      bibleReaderProvider.select((s) => s.autoScrollEnabled),
    );

    if (!autoScrollEnabled) return const SizedBox.shrink();

    return FloatingActionButton.small(
      onPressed: () =>
          ref.read(bibleReaderProvider.notifier).toggleAutoScroll(),
      tooltip: '자동 스크롤 중지',
      child: const Icon(Icons.pause_rounded),
    );
  }
}

// ── Translation Picker ────────────────────────────────────────────────

class _TranslationPicker extends StatelessWidget {
  const _TranslationPicker({
    required this.current,
    required this.onSelect,
  });

  final String current;
  final void Function(String) onSelect;

  static const _translations = [
    ('KJV', 'King James Version', '영어 (공개 도메인)'),
    ('KOREAN_RV', '개역한글', '한국어 (공개 도메인)'),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: AppSpacing.lg),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
          child: Text(
            '번역본 선택',
            style: AppTypography.titleMedium.copyWith(
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        ..._translations.map(
          (t) => RadioListTile<String>(
            title: Text(t.$2),
            subtitle: Text(t.$3),
            value: t.$1,
            groupValue: current,
            onChanged: (v) {
              if (v != null) {
                onSelect(v);
                Navigator.pop(context);
              }
            },
          ),
        ),
        const SizedBox(height: AppSpacing.xl),
      ],
    );
  }
}
