// lib/features/dictionary/presentation/widgets/dictionary_bottom_sheet.dart
// [NEW] 사전 바텀시트 완전 구현 (Wiktionary + WordNet UI)

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../shared/widgets/loading_indicator.dart';
import '../../../../theme/app_colors.dart';
import '../../../../theme/app_spacing.dart';
import '../../../../theme/app_typography.dart';
import '../../domain/entities/dictionary_entry.dart';
import '../providers/dictionary_providers.dart';

/// 단어 사전 바텀시트 — 완전 구현.
/// TASK 3 의 placeholder를 대체한다.
class DictionaryBottomSheet extends ConsumerWidget {
  const DictionaryBottomSheet({required this.word, super.key});

  final String word;

  static Future<void> show(BuildContext context, String word) {
    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (_) => DictionaryBottomSheet(word: word),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final entryAsync = ref.watch(wordLookupProvider(word));

    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.65,
      minChildSize: 0.4,
      maxChildSize: 0.95,
      builder: (_, scrollController) => entryAsync.when(
        loading: () => const Center(child: InlineLoader()),
        error: (e, _) => _NotFoundBody(word: word),
        data: (entry) => entry != null
            ? _EntryBody(
                entry: entry,
                scrollController: scrollController,
              )
            : _NotFoundBody(word: word),
      ),
    );
  }
}

// ── Entry Body ────────────────────────────────────────────────────────

class _EntryBody extends ConsumerWidget {
  const _EntryBody({
    required this.entry,
    required this.scrollController,
  });

  final DictionaryEntry entry;
  final ScrollController scrollController;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return SingleChildScrollView(
      controller: scrollController,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── 핸들 ────────────────────────────────────────────────────
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

          // ── 단어 헤더 ────────────────────────────────────────────────
          Padding(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.xl,
              AppSpacing.xl,
              AppSpacing.lg,
              0,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // 단어
                      Text(
                        entry.word,
                        style: AppTypography.headlineMedium.copyWith(
                          fontFamily: 'NotoSerif',
                          color: colorScheme.onSurface,
                        ),
                      ),
                      // IPA
                      if (entry.hasIpa) ...[
                        const SizedBox(height: 2),
                        Text(
                          entry.displayIpa,
                          style: AppTypography.bodySmall.copyWith(
                            color: colorScheme.onSurfaceVariant,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ],
                      // KJV 빈도
                      if (entry.isKjvWord) ...[
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            Icon(
                              Icons.menu_book_rounded,
                              size: 12,
                              color: colorScheme.primary,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              'KJV에서 ${entry.bibleFrequency}회 사용',
                              style: AppTypography.labelSmall.copyWith(
                                color: colorScheme.primary,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ],
                  ),
                ),
                // 단어장 추가
                _VocabAddButton(word: entry.word),
              ],
            ),
          ),

          // ── 품사 + 정의 ──────────────────────────────────────────────
          const SizedBox(height: AppSpacing.lg),
          _SensesSection(entry: entry, isDark: isDark),

          // ── 어원 ─────────────────────────────────────────────────────
          if (entry.etymology.isNotEmpty) ...[
            const _SectionDivider(),
            _EtymologySection(text: entry.etymology),
          ],

          // ── 활용형 ───────────────────────────────────────────────────
          if (entry.inflectedForms.isNotEmpty) ...[
            const _SectionDivider(),
            _InflectionsSection(forms: entry.inflectedForms),
          ],

          // ── 동의어 ───────────────────────────────────────────────────
          if (entry.hasSynonyms) ...[
            const _SectionDivider(),
            _WordChipsSection(
              title: '동의어',
              icon: Icons.swap_horiz_rounded,
              words: entry.synonyms,
              color: Colors.green,
            ),
          ],

          // ── 반의어 ───────────────────────────────────────────────────
          if (entry.hasAntonyms) ...[
            const _SectionDivider(),
            _WordChipsSection(
              title: '반의어',
              icon: Icons.compare_arrows_rounded,
              words: entry.antonyms,
              color: Colors.red,
            ),
          ],

          // ── 관련 단어 ────────────────────────────────────────────────
          if (entry.relatedWords.isNotEmpty) ...[
            const _SectionDivider(),
            _WordChipsSection(
              title: '관련 단어',
              icon: Icons.link_rounded,
              words: entry.relatedWords.take(8).toList(),
              color: Colors.blue,
            ),
          ],

          const SizedBox(height: AppSpacing.xxxl),
        ],
      ),
    );
  }
}

// ── Senses Section ────────────────────────────────────────────────────

class _SensesSection extends StatelessWidget {
  const _SensesSection({required this.entry, required this.isDark});

  final DictionaryEntry entry;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    // 품사별로 그룹핑
    final grouped = <String, List<WordSense>>{};
    for (final s in entry.senses) {
      grouped.putIfAbsent(s.partOfSpeech, () => []).add(s);
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xl),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: grouped.entries.map((pos) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 품사 레이블
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
                  pos.value.first.posLabel,
                  style: AppTypography.labelSmall.copyWith(
                    color: colorScheme.onSecondaryContainer,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.sm),

              // 의미 목록
              ...pos.value.asMap().entries.map((e) {
                final sense = e.value;
                return Padding(
                  padding: const EdgeInsets.only(
                    bottom: AppSpacing.md,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${e.key + 1}.',
                        style: AppTypography.labelMedium.copyWith(
                          color: colorScheme.primary,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(width: AppSpacing.sm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // 정의
                            Text(
                              sense.definition,
                              style: AppTypography.bodyMedium.copyWith(
                                color: colorScheme.onSurface,
                                height: 1.5,
                              ),
                            ),

                            // 성경적 정의 (있을 때만)
                            if (sense.bibleDefinition.isNotEmpty) ...[
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  Icon(
                                    Icons.menu_book_outlined,
                                    size: 12,
                                    color: colorScheme.primary,
                                  ),
                                  const SizedBox(width: 4),
                                  Expanded(
                                    child: Text(
                                      sense.bibleDefinition,
                                      style: AppTypography.bodySmall
                                          .copyWith(
                                        color:
                                            colorScheme.onSurfaceVariant,
                                        fontStyle: FontStyle.italic,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],

                            // 고어 뱃지
                            if (sense.isArchaic) ...[
                              const SizedBox(height: 4),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 6,
                                  vertical: 1,
                                ),
                                decoration: BoxDecoration(
                                  color: colorScheme.tertiaryContainer,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Text(
                                  'archaic · 고어',
                                  style: AppTypography.labelSmall.copyWith(
                                    fontSize: 9,
                                    color:
                                        colorScheme.onTertiaryContainer,
                                  ),
                                ),
                              ),
                            ],

                            // 예문
                            if (sense.examples.isNotEmpty) ...[
                              const SizedBox(height: AppSpacing.sm),
                              ...sense.examples
                                  .take(2)
                                  .map(
                                    (ex) => _ExampleItem(
                                      example: ex,
                                      isDark: isDark,
                                    ),
                                  ),
                            ],
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }),

              const SizedBox(height: AppSpacing.md),
            ],
          );
        }).toList(),
      ),
    );
  }
}

// ── Example Item ──────────────────────────────────────────────────────

class _ExampleItem extends StatelessWidget {
  const _ExampleItem({required this.example, required this.isDark});

  final WordExample example;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isBible = example.isBibleExample;

    return Container(
      margin: const EdgeInsets.only(bottom: 6),
      padding: const EdgeInsets.all(AppSpacing.sm),
      decoration: BoxDecoration(
        color: isBible
            ? colorScheme.primaryContainer.withAlpha(60)
            : (isDark ? AppColors.surface1Dark : AppColors.surface1Light),
        borderRadius: BorderRadius.circular(AppSpacing.radiusXs),
        border: isBible
            ? Border(
                left: BorderSide(
                  color: colorScheme.primary,
                  width: 2.5,
                ),
              )
            : null,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '"${example.text}"',
            style: AppTypography.bodySmall.copyWith(
              color: colorScheme.onSurface,
              fontStyle: FontStyle.italic,
              fontFamily: isBible ? 'NotoSerif' : null,
            ),
          ),
          if (isBible && example.sourceReference.isNotEmpty) ...[
            const SizedBox(height: 2),
            Text(
              '— ${example.sourceReference}',
              style: AppTypography.labelSmall.copyWith(
                color: colorScheme.primary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

// ── Etymology Section ─────────────────────────────────────────────────

class _EtymologySection extends StatelessWidget {
  const _EtymologySection({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xl),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _SectionTitle(label: '어원', icon: Icons.history_edu_rounded),
          const SizedBox(height: AppSpacing.sm),
          Text(
            text,
            style: AppTypography.bodySmall.copyWith(
              color: colorScheme.onSurfaceVariant,
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }
}

// ── Inflections Section ───────────────────────────────────────────────

class _InflectionsSection extends StatelessWidget {
  const _InflectionsSection({required this.forms});

  final List<InflectedForm> forms;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xl),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _SectionTitle(label: '활용형', icon: Icons.transform_rounded),
          const SizedBox(height: AppSpacing.sm),
          Wrap(
            spacing: AppSpacing.sm,
            runSpacing: AppSpacing.xs,
            children: forms.map((f) {
              return Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.sm,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: colorScheme.surfaceContainerHighest,
                  borderRadius:
                      BorderRadius.circular(AppSpacing.radiusXs),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      f.formTypeLabel,
                      style: AppTypography.labelSmall.copyWith(
                        fontSize: 9,
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                    Text(
                      f.form,
                      style: AppTypography.labelMedium.copyWith(
                        color: colorScheme.onSurface,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

// ── Word Chips Section ────────────────────────────────────────────────

class _WordChipsSection extends ConsumerWidget {
  const _WordChipsSection({
    required this.title,
    required this.icon,
    required this.words,
    required this.color,
  });

  final String title;
  final IconData icon;
  final List<String> words;
  final Color color;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xl),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _SectionTitle(label: title, icon: icon, color: color),
          const SizedBox(height: AppSpacing.sm),
          Wrap(
            spacing: AppSpacing.sm,
            runSpacing: AppSpacing.xs,
            children: words
                .map(
                  (w) => ActionChip(
                    label: Text(
                      w,
                      style: AppTypography.labelMedium.copyWith(
                        fontFamily: 'NotoSerif',
                      ),
                    ),
                    onPressed: () {
                      // 탭하면 해당 단어를 조회
                      DictionaryBottomSheet.show(context, w);
                    },
                    visualDensity: VisualDensity.compact,
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }
}

// ── Vocab Add Button ──────────────────────────────────────────────────

class _VocabAddButton extends ConsumerWidget {
  const _VocabAddButton({required this.word});

  final String word;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FilledButton.tonal(
      onPressed: () {
        // TASK 5 에서 완전 구현
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('"$word" 를 단어장에 추가했습니다'),
            behavior: SnackBarBehavior.floating,
            duration: const Duration(seconds: 2),
          ),
        );
        Navigator.pop(context);
      },
      style: FilledButton.styleFrom(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.xs,
        ),
        minimumSize: Size.zero,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      child: const Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.add_rounded, size: 16),
          SizedBox(width: 4),
          Text('단어장'),
        ],
      ),
    );
  }
}

// ── Not Found Body ────────────────────────────────────────────────────

class _NotFoundBody extends StatelessWidget {
  const _NotFoundBody({required this.word});

  final String word;

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
              Icons.search_off_rounded,
              size: 48,
              color: colorScheme.onSurfaceVariant,
            ),
            const SizedBox(height: AppSpacing.lg),
            Text(
              '"$word"',
              style: AppTypography.titleMedium.copyWith(
                fontFamily: 'NotoSerif',
                color: colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              '사전에서 찾을 수 없습니다.\n사전 데이터를 임포트해야 합니다.',
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

// ── Shared Widgets ────────────────────────────────────────────────────

class _SectionDivider extends StatelessWidget {
  const _SectionDivider();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.xl,
        vertical: AppSpacing.md,
      ),
      child: Divider(
        color:
            Theme.of(context).colorScheme.outlineVariant.withAlpha(60),
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle({
    required this.label,
    required this.icon,
    this.color,
  });

  final String label;
  final IconData icon;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final effectiveColor = color ?? colorScheme.primary;

    return Row(
      children: [
        Icon(icon, size: 16, color: effectiveColor),
        const SizedBox(width: AppSpacing.xs),
        Text(
          label,
          style: AppTypography.labelMedium.copyWith(
            color: effectiveColor,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}
