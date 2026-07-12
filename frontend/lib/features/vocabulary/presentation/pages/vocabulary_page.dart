// lib/features/vocabulary/presentation/pages/vocabulary_page.dart
// [MODIFY] 단어장 메인 화면 — 완전 구현

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/database/seed_data/bible_books_seed.dart';
import '../../../../shared/widgets/loading_indicator.dart';
import '../../../../theme/app_spacing.dart';
import '../../../../theme/app_typography.dart';
import '../../domain/entities/vocab_item.dart';
import '../../domain/repositories/vocabulary_repository.dart';
import '../providers/vocabulary_providers.dart';

class VocabularyPage extends ConsumerWidget {
  const VocabularyPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final statsAsync = ref.watch(vocabStatsProvider);
    final vocabAsync = ref.watch(allVocabItemsProvider);
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          '내 단어장',
          style: AppTypography.titleLarge.copyWith(
            color: colorScheme.onSurface,
          ),
        ),
      ),
      body: vocabAsync.when(
        loading: () => const Center(child: InlineLoader()),
        error: (e, _) => Center(child: Text('오류: $e')),
        data:
            (items) => _VocabBody(items: items, stats: statsAsync.valueOrNull),
      ),
      floatingActionButton: statsAsync.whenOrNull(
        data:
            (stats) =>
                stats.dueCount > 0
                    ? FloatingActionButton.extended(
                      onPressed: () => _startReview(context, ref),
                      icon: const Icon(Icons.play_arrow_rounded),
                      label: Text('복습 (${stats.dueCount}개)'),
                    )
                    : null,
      ),
    );
  }

  void _startReview(BuildContext context, WidgetRef ref) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (_) => const _ReviewSheet(),
    );
  }
}

// ── Vocab Body ────────────────────────────────────────────────────────

class _VocabBody extends StatelessWidget {
  const _VocabBody({required this.items, this.stats});

  final List<VocabItem> items;
  final VocabStats? stats;

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) {
      return _EmptyState();
    }

    return CustomScrollView(
      slivers: [
        // 통계 카드
        if (stats != null) SliverToBoxAdapter(child: _StatsCard(stats: stats!)),

        // 단어 목록
        SliverList.builder(
          itemCount: items.length,
          itemBuilder: (_, i) => _VocabItemTile(item: items[i]),
        ),

        const SliverToBoxAdapter(child: SizedBox(height: AppSpacing.xxxxl)),
      ],
    );
  }
}

// ── Stats Card ────────────────────────────────────────────────────────

class _StatsCard extends StatelessWidget {
  const _StatsCard({required this.stats});

  final VocabStats stats;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      margin: const EdgeInsets.all(AppSpacing.lg),
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            colorScheme.primaryContainer,
            colorScheme.secondaryContainer,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _StatItem(
                label: '전체',
                value: '${stats.total}',
                icon: Icons.library_books_rounded,
                color: colorScheme.primary,
              ),
              _StatItem(
                label: '복습 예정',
                value: '${stats.dueCount}',
                icon: Icons.schedule_rounded,
                color: stats.dueCount > 0 ? Colors.orange : colorScheme.primary,
              ),
              _StatItem(
                label: '완료',
                value: '${stats.learnedCount}',
                icon: Icons.check_circle_rounded,
                color: Colors.green,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  const _StatItem({
    required this.label,
    required this.value,
    required this.icon,
    required this.color,
  });

  final String label;
  final String value;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Column(
      children: [
        Icon(icon, color: color, size: 28),
        const SizedBox(height: 4),
        Text(
          value,
          style: AppTypography.headlineMedium.copyWith(
            color: colorScheme.onSurface,
            fontWeight: FontWeight.w700,
          ),
        ),
        Text(
          label,
          style: AppTypography.labelSmall.copyWith(
            color: colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }
}

// ── Vocab Item Tile ───────────────────────────────────────────────────

class _VocabItemTile extends ConsumerWidget {
  const _VocabItemTile({required this.item});

  final VocabItem item;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    final bookInfo = bookNameMap[item.bookId];
    final bookName = bookInfo?.ko ?? '';
    final ref_ = '$bookName ${item.chapter}:${item.verse}';
    final hasReference = bookInfo != null && item.chapter > 0 && item.verse > 0;

    return Dismissible(
      key: ValueKey(item.id),
      direction: DismissDirection.endToStart,
      background: Container(
        color: colorScheme.errorContainer,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: AppSpacing.xl),
        child: Icon(Icons.delete_rounded, color: colorScheme.onErrorContainer),
      ),
      onDismissed: (_) async {
        final repo = ref.read(vocabularyRepositoryProvider);
        await repo.removeVocabItem(item.id);
        ref.invalidate(allVocabItemsProvider);
        ref.invalidate(vocabStatsProvider);
      },
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.lg,
          vertical: AppSpacing.xs,
        ),
        leading: Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color:
                item.isLearned
                    ? Colors.green.withAlpha(40)
                    : item.isDueForReview
                    ? Colors.orange.withAlpha(40)
                    : colorScheme.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
          ),
          child: Icon(
            item.isLearned
                ? Icons.check_rounded
                : item.isDueForReview
                ? Icons.schedule_rounded
                : Icons.menu_book_outlined,
            size: 20,
            color:
                item.isLearned
                    ? Colors.green
                    : item.isDueForReview
                    ? Colors.orange
                    : colorScheme.onSurfaceVariant,
          ),
        ),
        title: Text(
          item.word,
          style: AppTypography.bodyLarge.copyWith(
            fontFamily: 'NotoSerif',
            fontWeight: FontWeight.w600,
            color: colorScheme.onSurface,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (item.definition.isNotEmpty)
              Text(
                item.definition,
                style: AppTypography.bodySmall.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            Row(
              children: [
                if (hasReference) ...[
                  Icon(
                    Icons.menu_book_rounded,
                    size: 10,
                    color: colorScheme.primary,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    ref_,
                    style: AppTypography.labelSmall.copyWith(
                      fontSize: 10,
                      color: colorScheme.primary,
                    ),
                  ),
                  const SizedBox(width: AppSpacing.md),
                ],
                Text(
                  '복습 ${item.repetitions}회',
                  style: AppTypography.labelSmall.copyWith(
                    fontSize: 10,
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ],
        ),
        trailing:
            item.isDueForReview && !item.isLearned
                ? Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 3,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.orange.withAlpha(40),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    '복습',
                    style: AppTypography.labelSmall.copyWith(
                      color: Colors.orange.shade800,
                      fontWeight: FontWeight.w700,
                      fontSize: 10,
                    ),
                  ),
                )
                : null,
      ),
    );
  }
}

// ── Review Sheet ──────────────────────────────────────────────────────

class _ReviewSheet extends ConsumerStatefulWidget {
  const _ReviewSheet();

  @override
  ConsumerState<_ReviewSheet> createState() => _ReviewSheetState();
}

class _ReviewSheetState extends ConsumerState<_ReviewSheet> {
  int _currentIndex = 0;
  bool _revealed = false;

  @override
  Widget build(BuildContext context) {
    final dueAsync = ref.watch(dueForReviewProvider);
    final colorScheme = Theme.of(context).colorScheme;

    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.85,
      maxChildSize: 0.95,
      builder:
          (_, __) => dueAsync.when(
            loading: () => const Center(child: InlineLoader()),
            error: (e, _) => Center(child: Text('오류: $e')),
            data: (items) {
              if (items.isEmpty || _currentIndex >= items.length) {
                return _ReviewComplete(
                  total: _currentIndex,
                  onClose: () => Navigator.pop(context),
                );
              }

              final item = items[_currentIndex];

              return Padding(
                padding: const EdgeInsets.all(AppSpacing.xl),
                child: Column(
                  children: [
                    // 진행률
                    LinearProgressIndicator(
                      value: _currentIndex / items.length,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    Text(
                      '${_currentIndex + 1} / ${items.length}',
                      style: AppTypography.labelMedium.copyWith(
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xxl),

                    // 단어 카드
                    Expanded(
                      child: _ReviewCard(
                        item: item,
                        revealed: _revealed,
                        onReveal: () => setState(() => _revealed = true),
                      ),
                    ),

                    // 평가 버튼 (공개 후)
                    if (_revealed) ...[
                      const SizedBox(height: AppSpacing.lg),
                      _QualityButtons(
                        onSelect: (q) => _submitReview(items, item, q),
                      ),
                    ],
                  ],
                ),
              );
            },
          ),
    );
  }

  Future<void> _submitReview(
    List<VocabItem> items,
    VocabItem item,
    int quality,
  ) async {
    final submitFn = ref.read(submitReviewProvider);
    await submitFn(item.id, quality);
    setState(() {
      _currentIndex++;
      _revealed = false;
    });
  }
}

class _ReviewCard extends StatelessWidget {
  const _ReviewCard({
    required this.item,
    required this.revealed,
    required this.onReveal,
  });

  final VocabItem item;
  final bool revealed;
  final VoidCallback onReveal;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
      ),
      padding: const EdgeInsets.all(AppSpacing.xl),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            item.word,
            style: AppTypography.headlineSmall.copyWith(
              fontFamily: 'NotoSerif',
              color: colorScheme.onSurface,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppSpacing.xl),
          if (!revealed)
            FilledButton(onPressed: onReveal, child: const Text('뜻 보기'))
          else ...[
            const Divider(),
            const SizedBox(height: AppSpacing.md),
            if (item.definition.isNotEmpty)
              Text(
                item.definition,
                style: AppTypography.bodyLarge.copyWith(
                  color: colorScheme.onSurface,
                  height: 1.6,
                ),
                textAlign: TextAlign.center,
              )
            else
              Text(
                '성경에서 찾은 단어\n뜻을 직접 확인해보세요!',
                style: AppTypography.bodyMedium.copyWith(
                  color: colorScheme.onSurfaceVariant,
                  fontStyle: FontStyle.italic,
                ),
                textAlign: TextAlign.center,
              ),
            const SizedBox(height: AppSpacing.lg),
            // 출처 절
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.menu_book_rounded,
                  size: 14,
                  color: colorScheme.primary,
                ),
                const SizedBox(width: 4),
                Text(
                  '${bookNameMap[item.bookId]?.ko ?? ''} ${item.chapter}:${item.verse}',
                  style: AppTypography.labelMedium.copyWith(
                    color: colorScheme.primary,
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}

class _QualityButtons extends StatelessWidget {
  const _QualityButtons({required this.onSelect});

  final void Function(int quality) onSelect;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          '얼마나 잘 기억했나요?',
          style: AppTypography.labelMedium.copyWith(
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        Row(
          children: [
            Expanded(
              child: _QButton(
                label: '모름',
                sublabel: '다시 복습',
                quality: 0,
                color: Colors.red,
                onTap: onSelect,
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: _QButton(
                label: '어렵다',
                sublabel: '1일 후',
                quality: 3,
                color: Colors.orange,
                onTap: onSelect,
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: _QButton(
                label: '알겠다',
                sublabel: '간격 증가',
                quality: 4,
                color: Colors.blue,
                onTap: onSelect,
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: _QButton(
                label: '완벽!',
                sublabel: '오래 기억',
                quality: 5,
                color: Colors.green,
                onTap: onSelect,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _QButton extends StatelessWidget {
  const _QButton({
    required this.label,
    required this.sublabel,
    required this.quality,
    required this.color,
    required this.onTap,
  });

  final String label;
  final String sublabel;
  final int quality;
  final Color color;
  final void Function(int) onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap(quality),
      borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
        decoration: BoxDecoration(
          color: color.withAlpha(40),
          borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
          border: Border.all(color: color.withAlpha(80)),
        ),
        child: Column(
          children: [
            Text(
              label,
              style: AppTypography.labelMedium.copyWith(
                color: color,
                fontWeight: FontWeight.w700,
              ),
            ),
            Text(
              sublabel,
              style: AppTypography.labelSmall.copyWith(
                fontSize: 9,
                color: color.withAlpha(200),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ReviewComplete extends StatelessWidget {
  const _ReviewComplete({required this.total, required this.onClose});

  final int total;
  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.celebration_rounded, size: 64, color: Colors.amber),
          const SizedBox(height: AppSpacing.lg),
          Text(
            '복습 완료!',
            style: AppTypography.headlineMedium.copyWith(
              color: colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            '$total개 단어를 복습했습니다',
            style: AppTypography.bodyMedium.copyWith(
              color: colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: AppSpacing.xxl),
          FilledButton(onPressed: onClose, child: const Text('닫기')),
        ],
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
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
              Icons.bookmark_add_outlined,
              size: 64,
              color: colorScheme.onSurfaceVariant,
            ),
            const SizedBox(height: AppSpacing.lg),
            Text(
              '단어장이 비어있습니다',
              style: AppTypography.titleMedium.copyWith(
                color: colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              '성경을 읽다가 모르는 단어를 탭하면\n단어장에 추가할 수 있습니다.',
              style: AppTypography.bodyMedium.copyWith(
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
