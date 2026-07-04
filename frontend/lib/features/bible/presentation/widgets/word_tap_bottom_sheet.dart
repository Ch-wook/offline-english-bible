// lib/features/bible/presentation/widgets/word_tap_bottom_sheet.dart
// [NEW] 단어 탭 바텀시트 — 사전 미리보기 (TASK 4에서 완전 구현)

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../shared/widgets/loading_indicator.dart';
import '../../../../theme/app_colors.dart';
import '../../../../theme/app_spacing.dart';
import '../../../../theme/app_typography.dart';
import '../providers/bible_reader_provider.dart';

/// 단어를 탭했을 때 표시되는 사전 바텀시트.
/// TASK 4 에서 Wiktionary + WordNet 데이터로 완전 구현된다.
class WordTapBottomSheet extends ConsumerWidget {
  const WordTapBottomSheet({required this.word, super.key});

  final String word;

  static Future<void> show(BuildContext context, String word) {
    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (_) => WordTapBottomSheet(word: word),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.55,
      minChildSize: 0.35,
      maxChildSize: 0.9,
      builder: (_, scrollController) => SingleChildScrollView(
        controller: scrollController,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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

            // ── 단어 헤더 ─────────────────────────────────────────────
            Padding(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.xl,
                AppSpacing.xl,
                AppSpacing.lg,
                AppSpacing.md,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: Text(
                      word,
                      style: AppTypography.headlineMedium.copyWith(
                        color: colorScheme.onSurface,
                        fontFamily: 'NotoSerif',
                      ),
                    ),
                  ),
                  // 단어장 추가 버튼
                  FilledButton.tonal(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('"$word" 를 단어장에 추가했습니다'),
                          duration: const Duration(seconds: 2),
                          behavior: SnackBarBehavior.floating,
                        ),
                      );
                    },
                    style: FilledButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.md,
                        vertical: AppSpacing.xs,
                      ),
                      minimumSize: Size.zero,
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.add_rounded, size: 16),
                        SizedBox(width: 4),
                        Text('단어장'),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // ── 사전 내용 (TASK 4 구현 전 placeholder) ───────────────
            _DictionaryPlaceholder(
              word: word,
              isDark: isDark,
              colorScheme: colorScheme,
            ),

            // ── 성경 관련 구절 ─────────────────────────────────────────
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.xl,
                vertical: AppSpacing.md,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.menu_book_rounded,
                        size: 16,
                        color: colorScheme.primary,
                      ),
                      const SizedBox(width: AppSpacing.xs),
                      Text(
                        '성경 관련 구절',
                        style: AppTypography.labelMedium.copyWith(
                          color: colorScheme.primary,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Container(
                    padding: const EdgeInsets.all(AppSpacing.md),
                    decoration: BoxDecoration(
                      color: colorScheme.surfaceContainerHighest.withAlpha(80),
                      borderRadius:
                          BorderRadius.circular(AppSpacing.radiusMd),
                    ),
                    child: Text(
                      'TASK 4 에서 Wiktionary + WordNet 데이터로 완전 구현됩니다.\n현재는 단어 탭 UI만 활성화되어 있습니다.',
                      style: AppTypography.bodySmall.copyWith(
                        color: colorScheme.onSurfaceVariant,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: AppSpacing.xxl),
          ],
        ),
      ),
    );
  }
}

// ── Dictionary Placeholder ─────────────────────────────────────────────

class _DictionaryPlaceholder extends StatelessWidget {
  const _DictionaryPlaceholder({
    required this.word,
    required this.isDark,
    required this.colorScheme,
  });

  final String word;
  final bool isDark;
  final ColorScheme colorScheme;

  // KJV 자주 사용 단어 사전 (TASK 4 구현 전 하드코딩 샘플)
  static const _sampleDefs = {
    'the': (pos: 'article', def: 'Definite article; indicates a specific noun'),
    'god': (pos: 'noun', def: 'The supreme being; the creator of heaven and earth'),
    'lord': (pos: 'noun', def: 'The master; used as a title for God (Yahweh) in KJV'),
    'created': (pos: 'verb', def: 'Past tense of create; to bring into existence from nothing'),
    'heaven': (pos: 'noun', def: 'The sky; the dwelling place of God and angels'),
    'earth': (pos: 'noun', def: 'The ground; the world; the third planet from the sun'),
    'beginning': (pos: 'noun', def: 'The first part or earliest stage of something'),
    'light': (pos: 'noun', def: 'Electromagnetic radiation visible to the human eye; opposite of darkness'),
    'darkness': (pos: 'noun', def: 'Absence of light; used metaphorically for evil or ignorance'),
    'waters': (pos: 'noun', def: 'Plural of water; bodies of water; the deep'),
    'grace': (pos: 'noun', def: 'The free and unmerited favor of God; courteous goodwill'),
    'truth': (pos: 'noun', def: 'The quality of being true; conformity with fact or reality'),
    'faith': (pos: 'noun', def: 'Complete trust or confidence; belief without proof'),
    'love': (pos: 'noun', def: 'Intense affection; God\'s unconditional love (Greek: agape)'),
    'world': (pos: 'noun', def: 'The earth and all its inhabitants; the present age or order'),
    'life': (pos: 'noun', def: 'The existence of a living being; eternal life in theological context'),
    'word': (pos: 'noun', def: 'A unit of language; in John 1, "Word" (Logos) refers to Christ'),
    'spirit': (pos: 'noun', def: 'The immaterial part of a person; the Holy Spirit'),
    'shepherd': (pos: 'noun', def: 'One who tends sheep; used metaphorically for a spiritual leader'),
    'righteousness': (pos: 'noun', def: 'The quality of being morally right; justness before God'),
  };

  @override
  Widget build(BuildContext context) {
    final data = _sampleDefs[word.toLowerCase()];

    if (data == null) {
      return Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.xl,
          vertical: AppSpacing.md,
        ),
        child: Container(
          padding: const EdgeInsets.all(AppSpacing.lg),
          decoration: BoxDecoration(
            color: colorScheme.surfaceContainerHighest.withAlpha(60),
            borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.sm,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: colorScheme.secondaryContainer,
                      borderRadius:
                          BorderRadius.circular(AppSpacing.radiusXs),
                    ),
                    child: Text(
                      'noun / verb / adjective',
                      style: AppTypography.labelSmall.copyWith(
                        color: colorScheme.onSecondaryContainer,
                      ),
                    ),
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  Text(
                    '/ˈ$word/',
                    style: AppTypography.bodySmall.copyWith(
                      color: colorScheme.onSurfaceVariant,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.sm),
              Text(
                'TASK 4 에서 Wiktionary 데이터가 로드됩니다.',
                style: AppTypography.bodyMedium.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.xl,
        vertical: AppSpacing.md,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // IPA + 품사
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.sm,
                  vertical: 2,
                ),
                decoration: BoxDecoration(
                  color: colorScheme.secondaryContainer,
                  borderRadius: BorderRadius.circular(AppSpacing.radiusXs),
                ),
                child: Text(
                  data.pos,
                  style: AppTypography.labelSmall.copyWith(
                    color: colorScheme.onSecondaryContainer,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),

          // 정의
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(AppSpacing.md),
            decoration: BoxDecoration(
              color: isDark
                  ? AppColors.surface1Dark
                  : AppColors.surface1Light,
              borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
              border: Border.all(
                color: colorScheme.outlineVariant.withAlpha(40),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '1.',
                  style: AppTypography.labelMedium.copyWith(
                    color: colorScheme.primary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  data.def,
                  style: AppTypography.bodyMedium.copyWith(
                    color: colorScheme.onSurface,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
