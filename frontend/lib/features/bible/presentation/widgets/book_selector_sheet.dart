// lib/features/bible/presentation/widgets/book_selector_sheet.dart
// [NEW] 성경 66권 선택 바텀시트 — 구약/신약 탭 + 검색

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../theme/app_spacing.dart';
import '../../../../theme/app_typography.dart';
import '../../domain/entities/book.dart';
import '../providers/bible_providers.dart';
import '../providers/bible_reader_provider.dart';

/// 성경 책(Book) 선택 바텀시트.
/// 탭 선택 후 장(chapter) 선택 시트로 이어진다.
class BookSelectorSheet extends ConsumerStatefulWidget {
  const BookSelectorSheet({super.key});

  static Future<void> show(BuildContext context) async {
    final selectedBook = await showModalBottomSheet<Book?>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (_) => const BookSelectorSheet(),
    );

    if (selectedBook != null && context.mounted) {
      Future.delayed(const Duration(milliseconds: 150), () {
        if (context.mounted) {
          ChapterSelectorSheet.show(context, book: selectedBook);
        }
      });
    }
  }

  @override
  ConsumerState<BookSelectorSheet> createState() => _BookSelectorSheetState();
}

class _BookSelectorSheetState extends ConsumerState<BookSelectorSheet>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  final _searchController = TextEditingController();
  String _query = '';

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final groupedAsync = ref.watch(booksGroupedProvider);

    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.88,
      minChildSize: 0.5,
      maxChildSize: 0.95,
      builder: (_, scrollController) => Column(
        children: [
          // ── 핸들 ──────────────────────────────────────────────────
          const SizedBox(height: AppSpacing.sm),
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: colorScheme.outlineVariant,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.lg),

          // ── 헤더 ──────────────────────────────────────────────────
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
            child: Row(
              children: [
                Text(
                  '성경 목록',
                  style: AppTypography.titleLarge.copyWith(
                    color: colorScheme.onSurface,
                  ),
                ),
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.close_rounded),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
          ),

          // ── 검색 ──────────────────────────────────────────────────
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.lg,
              vertical: AppSpacing.sm,
            ),
            child: TextField(
              controller: _searchController,
              onChanged: (v) => setState(() => _query = v.toLowerCase()),
              decoration: InputDecoration(
                hintText: '성경 이름 검색…',
                prefixIcon: const Icon(Icons.search_rounded, size: 20),
                suffixIcon: _query.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear_rounded, size: 18),
                        onPressed: () {
                          _searchController.clear();
                          setState(() => _query = '');
                        },
                      )
                    : null,
                isDense: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: colorScheme.surfaceContainerHighest,
              ),
            ),
          ),

          // ── OT / NT 탭 ───────────────────────────────────────────
          if (_query.isEmpty)
            TabBar(
              controller: _tabController,
              tabs: const [
                Tab(text: '구약 (39권)'),
                Tab(text: '신약 (27권)'),
              ],
            ),

          // ── 책 목록 ──────────────────────────────────────────────
          Expanded(
            child: groupedAsync.when(
              loading: () => const Center(
                child: CircularProgressIndicator(),
              ),
              error: (e, _) => Center(child: Text('오류: $e')),
              data: (grouped) {
                if (_query.isNotEmpty) {
                  // 검색 결과
                  final all = grouped.all
                      .where(
                        (b) =>
                            b.name.toLowerCase().contains(_query) ||
                            b.nameKorean.contains(_query),
                      )
                      .toList();
                  return _BookGrid(
                    books: all,
                    onSelect: _onBookSelect,
                  );
                }
                return TabBarView(
                  controller: _tabController,
                  children: [
                    _BookGrid(
                      books: grouped.oldTestament,
                      onSelect: _onBookSelect,
                    ),
                    _BookGrid(
                      books: grouped.newTestament,
                      onSelect: _onBookSelect,
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _onBookSelect(Book book) {
    Navigator.pop(context, book);
  }
}

// ── Book Grid ─────────────────────────────────────────────────────────

class _BookGrid extends ConsumerWidget {
  const _BookGrid({
    required this.books,
    required this.onSelect,
  });

  final List<Book> books;
  final void Function(Book) onSelect;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    final currentBookId =
        ref.watch(bibleReaderProvider.select((s) => s.bookId));

    if (books.isEmpty) {
      return const Center(child: Text('검색 결과가 없습니다'));
    }

    return GridView.builder(
      padding: const EdgeInsets.all(AppSpacing.md),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: AppSpacing.sm,
        crossAxisSpacing: AppSpacing.sm,
        childAspectRatio: 2.0,
      ),
      itemCount: books.length,
      itemBuilder: (_, i) {
        final book = books[i];
        final isSelected = book.id == currentBookId;

        return InkWell(
          onTap: () => onSelect(book),
          borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 150),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: isSelected
                  ? colorScheme.primaryContainer
                  : colorScheme.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
              border: isSelected
                  ? Border.all(color: colorScheme.primary, width: 1.5)
                  : null,
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.sm,
              vertical: AppSpacing.xs,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  book.abbreviationKorean,
                  style: AppTypography.labelMedium.copyWith(
                    color: isSelected
                        ? colorScheme.onPrimaryContainer
                        : colorScheme.onSurface,
                    fontWeight: FontWeight.w700,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  book.abbreviation,
                  style: AppTypography.labelSmall.copyWith(
                    fontSize: 9,
                    color: isSelected
                        ? colorScheme.onPrimaryContainer.withAlpha(200)
                        : colorScheme.onSurfaceVariant,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

// ── Chapter Selector Sheet ─────────────────────────────────────────────

/// 장(Chapter) 선택 바텀시트.
class ChapterSelectorSheet extends ConsumerWidget {
  const ChapterSelectorSheet({required this.book, super.key});

  final Book book;

  static Future<void> show(BuildContext context, {required Book book}) {
    return showModalBottomSheet<void>(
      context: context,
      useSafeArea: true,
      isScrollControlled: true,
      builder: (_) => ChapterSelectorSheet(book: book),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    final currentChapter =
        ref.watch(bibleReaderProvider.select((s) => s.chapter));
    final isCurrentBook =
        ref.watch(bibleReaderProvider.select((s) => s.bookId == book.id));

    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.55,
      minChildSize: 0.35,
      maxChildSize: 0.85,
      builder: (_, __) => Column(
        children: [
          const SizedBox(height: AppSpacing.sm),
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: colorScheme.outlineVariant,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
            child: Row(
              children: [
                Text(
                  '${book.nameKorean}  ',
                  style: AppTypography.titleMedium.copyWith(
                    color: colorScheme.onSurface,
                  ),
                ),
                Text(
                  book.name,
                  style: AppTypography.bodyMedium.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
                const Spacer(),
                Text(
                  '${book.chapterCount}장',
                  style: AppTypography.labelMedium.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.md,
                vertical: AppSpacing.sm,
              ),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 6,
                mainAxisSpacing: AppSpacing.xs,
                crossAxisSpacing: AppSpacing.xs,
                childAspectRatio: 1.0,
              ),
              itemCount: book.chapterCount,
              itemBuilder: (_, i) {
                final ch = i + 1;
                final isSelected = isCurrentBook && ch == currentChapter;

                return InkWell(
                  onTap: () {
                    Navigator.pop(context);
                    ref
                        .read(bibleReaderProvider.notifier)
                        .navigateTo(bookId: book.id, chapter: ch);
                  },
                  borderRadius:
                      BorderRadius.circular(AppSpacing.radiusSm),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 150),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: isSelected
                          ? colorScheme.primary
                          : colorScheme.surfaceContainerHighest,
                      borderRadius:
                          BorderRadius.circular(AppSpacing.radiusSm),
                    ),
                    child: Text(
                      '$ch',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: isSelected
                            ? FontWeight.w700
                            : FontWeight.w400,
                        color: isSelected
                            ? colorScheme.onPrimary
                            : colorScheme.onSurface,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
