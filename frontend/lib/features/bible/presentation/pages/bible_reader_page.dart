// lib/features/bible/presentation/pages/bible_reader_page.dart
// [MODIFY] 성경 읽기 메인 화면 — 완전 구현

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:share_plus/share_plus.dart';

import '../../../../routes/route_names.dart';
import '../../../../shared/widgets/loading_indicator.dart';
import '../../../../theme/app_spacing.dart';
import '../../../../theme/app_typography.dart';
import '../../../dictionary/presentation/widgets/dictionary_bottom_sheet.dart';
import '../../../highlights/presentation/pages/bookmarks_page.dart';
import '../../../highlights/presentation/providers/highlights_providers.dart';
import '../../../highlights/presentation/widgets/highlight_color_picker.dart';
import '../../../settings/presentation/providers/settings_provider.dart';
import '../../domain/entities/chapter_content.dart';
import '../../domain/entities/verse.dart';
import '../../domain/services/bible_share_formatter.dart';
import '../providers/bible_providers.dart';
import '../providers/bible_reader_provider.dart';
import '../providers/reading_tabs_provider.dart';
import '../widgets/bible_reading_tabs_bar.dart';
import '../widgets/book_selector_sheet.dart';
import '../widgets/verse_list_view.dart';

class BibleReaderPage extends ConsumerWidget {
  const BibleReaderPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(readingTabsAutoSaveProvider);
    final chapterAsync = ref.watch(currentChapterProvider);

    // 단어 탭 → 바텀시트 트리거
    ref.listen<BibleReaderState>(bibleReaderProvider, (_, next) {
      if (next.tappedWord != null && context.mounted) {
        DictionaryBottomSheet.show(
          context,
          next.tappedWord!,
          bookId: next.tappedBookId ?? 0,
          chapter: next.tappedChapter ?? 0,
          verse: next.tappedVerse ?? 0,
          translationCode: next.tappedTranslationCode ?? 'KJV',
        );
        ref.read(bibleReaderProvider.notifier).clearWordTap();
      }
    });

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: const _BibleAppBar(),
      body: chapterAsync.when(
        loading: () => const _LoadingBody(),
        error: (error, _) => _ErrorBody(message: error.toString()),
        data: (content) => _ReaderBody(content: content),
      ),
      bottomNavigationBar: const BibleReadingTabsBar(),
      floatingActionButton: chapterAsync.whenOrNull(
        data: (content) => _AutoScrollFAB(content: content),
      ),
    );
  }
}

// ── App Bar ───────────────────────────────────────────────────────────

class _BibleAppBar extends ConsumerStatefulWidget
    implements PreferredSizeWidget {
  const _BibleAppBar();

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
    final readerState = ref.watch(
      bibleReaderProvider.select(
        (state) => (
          chapter: state.chapter,
          translationCode: state.translationCode,
          isParallelView: state.isParallelView,
        ),
      ),
    );

    final bookName =
        chapterAsync.whenOrNull(data: (c) => c.book.nameKorean) ?? '';
    final chapter = readerState.chapter;

    return AppBar(
      titleSpacing: AppSpacing.md,
      title: GestureDetector(
        onTap: () => BookSelectorSheet.show(context),
        child: FittedBox(
          key: const ValueKey('bible-reader-title'),
          fit: BoxFit.scaleDown,
          alignment: Alignment.centerLeft,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.menu_book_rounded,
                color: colorScheme.primary,
                size: AppSpacing.iconMd,
              ),
              const SizedBox(width: AppSpacing.sm),
              Text(
                bookName.isNotEmpty ? '$bookName $chapter장' : '성경 읽기',
                style: AppTypography.titleLarge.copyWith(
                  color: colorScheme.onSurface,
                ),
                maxLines: 1,
                softWrap: false,
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
              readerState.translationCode,
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
            readerState.isParallelView
                ? Icons.view_agenda_rounded
                : Icons.view_column_rounded,
            color: readerState.isParallelView ? colorScheme.primary : null,
          ),
          onPressed: () => notifier.toggleParallelView(),
          tooltip: '대역 보기',
        ),

        // 더보기 메뉴
        PopupMenuButton<_MenuAction>(
          icon: const Icon(Icons.more_vert_rounded),
          onSelected: _onMenuAction,
          itemBuilder:
              (_) => [
                const PopupMenuItem(
                  value: _MenuAction.readingSettings,
                  child: Row(
                    children: [
                      Icon(Icons.text_fields_rounded, size: 20),
                      SizedBox(width: 12),
                      Text('읽기 설정'),
                    ],
                  ),
                ),
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
                  value: _MenuAction.vocabulary,
                  child: Row(
                    children: [
                      Icon(Icons.auto_stories_rounded, size: 20),
                      SizedBox(width: 12),
                      Text('단어장'),
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
                  value: _MenuAction.settings,
                  child: Row(
                    children: [
                      Icon(Icons.settings_rounded, size: 20),
                      SizedBox(width: 12),
                      Text('설정'),
                    ],
                  ),
                ),
                const PopupMenuItem(
                  value: _MenuAction.bookmarks,
                  child: Row(
                    children: [
                      Icon(Icons.bookmarks_rounded, size: 20),
                      SizedBox(width: 12),
                      Text('북마크'),
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
    final current = ref.read(bibleReaderProvider).translationCode;
    showModalBottomSheet<void>(
      context: context,
      builder:
          (_) => _TranslationPicker(
            current: current,
            onSelect: notifier.setTranslation,
          ),
    );
  }

  Future<void> _onMenuAction(_MenuAction action) async {
    final notifier = ref.read(bibleReaderProvider.notifier);
    switch (action) {
      case _MenuAction.readingSettings:
        await showModalBottomSheet<void>(
          context: context,
          useSafeArea: true,
          builder: (_) => const _ReadingSettingsSheet(),
        );
      case _MenuAction.autoScroll:
        notifier.toggleAutoScroll();
      case _MenuAction.vocabulary:
        await context.push(RoutePaths.vocabulary);
      case _MenuAction.search:
        await context.push(RoutePaths.search);
      case _MenuAction.settings:
        await context.push(RoutePaths.settings);
      case _MenuAction.bookmarks:
        await Navigator.of(
          context,
        ).push<void>(MaterialPageRoute(builder: (_) => const BookmarksPage()));
      case _MenuAction.share:
        final content = ref.read(currentChapterProvider).valueOrNull;
        if (content == null) {
          if (mounted) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(const SnackBar(content: Text('본문을 불러온 뒤 다시 시도하세요')));
          }
          return;
        }
        await SharePlus.instance.share(
          ShareParams(
            text: BibleShareFormatter.chapter(content),
            subject: '${content.book.nameKorean} ${content.chapterNumber}장',
          ),
        );
    }
  }
}

enum _MenuAction {
  readingSettings,
  autoScroll,
  vocabulary,
  search,
  settings,
  bookmarks,
  share,
}

class _ReadingSettingsSheet extends ConsumerWidget {
  const _ReadingSettingsSheet();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsProvider);
    final settingsNotifier = ref.read(settingsProvider.notifier);
    final parallelView = ref.watch(
      bibleReaderProvider.select((state) => state.isParallelView),
    );
    final readerNotifier = ref.read(bibleReaderProvider.notifier);
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.lg,
        AppSpacing.md,
        AppSpacing.lg,
        AppSpacing.xl,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              const Text('읽기 설정', style: AppTypography.titleMedium),
              const Spacer(),
              IconButton(
                tooltip: '닫기',
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.close_rounded),
              ),
            ],
          ),
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: const Icon(Icons.format_size_rounded),
            title: const Text('글자 크기'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  tooltip: '글자 작게',
                  onPressed:
                      settings.fontSize <= 12
                          ? null
                          : () => settingsNotifier.setFontSize(
                            settings.fontSize - 1,
                          ),
                  icon: const Icon(Icons.remove_rounded),
                ),
                SizedBox(
                  width: 42,
                  child: Text(
                    '${settings.fontSize.round()}',
                    textAlign: TextAlign.center,
                    style: AppTypography.titleMedium.copyWith(
                      color: colorScheme.primary,
                    ),
                  ),
                ),
                IconButton(
                  tooltip: '글자 크게',
                  onPressed:
                      settings.fontSize >= 32
                          ? null
                          : () => settingsNotifier.setFontSize(
                            settings.fontSize + 1,
                          ),
                  icon: const Icon(Icons.add_rounded),
                ),
              ],
            ),
          ),
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: const Icon(Icons.format_line_spacing_rounded),
            title: const Text('줄 간격'),
            subtitle: Slider(
              value: settings.lineSpacing.clamp(1.4, 2.5),
              min: 1.4,
              max: 2.5,
              divisions: 11,
              label: settings.lineSpacing.toStringAsFixed(1),
              onChanged: settingsNotifier.setLineSpacing,
            ),
            trailing: Text(settings.lineSpacing.toStringAsFixed(1)),
          ),
          SwitchListTile(
            contentPadding: EdgeInsets.zero,
            secondary: const Icon(Icons.format_list_numbered_rounded),
            title: const Text('절 번호 표시'),
            value: settings.showVerseNumbers,
            onChanged: (_) => settingsNotifier.toggleShowVerseNumbers(),
          ),
          SwitchListTile(
            contentPadding: EdgeInsets.zero,
            secondary: const Icon(Icons.view_agenda_rounded),
            title: const Text('대역 보기'),
            value: parallelView,
            onChanged: (_) => readerNotifier.toggleParallelView(),
          ),
        ],
      ),
    );
  }
}

// ── Body ──────────────────────────────────────────────────────────────

class _ReaderBody extends ConsumerWidget {
  const _ReaderBody({required this.content});

  final ChapterContent content;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedVerseNumbers = ref.watch(
      bibleReaderProvider.select((state) => state.selectedVerseNumbers),
    );
    final selectedVerses = [
      for (final number in selectedVerseNumbers)
        if (content.verseAt(number) case final verse?) verse,
    ]..sort((left, right) => left.verseNumber.compareTo(right.verseNumber));

    // 절 선택 시 바텀 액션 바 표시
    return Stack(
      children: [
        VerseListView(content: content),

        // 절 선택 액션 바
        if (selectedVerses.isNotEmpty)
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: _VerseActionBar(
              bookId: content.book.id,
              chapter: content.chapterNumber,
              translationCode: content.translationCode,
              bookName: content.book.nameKorean,
              verses: selectedVerses,
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
    required this.bookId,
    required this.chapter,
    required this.translationCode,
    required this.bookName,
    required this.verses,
  });

  final int bookId;
  final int chapter;
  final String translationCode;
  final String bookName;
  final List<Verse> verses;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    final notifier = ref.read(bibleReaderProvider.notifier);
    final singleVerse = verses.length == 1 ? verses.single : null;
    const buttonConstraints = BoxConstraints.tightFor(width: 40, height: 40);
    final formatted = BibleShareFormatter.verses(
      bookName: bookName,
      verses: verses,
    );

    return Container(
      padding: EdgeInsets.only(
        left: AppSpacing.lg,
        right: AppSpacing.lg,
        top: AppSpacing.md,
        bottom: AppSpacing.md + MediaQuery.of(context).viewInsets.bottom,
      ),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHigh,
        border: Border(
          top: BorderSide(color: colorScheme.outlineVariant.withAlpha(60)),
        ),
      ),
      child: Row(
        children: [
          Text(
            '${verses.length}절 선택',
            style: AppTypography.labelMedium.copyWith(
              color: colorScheme.onSurface,
            ),
          ),
          const Spacer(),
          IconButton(
            icon: const Icon(Icons.highlight_rounded),
            tooltip: singleVerse == null ? '형광펜은 한 절씩 적용' : '형광펜',
            constraints: buttonConstraints,
            visualDensity: VisualDensity.compact,
            onPressed:
                singleVerse == null
                    ? null
                    : () async {
                      final colorLabel = await HighlightColorPicker.show(
                        context,
                        bookId: bookId,
                        chapter: chapter,
                        verse: singleVerse.verseNumber,
                        translationCode: translationCode,
                        verseText: singleVerse.text,
                      );
                      notifier.clearVerseSelection();
                      if (context.mounted && colorLabel != null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('$colorLabel 형광펜이 적용되었습니다'),
                            behavior: SnackBarBehavior.floating,
                          ),
                        );
                      }
                    },
          ),
          IconButton(
            icon: const Icon(Icons.bookmark_add_rounded),
            tooltip: '북마크',
            constraints: buttonConstraints,
            visualDensity: VisualDensity.compact,
            onPressed: () async {
              for (final verse in verses) {
                await ref
                    .read(highlightActionProvider.notifier)
                    .addBookmark(
                      bookId: bookId,
                      chapter: chapter,
                      verse: verse.verseNumber,
                      translationCode: translationCode,
                    );
              }
              notifier.clearVerseSelection();
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('선택한 절을 북마크에 저장했습니다'),
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              }
            },
          ),
          IconButton(
            icon: const Icon(Icons.copy_rounded),
            tooltip: '선택한 절 복사',
            constraints: buttonConstraints,
            visualDensity: VisualDensity.compact,
            onPressed: () async {
              await Clipboard.setData(ClipboardData(text: formatted));
              notifier.clearVerseSelection();
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('선택한 절을 복사했습니다'),
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              }
            },
          ),
          IconButton(
            icon: const Icon(Icons.share_rounded),
            tooltip: '공유',
            constraints: buttonConstraints,
            visualDensity: VisualDensity.compact,
            onPressed: () async {
              await SharePlus.instance.share(
                ShareParams(
                  text: formatted,
                  subject:
                      '$bookName $chapter '
                      '${verses.map((verse) => verse.verseNumber).join(',')}절',
                ),
              );
              notifier.clearVerseSelection();
            },
          ),
          // 닫기
          IconButton(
            icon: const Icon(Icons.close_rounded),
            tooltip: '선택 취소',
            constraints: buttonConstraints,
            visualDensity: VisualDensity.compact,
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
      onPressed:
          () => ref.read(bibleReaderProvider.notifier).toggleAutoScroll(),
      tooltip: '자동 스크롤 중지',
      child: const Icon(Icons.pause_rounded),
    );
  }
}

// ── Translation Picker ────────────────────────────────────────────────

class _TranslationPicker extends StatelessWidget {
  const _TranslationPicker({required this.current, required this.onSelect});

  final String current;
  final void Function(String) onSelect;

  static const _translations = [
    ('KJV', 'King James Version', '영어 (공개 도메인)'),
    ('KOREAN_RV', '개역한글', '한국어 (공개 도메인)'),
  ];

  @override
  Widget build(BuildContext context) {
    return RadioGroup<String>(
      groupValue: current,
      onChanged: (value) {
        if (value == null) return;
        onSelect(value);
        Navigator.pop(context);
      },
      child: Column(
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
            ),
          ),
          const SizedBox(height: AppSpacing.xl),
        ],
      ),
    );
  }
}
