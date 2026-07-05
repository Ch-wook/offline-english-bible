// lib/features/grammar/presentation/widgets/grammar_analysis_sheet.dart
// [NEW] 절 문법 분석 바텀시트 (POS 태깅 결과 표시)

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../theme/app_colors.dart';
import '../../../../theme/app_spacing.dart';
import '../../../../theme/app_typography.dart';
import '../../domain/entities/grammar_analysis.dart';
import '../providers/grammar_providers.dart';

/// 절 문법 분석 결과를 보여주는 바텀시트.
class GrammarAnalysisSheet extends ConsumerWidget {
  const GrammarAnalysisSheet({required this.verseText, super.key});

  final String verseText;

  static Future<void> show(BuildContext context, String verseText) {
    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (_) => GrammarAnalysisSheet(verseText: verseText),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final analysis = ref.watch(grammarAnalysisProvider(verseText));
    final colorScheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.7,
      maxChildSize: 0.95,
      builder: (_, scrollController) => SingleChildScrollView(
        controller: scrollController,
        padding: const EdgeInsets.all(AppSpacing.xl),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 핸들
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

            // 헤더
            Row(
              children: [
                Icon(
                  Icons.account_tree_rounded,
                  size: 18,
                  color: colorScheme.primary,
                ),
                const SizedBox(width: AppSpacing.sm),
                Text(
                  '문법 분석',
                  style: AppTypography.titleMedium.copyWith(
                    color: colorScheme.onSurface,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const Spacer(),
                Text(
                  '${analysis.wordCount}개 단어',
                  style: AppTypography.labelSmall.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.md),

            // 원문
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(AppSpacing.md),
              decoration: BoxDecoration(
                color: colorScheme.surfaceContainerHighest.withAlpha(60),
                borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
              ),
              child: Text(
                verseText,
                style: AppTypography.bodyMedium.copyWith(
                  fontFamily: 'NotoSerif',
                  color: colorScheme.onSurface,
                  height: 1.6,
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.xl),

            // POS 범례
            _PosLegend(isDark: isDark),
            const SizedBox(height: AppSpacing.lg),

            // 토큰 분석 (Wrap)
            _TokenWrap(tokens: analysis.tokens),
            const SizedBox(height: AppSpacing.xl),

            // 통계
            _GrammarStats(analysis: analysis),

            // 고어 감지
            if (analysis.archaicForms.isNotEmpty) ...[
              const SizedBox(height: AppSpacing.xl),
              _ArchaicSection(
                tokens: analysis.archaicForms,
                colorScheme: colorScheme,
              ),
            ],

            const SizedBox(height: AppSpacing.xxxl),
          ],
        ),
      ),
    );
  }
}

// ── Token Wrap ────────────────────────────────────────────────────────

class _TokenWrap extends StatelessWidget {
  const _TokenWrap({required this.tokens});

  final List<TokenAnalysis> tokens;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: AppSpacing.xs,
      runSpacing: AppSpacing.sm,
      children: tokens
          .where((t) => !t.isPunctuation)
          .map((t) => _TokenChip(token: t))
          .toList(),
    );
  }
}

class _TokenChip extends StatelessWidget {
  const _TokenChip({required this.token});

  final TokenAnalysis token;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final posColor = _posColor(token.pos);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // POS 태그
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
          decoration: BoxDecoration(
            color: posColor.withAlpha(40),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(4),
              topRight: Radius.circular(4),
            ),
            border: Border(
              top: BorderSide(color: posColor.withAlpha(100)),
              left: BorderSide(color: posColor.withAlpha(100)),
              right: BorderSide(color: posColor.withAlpha(100)),
            ),
          ),
          child: Text(
            token.posShort,
            style: AppTypography.labelSmall.copyWith(
              fontSize: 9,
              color: posColor,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        // 단어
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
          decoration: BoxDecoration(
            color: colorScheme.surfaceContainerHighest,
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(4),
              bottomRight: Radius.circular(4),
            ),
            border: Border.all(color: posColor.withAlpha(60)),
          ),
          child: Text(
            token.token,
            style: AppTypography.bodySmall.copyWith(
              fontFamily: 'NotoSerif',
              color: colorScheme.onSurface,
            ),
          ),
        ),
      ],
    );
  }

  Color _posColor(String pos) {
    if (pos.startsWith('NN') || pos == 'NNP') return Colors.blue;
    if (pos.startsWith('VB') || pos == 'MD') return Colors.green;
    if (pos.startsWith('JJ')) return Colors.orange;
    if (pos.startsWith('RB')) return Colors.purple;
    if (pos == 'DT') return Colors.grey;
    if (pos == 'IN' || pos == 'TO') return Colors.teal;
    if (pos.startsWith('PRP')) return Colors.pink;
    if (pos == 'CC') return Colors.brown;
    return Colors.grey;
  }
}

// ── POS Legend ────────────────────────────────────────────────────────

class _PosLegend extends StatelessWidget {
  const _PosLegend({required this.isDark});

  final bool isDark;

  static const _items = [
    ('명사', Colors.blue),
    ('동사', Colors.green),
    ('형용사', Colors.orange),
    ('부사', Colors.purple),
    ('전치사', Colors.teal),
    ('대명사', Colors.pink),
  ];

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: AppSpacing.sm,
      runSpacing: 4,
      children: _items.map((item) {
        final (label, color) = item;
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                color: color.withAlpha(80),
                shape: BoxShape.circle,
                border: Border.all(color: color, width: 1.5),
              ),
            ),
            const SizedBox(width: 4),
            Text(
              label,
              style: AppTypography.labelSmall.copyWith(
                fontSize: 10,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        );
      }).toList(),
    );
  }
}

// ── Grammar Stats ─────────────────────────────────────────────────────

class _GrammarStats extends StatelessWidget {
  const _GrammarStats({required this.analysis});

  final GrammarAnalysis analysis;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest.withAlpha(40),
        borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _StatItem(
            label: '명사',
            count: analysis.nouns.length,
            color: Colors.blue,
          ),
          _StatItem(
            label: '동사',
            count: analysis.verbs.length,
            color: Colors.green,
          ),
          _StatItem(
            label: '전체 단어',
            count: analysis.wordCount,
            color: colorScheme.onSurface,
          ),
        ],
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  const _StatItem({
    required this.label,
    required this.count,
    required this.color,
  });

  final String label;
  final int count;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          '$count',
          style: AppTypography.titleLarge.copyWith(
            color: color,
            fontWeight: FontWeight.w700,
          ),
        ),
        Text(
          label,
          style: AppTypography.labelSmall.copyWith(
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }
}

// ── Archaic Section ───────────────────────────────────────────────────

class _ArchaicSection extends StatelessWidget {
  const _ArchaicSection({
    required this.tokens,
    required this.colorScheme,
  });

  final List<TokenAnalysis> tokens;
  final ColorScheme colorScheme;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              Icons.history_edu_rounded,
              size: 16,
              color: colorScheme.tertiary,
            ),
            const SizedBox(width: AppSpacing.xs),
            Text(
              'KJV 고어 형태',
              style: AppTypography.labelMedium.copyWith(
                color: colorScheme.tertiary,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.sm),
        Wrap(
          spacing: AppSpacing.sm,
          runSpacing: AppSpacing.xs,
          children: tokens.map((t) {
            return Chip(
              label: Text(
                '${t.token} → ${t.lemma}',
                style: AppTypography.labelSmall.copyWith(
                  fontFamily: 'NotoSerif',
                ),
              ),
              avatar: Icon(
                Icons.transform_rounded,
                size: 14,
                color: colorScheme.tertiary,
              ),
              backgroundColor: colorScheme.tertiaryContainer.withAlpha(60),
              visualDensity: VisualDensity.compact,
            );
          }).toList(),
        ),
      ],
    );
  }
}
