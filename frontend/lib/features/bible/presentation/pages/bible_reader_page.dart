// lib/features/bible/presentation/pages/bible_reader_page.dart
// [NEW] 성경 읽기 화면 — TASK 3에서 완전 구현, TASK 1은 Shell

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../shared/widgets/loading_indicator.dart';
import '../../../../theme/app_colors.dart';
import '../../../../theme/app_spacing.dart';
import '../../../../theme/app_typography.dart';

/// 성경 읽기 메인 화면.
///
/// TASK 1: 기본 Shell UI (북/장 선택 없는 초기 상태)
/// TASK 3: 완전한 성경 읽기 구현 (절 표시, 단어 클릭, 대역 보기)
class BibleReaderPage extends ConsumerWidget {
  const BibleReaderPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: _BibleAppBar(colorScheme: colorScheme),
      body: _WelcomeBody(colorScheme: colorScheme, isDark: isDark),
    );
  }
}

// ── AppBar ────────────────────────────────────────────────────────────

class _BibleAppBar extends StatelessWidget implements PreferredSizeWidget {
  const _BibleAppBar({required this.colorScheme});

  final ColorScheme colorScheme;

  @override
  Size get preferredSize => const Size.fromHeight(AppSpacing.appBarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Row(
        children: [
          Icon(
            Icons.menu_book_rounded,
            color: colorScheme.primary,
            size: AppSpacing.iconMd,
          ),
          const SizedBox(width: AppSpacing.sm),
          Text(
            'Genesis 1',
            style: AppTypography.titleLarge.copyWith(
              color: colorScheme.onSurface,
            ),
          ),
        ],
      ),
      actions: [
        // 번역본 선택
        Container(
          margin: const EdgeInsets.only(right: AppSpacing.sm),
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.md,
            vertical: AppSpacing.xs,
          ),
          decoration: BoxDecoration(
            color: colorScheme.primaryContainer,
            borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
          ),
          child: Text(
            'KJV',
            style: AppTypography.labelMedium.copyWith(
              color: colorScheme.onPrimaryContainer,
            ),
          ),
        ),
        IconButton(
          icon: const Icon(Icons.search_rounded),
          onPressed: () {},
          tooltip: '검색',
        ),
        IconButton(
          icon: const Icon(Icons.more_vert_rounded),
          onPressed: () {},
          tooltip: '더보기',
        ),
      ],
    );
  }
}

// ── Welcome Body ──────────────────────────────────────────────────────

class _WelcomeBody extends StatelessWidget {
  const _WelcomeBody({
    required this.colorScheme,
    required this.isDark,
  });

  final ColorScheme colorScheme;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _HeroCard(colorScheme: colorScheme, isDark: isDark),
          const SizedBox(height: AppSpacing.xxl),
          _TranslationRow(colorScheme: colorScheme),
          const SizedBox(height: AppSpacing.xxl),
          _PreviewVerses(colorScheme: colorScheme, isDark: isDark),
          const SizedBox(height: AppSpacing.xxl),
          _FeatureGrid(colorScheme: colorScheme),
          const SizedBox(height: AppSpacing.xxxxl),
        ],
      ),
    );
  }
}

class _HeroCard extends StatelessWidget {
  const _HeroCard({required this.colorScheme, required this.isDark});

  final ColorScheme colorScheme;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.xxl),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: isDark
              ? [
                  AppColors.darkPrimaryContainer,
                  AppColors.darkSurfaceVariant,
                ]
              : [
                  AppColors.lightPrimaryContainer,
                  AppColors.lightSurface,
                ],
        ),
        borderRadius: BorderRadius.circular(AppSpacing.radiusXl),
        border: Border.all(
          color: colorScheme.outlineVariant.withAlpha(60),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.menu_book_rounded,
            size: 40,
            color: colorScheme.primary,
          ),
          const SizedBox(height: AppSpacing.lg),
          Text(
            'Offline English Bible',
            style: AppTypography.headlineMedium.copyWith(
              color: colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            '성경으로 영어를 공부하는 가장 스마트한 방법.\n단어를 탭하면 즉시 사전이 열립니다.',
            style: AppTypography.bodyMedium.copyWith(
              color: colorScheme.onSurfaceVariant,
              height: 1.6,
            ),
          ),
          const SizedBox(height: AppSpacing.xl),
          FilledButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.auto_stories_rounded),
            label: const Text('창세기 1장 읽기 시작'),
          ),
        ],
      ),
    );
  }
}

class _TranslationRow extends StatelessWidget {
  const _TranslationRow({required this.colorScheme});

  final ColorScheme colorScheme;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '번역본',
          style: AppTypography.titleSmall.copyWith(
            color: colorScheme.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        Row(
          children: [
            _TranslationChip(
              label: 'KJV',
              sublabel: 'King James Version',
              color: AppColors.kjvBadgeLight,
              isSelected: true,
            ),
            const SizedBox(width: AppSpacing.sm),
            _TranslationChip(
              label: '개역한글',
              sublabel: '한국어 병렬',
              color: AppColors.koreanBadgeLight,
              isSelected: false,
            ),
          ],
        ),
      ],
    );
  }
}

class _TranslationChip extends StatelessWidget {
  const _TranslationChip({
    required this.label,
    required this.sublabel,
    required this.color,
    required this.isSelected,
  });

  final String label;
  final String sublabel;
  final Color color;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      decoration: BoxDecoration(
        color: isSelected
            ? colorScheme.primaryContainer
            : colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
        border: isSelected
            ? Border.all(color: colorScheme.primary, width: 1.5)
            : Border.all(color: Colors.transparent),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: AppTypography.labelMedium.copyWith(
              color: isSelected
                  ? colorScheme.onPrimaryContainer
                  : colorScheme.onSurfaceVariant,
              fontWeight: FontWeight.w700,
            ),
          ),
          Text(
            sublabel,
            style: AppTypography.labelSmall.copyWith(
              color: isSelected
                  ? colorScheme.onPrimaryContainer.withAlpha(180)
                  : colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}

class _PreviewVerses extends StatelessWidget {
  const _PreviewVerses({
    required this.colorScheme,
    required this.isDark,
  });

  final ColorScheme colorScheme;
  final bool isDark;

  static const _verses = [
    (
      number: '1',
      kjv: 'In the beginning God created the heaven and the earth.',
      korean: '태초에 하나님이 천지를 창조하시니라',
    ),
    (
      number: '2',
      kjv: 'And the earth was without form, and void; and darkness was upon the face of the deep.',
      korean: '땅이 혼돈하고 공허하며 흑암이 깊음 위에 있고',
    ),
    (
      number: '3',
      kjv: 'And God said, Let there be light: and there was light.',
      korean: '하나님이 가라사대 빛이 있으라 하시매 빛이 있었고',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              '미리보기  ',
              style: AppTypography.titleSmall.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.sm,
                vertical: 2,
              ),
              decoration: BoxDecoration(
                color: colorScheme.tertiaryContainer,
                borderRadius: BorderRadius.circular(AppSpacing.radiusXs),
              ),
              child: Text(
                'Genesis 1',
                style: AppTypography.labelSmall.copyWith(
                  color: colorScheme.onTertiaryContainer,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.md),
        Container(
          decoration: BoxDecoration(
            color: isDark ? AppColors.surface1Dark : AppColors.surface1Light,
            borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
            border: Border.all(
              color: colorScheme.outlineVariant.withAlpha(60),
            ),
          ),
          child: Column(
            children: _verses.asMap().entries.map((entry) {
              final isLast = entry.key == _verses.length - 1;
              final v = entry.value;
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.lg,
                      vertical: AppSpacing.md,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: AppSpacing.verseNumberWidth,
                          child: Text(
                            v.number,
                            style: AppTypography.verseNumber.copyWith(
                              color: isDark
                                  ? AppColors.verseNumberDark
                                  : AppColors.verseNumberLight,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                v.kjv,
                                style: AppTypography.bibleBody.copyWith(
                                  color: colorScheme.onSurface,
                                ),
                              ),
                              const SizedBox(height: AppSpacing.xs),
                              Text(
                                v.korean,
                                style: AppTypography.bibleBodySmall.copyWith(
                                  color: colorScheme.onSurfaceVariant,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (!isLast)
                    Divider(
                      height: 1,
                      indent: AppSpacing.lg,
                      endIndent: AppSpacing.lg,
                      color: colorScheme.outlineVariant.withAlpha(40),
                    ),
                ],
              );
            }).toList(),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: AppSpacing.sm),
          child: Text(
            '단어를 탭하면 사전이 열립니다 (TASK 4에서 구현)',
            style: AppTypography.labelSmall.copyWith(
              color: colorScheme.onSurfaceVariant,
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
      ],
    );
  }
}

class _FeatureGrid extends StatelessWidget {
  const _FeatureGrid({required this.colorScheme});

  final ColorScheme colorScheme;

  static const _features = [
    (icon: Icons.translate_rounded, label: '오프라인 사전', sublabel: 'Wiktionary + WordNet'),
    (icon: Icons.auto_stories_rounded, label: '단어장', sublabel: '스페이스드 리피티션'),
    (icon: Icons.highlight_rounded, label: '형광펜', sublabel: '5가지 색상'),
    (icon: Icons.bookmark_rounded, label: '북마크', sublabel: '메모 추가 가능'),
    (icon: Icons.search_rounded, label: '전문 검색', sublabel: 'FTS5 SQLite'),
    (icon: Icons.volume_up_rounded, label: '오디오', sublabel: 'LibriVox KJV'),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '기능',
          style: AppTypography.titleSmall.copyWith(
            color: colorScheme.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        GridView.count(
          crossAxisCount: 3,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          mainAxisSpacing: AppSpacing.sm,
          crossAxisSpacing: AppSpacing.sm,
          childAspectRatio: 1.0,
          children: _features
              .map((f) => _FeatureCard(
                    icon: f.icon,
                    label: f.label,
                    sublabel: f.sublabel,
                    colorScheme: colorScheme,
                  ))
              .toList(),
        ),
      ],
    );
  }
}

class _FeatureCard extends StatelessWidget {
  const _FeatureCard({
    required this.icon,
    required this.label,
    required this.sublabel,
    required this.colorScheme,
  });

  final IconData icon;
  final String label;
  final String sublabel;
  final ColorScheme colorScheme;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest.withAlpha(80),
        borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
        border: Border.all(
          color: colorScheme.outlineVariant.withAlpha(40),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: AppSpacing.iconLg, color: colorScheme.primary),
          const SizedBox(height: AppSpacing.xs),
          Text(
            label,
            style: AppTypography.labelSmall.copyWith(
              color: colorScheme.onSurface,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            sublabel,
            style: AppTypography.labelSmall.copyWith(
              color: colorScheme.onSurfaceVariant,
              fontSize: 9,
            ),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
