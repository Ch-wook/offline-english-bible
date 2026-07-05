// lib/features/highlights/presentation/pages/bookmarks_page.dart
// [NEW] 북마크 목록 화면

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/database/seed_data/bible_books_seed.dart';
import '../../../../shared/widgets/loading_indicator.dart';
import '../../../../theme/app_spacing.dart';
import '../../../../theme/app_typography.dart';
import '../../../bible/presentation/providers/bible_reader_provider.dart';
import '../providers/highlights_providers.dart';

class BookmarksPage extends ConsumerWidget {
  const BookmarksPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bookmarksAsync = ref.watch(allBookmarksProvider);
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          '북마크',
          style: AppTypography.titleLarge.copyWith(
            color: colorScheme.onSurface,
          ),
        ),
      ),
      body: bookmarksAsync.when(
        loading: () => const Center(child: InlineLoader()),
        error: (e, _) => Center(child: Text('오류: $e')),
        data: (bookmarks) {
          if (bookmarks.isEmpty) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.bookmark_border_rounded,
                    size: 64,
                    color: colorScheme.outlineVariant,
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  Text(
                    '북마크가 없습니다',
                    style: AppTypography.bodyMedium.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Text(
                    '성경을 읽다가 절을 길게 누르면\n북마크를 추가할 수 있습니다.',
                    style: AppTypography.bodySmall.copyWith(
                      color: colorScheme.outlineVariant,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            );
          }

          return ListView.separated(
            itemCount: bookmarks.length,
            separatorBuilder: (_, __) => const Divider(height: 1),
            itemBuilder: (_, i) {
              final bm = bookmarks[i];
              final bookInfo = bookNameMap[bm.bookId];
              final bookName = bookInfo?.ko ?? '알 수 없음';
              final ref_ = '$bookName ${bm.chapter}:${bm.verse}';

              return Dismissible(
                key: ValueKey(bm.id),
                direction: DismissDirection.endToStart,
                background: Container(
                  color: colorScheme.errorContainer,
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.only(right: AppSpacing.xl),
                  child: Icon(
                    Icons.delete_rounded,
                    color: colorScheme.onErrorContainer,
                  ),
                ),
                onDismissed: (_) async {
                  await ref
                      .read(highlightActionProvider.notifier)
                      .removeBookmark(bm.id);
                },
                child: ListTile(
                  leading: Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: colorScheme.primaryContainer,
                      borderRadius:
                          BorderRadius.circular(AppSpacing.radiusSm),
                    ),
                    child: Icon(
                      Icons.bookmark_rounded,
                      size: 18,
                      color: colorScheme.onPrimaryContainer,
                    ),
                  ),
                  title: Text(
                    ref_,
                    style: AppTypography.labelMedium.copyWith(
                      color: colorScheme.primary,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  subtitle: bm.note != null && (bm.note?.isNotEmpty ?? false)
                      ? Text(
                          bm.note!,
                          style: AppTypography.bodySmall.copyWith(
                            color: colorScheme.onSurfaceVariant,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        )
                      : null,
                  trailing: Text(
                    bm.translationCode,
                    style: AppTypography.labelSmall.copyWith(
                      color: colorScheme.onSurfaceVariant,
                      fontSize: 10,
                    ),
                  ),
                  onTap: () {
                    ref
                        .read(bibleReaderProvider.notifier)
                        .navigateTo(
                          bookId: bm.bookId,
                          chapter: bm.chapter,
                        );
                    context.go('/bible');
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
