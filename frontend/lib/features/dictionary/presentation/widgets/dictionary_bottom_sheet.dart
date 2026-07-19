// lib/features/dictionary/presentation/widgets/dictionary_bottom_sheet.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/data/bible_word_korean_dict.dart';
import '../../../../shared/widgets/loading_indicator.dart';
import '../../../../theme/app_spacing.dart';
import '../../../../theme/app_typography.dart';
import '../../../vocabulary/presentation/providers/vocabulary_providers.dart';
import '../../domain/entities/dictionary_entry.dart';
import '../../domain/services/dictionary_meaning_formatter.dart';
import '../providers/dictionary_providers.dart';

class DictionaryBottomSheet extends ConsumerWidget {
  const DictionaryBottomSheet({
    required this.word,
    this.bookId = 0,
    this.chapter = 0,
    this.verse = 0,
    this.translationCode = 'KJV',
    super.key,
  });

  final String word;
  final int bookId;
  final int chapter;
  final int verse;
  final String translationCode;

  static Future<void> show(
    BuildContext context,
    String word, {
    int bookId = 0,
    int chapter = 0,
    int verse = 0,
    String translationCode = 'KJV',
  }) {
    final query = word.trim();
    if (query.isEmpty) return Future.value();

    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      showDragHandle: false,
      builder:
          (_) => DictionaryBottomSheet(
            word: query,
            bookId: bookId,
            chapter: chapter,
            verse: verse,
            translationCode: translationCode,
          ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final lookup = ref.watch(wordLookupProvider(word));

    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.72,
      minChildSize: 0.42,
      maxChildSize: 0.96,
      builder: (context, scrollController) {
        return lookup.when(
          loading: () => const _LoadingContent(),
          error: (_, __) => _NotFoundContent(word: word),
          data:
              (entry) =>
                  entry == null
                      ? _NotFoundContent(word: word)
                      : _EntryContent(
                        entry: entry,
                        scrollController: scrollController,
                        bookId: bookId,
                        chapter: chapter,
                        verse: verse,
                        translationCode: translationCode,
                      ),
        );
      },
    );
  }
}

class _EntryContent extends StatelessWidget {
  const _EntryContent({
    required this.entry,
    required this.scrollController,
    required this.bookId,
    required this.chapter,
    required this.verse,
    required this.translationCode,
  });

  final DictionaryEntry entry;
  final ScrollController scrollController;
  final int bookId;
  final int chapter;
  final int verse;
  final String translationCode;

  @override
  Widget build(BuildContext context) {
    final koreanMeaning = _koreanMeaning(entry);
    final biblicalMeaning = _biblicalKoreanMeaning(entry);
    final visibleSenses = _visibleKoreanSenses(entry);
    final showWordRelations = !_hasMismatchedImportedFirstSense(entry);

    return SingleChildScrollView(
      controller: scrollController,
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.xl,
        AppSpacing.sm,
        AppSpacing.xl,
        AppSpacing.xxxl,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _SheetHandle(),
          _Header(
            entry: entry,
            bookId: bookId,
            chapter: chapter,
            verse: verse,
            translationCode: translationCode,
          ),
          if (koreanMeaning.isNotEmpty) ...[
            const SizedBox(height: AppSpacing.lg),
            _KoreanMeaningPanel(
              text: koreanMeaning,
              label: biblicalMeaning.isNotEmpty ? '성경 문맥 뜻' : '한국어 뜻',
            ),
          ],
          if (visibleSenses.isNotEmpty) ...[
            const SizedBox(height: AppSpacing.xl),
            _SectionTitle(
              icon: Icons.menu_book_outlined,
              label: biblicalMeaning.isNotEmpty ? '다른 한국어 뜻' : '뜻',
            ),
            const SizedBox(height: AppSpacing.sm),
            ...visibleSenses.map((sense) => _SenseBlock(sense: sense)),
          ],
          if (entry.etymology.trim().isNotEmpty) ...[
            const SizedBox(height: AppSpacing.xl),
            const _SectionTitle(icon: Icons.history_edu_rounded, label: '어원'),
            const SizedBox(height: AppSpacing.sm),
            _BodyText(entry.etymology),
          ],
          if (entry.inflectedForms.isNotEmpty) ...[
            const SizedBox(height: AppSpacing.xl),
            const _SectionTitle(icon: Icons.transform_rounded, label: '활용형'),
            const SizedBox(height: AppSpacing.sm),
            _InflectionWrap(forms: entry.inflectedForms),
          ],
          if (showWordRelations && entry.synonyms.isNotEmpty) ...[
            const SizedBox(height: AppSpacing.xl),
            _WordChipSection(
              icon: Icons.swap_horiz_rounded,
              label: '비슷한 말',
              words: entry.synonyms,
              bookId: bookId,
              chapter: chapter,
              verse: verse,
              translationCode: translationCode,
            ),
          ],
          if (showWordRelations && entry.antonyms.isNotEmpty) ...[
            const SizedBox(height: AppSpacing.xl),
            _WordChipSection(
              icon: Icons.compare_arrows_rounded,
              label: '반대말',
              words: entry.antonyms,
              bookId: bookId,
              chapter: chapter,
              verse: verse,
              translationCode: translationCode,
            ),
          ],
          if (showWordRelations && entry.relatedWords.isNotEmpty) ...[
            const SizedBox(height: AppSpacing.xl),
            _WordChipSection(
              icon: Icons.link_rounded,
              label: '관련 단어',
              words: entry.relatedWords.take(12).toList(),
              bookId: bookId,
              chapter: chapter,
              verse: verse,
              translationCode: translationCode,
            ),
          ],
          const SizedBox(height: AppSpacing.xxl),
          const _SourceAttribution(),
        ],
      ),
    );
  }
}

class _SourceAttribution extends StatelessWidget {
  const _SourceAttribution();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Row(
      children: [
        Icon(
          Icons.info_outline_rounded,
          size: AppSpacing.iconXs,
          color: colorScheme.onSurfaceVariant,
        ),
        const SizedBox(width: AppSpacing.xs),
        Expanded(
          child: Text(
            'Wiktionary · WordNet · quick_english-korean · CMUdict',
            style: AppTypography.labelSmall.copyWith(
              color: colorScheme.onSurfaceVariant,
            ),
          ),
        ),
      ],
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({
    required this.entry,
    required this.bookId,
    required this.chapter,
    required this.verse,
    required this.translationCode,
  });

  final DictionaryEntry entry;
  final int bookId;
  final int chapter;
  final int verse;
  final String translationCode;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: double.infinity,
                child: FittedBox(
                  key: const ValueKey('dictionary-word-title'),
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.centerLeft,
                  child: Text(
                    entry.word,
                    maxLines: 1,
                    style: AppTypography.headlineMedium.copyWith(
                      color: colorScheme.onSurface,
                      fontFamily: 'NotoSerif',
                    ),
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.sm),
              Wrap(
                spacing: AppSpacing.sm,
                runSpacing: AppSpacing.xs,
                children: [
                  if (entry.hasIpa)
                    _MetaChip(
                      icon: Icons.record_voice_over_rounded,
                      label: entry.displayIpa,
                    ),
                  if (entry.bibleFrequency > 0)
                    _MetaChip(
                      icon: Icons.auto_stories_rounded,
                      label: 'KJV ${entry.bibleFrequency}회',
                    ),
                  _MetaChip(
                    icon: Icons.offline_pin_rounded,
                    label: entry.id == -1 ? '내장 사전' : '오프라인 사전',
                  ),
                ],
              ),
            ],
          ),
        ),
        _SaveVocabularyButton(
          entry: entry,
          bookId: bookId,
          chapter: chapter,
          verse: verse,
          translationCode: translationCode,
        ),
        _PronunciationButton(word: entry.word),
        IconButton(
          tooltip: '닫기',
          icon: const Icon(Icons.close_rounded),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ],
    );
  }
}

class _SaveVocabularyButton extends ConsumerWidget {
  const _SaveVocabularyButton({
    required this.entry,
    required this.bookId,
    required this.chapter,
    required this.verse,
    required this.translationCode,
  });

  final DictionaryEntry entry;
  final int bookId;
  final int chapter;
  final int verse;
  final String translationCode;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final saved = ref.watch(isWordSavedProvider(entry.wordNormalized));
    final isSaved = saved.valueOrNull ?? false;

    return IconButton(
      tooltip: isSaved ? '단어장에 저장됨' : '단어장에 저장',
      onPressed:
          isSaved
              ? null
              : () async {
                try {
                  await ref.read(addVocabWordProvider)(
                    word: entry.wordNormalized,
                    bookId: bookId,
                    chapter: chapter,
                    verse: verse,
                    translationCode: translationCode,
                    definition:
                        _koreanMeaning(entry).isNotEmpty
                            ? _koreanMeaning(entry)
                            : entry.primaryDefinition,
                    partOfSpeech: _preferredPartOfSpeech(entry),
                    ipa: entry.displayIpa,
                    bibleDefinition: _visibleKoreanSenses(entry)
                        .map((sense) => sense.displayBibleDefinition)
                        .firstWhere(
                          (definition) => definition.trim().isNotEmpty,
                          orElse: () => '',
                        ),
                  );
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('단어장에 저장했습니다'),
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                  }
                } catch (_) {
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('단어장을 저장하지 못했습니다'),
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                  }
                }
              },
      icon: Icon(
        isSaved ? Icons.bookmark_rounded : Icons.bookmark_add_outlined,
      ),
    );
  }
}

class _PronunciationButton extends ConsumerStatefulWidget {
  const _PronunciationButton({required this.word});

  final String word;

  @override
  ConsumerState<_PronunciationButton> createState() =>
      _PronunciationButtonState();
}

class _PronunciationButtonState extends ConsumerState<_PronunciationButton> {
  bool _isSpeaking = false;

  Future<void> _speak() async {
    if (_isSpeaking) return;
    setState(() => _isSpeaking = true);
    final spoken = await ref
        .read(pronunciationServiceProvider)
        .speak(widget.word);
    if (!mounted) return;
    setState(() => _isSpeaking = false);
    if (!spoken) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('기기에 영어 음성이 설치되어 있지 않습니다.')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      tooltip: '발음 듣기',
      onPressed: _isSpeaking ? null : _speak,
      icon:
          _isSpeaking
              ? const SizedBox.square(
                dimension: 20,
                child: CircularProgressIndicator(strokeWidth: 2),
              )
              : const Icon(Icons.volume_up_rounded),
    );
  }
}

class _KoreanMeaningPanel extends StatelessWidget {
  const _KoreanMeaningPanel({required this.text, required this.label});

  final String text;
  final String label;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: colorScheme.primaryContainer.withAlpha(110),
        borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
        border: Border.all(color: colorScheme.primary.withAlpha(40)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: AppTypography.labelMedium.copyWith(
              color: colorScheme.primary,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            text,
            style: AppTypography.titleMedium.copyWith(
              color: colorScheme.onSurface,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}

class _SenseBlock extends StatelessWidget {
  const _SenseBlock({required this.sense});

  final WordSense sense;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _PartOfSpeechChip(label: _posLabel(sense)),
          if (sense.hasKoreanDefinition) ...[
            const SizedBox(height: AppSpacing.sm),
            _BodyText(
              sense.displayDefinitionKo,
              color: colorScheme.primary,
              fontWeight: FontWeight.w700,
            ),
          ],
          if (sense.hasKoreanBibleDefinition) ...[
            const SizedBox(height: AppSpacing.sm),
            _BibleMeaning(text: sense.displayBibleDefinition),
          ],
          if (sense.isArchaic) ...[
            const SizedBox(height: AppSpacing.sm),
            const _MetaChip(icon: Icons.history_rounded, label: '고어'),
          ],
          if (sense.examples.isNotEmpty) ...[
            const SizedBox(height: AppSpacing.sm),
            ...sense.examples.take(3).map(_ExampleLine.new),
          ],
        ],
      ),
    );
  }
}

class _BibleMeaning extends StatelessWidget {
  const _BibleMeaning({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: colorScheme.secondaryContainer.withAlpha(100),
        borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.auto_stories_outlined,
            size: AppSpacing.iconSm,
            color: colorScheme.secondary,
          ),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Text(
              text,
              style: AppTypography.bodyMedium.copyWith(
                color: colorScheme.onSurface,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ExampleLine extends StatelessWidget {
  const _ExampleLine(this.example);

  final WordExample example;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.only(top: AppSpacing.xs),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            example.isBibleExample
                ? Icons.menu_book_rounded
                : Icons.format_quote_rounded,
            size: AppSpacing.iconXs,
            color: colorScheme.onSurfaceVariant,
          ),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  example.text,
                  style: AppTypography.bodySmall.copyWith(
                    color: colorScheme.onSurfaceVariant,
                    height: 1.45,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                if (example.sourceReference.isNotEmpty)
                  Text(
                    example.sourceReference,
                    style: AppTypography.labelSmall.copyWith(
                      color: colorScheme.primary,
                      fontWeight: FontWeight.w700,
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

class _InflectionWrap extends StatelessWidget {
  const _InflectionWrap({required this.forms});

  final List<InflectedForm> forms;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: AppSpacing.sm,
      runSpacing: AppSpacing.sm,
      children:
          forms
              .map(
                (form) => _LabelValueChip(
                  label: form.formTypeLabel,
                  value: form.form,
                ),
              )
              .toList(),
    );
  }
}

class _WordChipSection extends StatelessWidget {
  const _WordChipSection({
    required this.icon,
    required this.label,
    required this.words,
    required this.bookId,
    required this.chapter,
    required this.verse,
    required this.translationCode,
  });

  final IconData icon;
  final String label;
  final List<String> words;
  final int bookId;
  final int chapter;
  final int verse;
  final String translationCode;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _SectionTitle(icon: icon, label: label),
        const SizedBox(height: AppSpacing.sm),
        Wrap(
          spacing: AppSpacing.sm,
          runSpacing: AppSpacing.sm,
          children:
              words
                  .where((word) => word.trim().isNotEmpty)
                  .map(
                    (word) => ActionChip(
                      label: Text(word),
                      labelStyle: AppTypography.labelMedium.copyWith(
                        color: colorScheme.onSurfaceVariant,
                      ),
                      backgroundColor: colorScheme.surfaceContainerHighest,
                      visualDensity: VisualDensity.compact,
                      onPressed:
                          () => DictionaryBottomSheet.show(
                            context,
                            word,
                            bookId: bookId,
                            chapter: chapter,
                            verse: verse,
                            translationCode: translationCode,
                          ),
                    ),
                  )
                  .toList(),
        ),
      ],
    );
  }
}

class _NotFoundContent extends StatelessWidget {
  const _NotFoundContent({required this.word});

  final String word;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.all(AppSpacing.xl),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const _SheetHandle(),
          const Spacer(),
          Icon(
            Icons.search_off_rounded,
            size: 52,
            color: colorScheme.onSurfaceVariant,
          ),
          const SizedBox(height: AppSpacing.lg),
          Text(
            word,
            style: AppTypography.headlineSmall.copyWith(
              color: colorScheme.onSurface,
              fontFamily: 'NotoSerif',
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            '아직 오프라인 사전에 없는 단어입니다.',
            style: AppTypography.bodyMedium.copyWith(
              color: colorScheme.onSurfaceVariant,
            ),
            textAlign: TextAlign.center,
          ),
          const Spacer(),
        ],
      ),
    );
  }
}

class _LoadingContent extends StatelessWidget {
  const _LoadingContent();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(AppSpacing.xl),
      child: Column(
        children: [_SheetHandle(), Spacer(), InlineLoader(), Spacer()],
      ),
    );
  }
}

class _SheetHandle extends StatelessWidget {
  const _SheetHandle();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Center(
      child: Container(
        width: AppSpacing.bottomSheetHandleWidth,
        height: AppSpacing.bottomSheetHandleHeight,
        margin: const EdgeInsets.only(bottom: AppSpacing.lg),
        decoration: BoxDecoration(
          color: colorScheme.outlineVariant,
          borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
        ),
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Row(
      children: [
        Icon(icon, size: AppSpacing.iconSm, color: colorScheme.primary),
        const SizedBox(width: AppSpacing.xs),
        Text(
          label,
          style: AppTypography.titleSmall.copyWith(
            color: colorScheme.onSurface,
            fontWeight: FontWeight.w800,
          ),
        ),
      ],
    );
  }
}

class _BodyText extends StatelessWidget {
  const _BodyText(this.text, {this.color, this.fontWeight});

  final String text;
  final Color? color;
  final FontWeight? fontWeight;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: AppTypography.bodyMedium.copyWith(
        color: color ?? Theme.of(context).colorScheme.onSurface,
        fontWeight: fontWeight,
        height: 1.55,
      ),
    );
  }
}

class _MetaChip extends StatelessWidget {
  const _MetaChip({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: AppSpacing.xs,
      ),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: AppSpacing.iconXs, color: colorScheme.primary),
          const SizedBox(width: AppSpacing.xs),
          Text(
            label,
            style: AppTypography.labelSmall.copyWith(
              color: colorScheme.onSurfaceVariant,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

class _PartOfSpeechChip extends StatelessWidget {
  const _PartOfSpeechChip({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: 3,
      ),
      decoration: BoxDecoration(
        color: colorScheme.secondaryContainer,
        borderRadius: BorderRadius.circular(AppSpacing.radiusXs),
      ),
      child: Text(
        label,
        style: AppTypography.labelSmall.copyWith(
          color: colorScheme.onSecondaryContainer,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }
}

class _LabelValueChip extends StatelessWidget {
  const _LabelValueChip({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: AppSpacing.xs,
      ),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: AppTypography.labelSmall.copyWith(
              color: colorScheme.onSurfaceVariant,
            ),
          ),
          Text(
            value,
            style: AppTypography.labelMedium.copyWith(
              color: colorScheme.onSurface,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }
}

String _koreanMeaning(DictionaryEntry entry) {
  final biblicalMeaning = _biblicalKoreanMeaning(entry);
  if (biblicalMeaning.isNotEmpty) return biblicalMeaning;

  if (entry.displayKoreanMeaning.isNotEmpty) {
    return entry.displayKoreanMeaning;
  }

  for (final sense in entry.senses) {
    if (sense.hasKoreanDefinition) {
      return sense.displayDefinitionKo;
    }
  }

  return '';
}

List<WordSense> _visibleKoreanSenses(DictionaryEntry entry) {
  final senses = entry.senses
      .where(
        (sense) => sense.hasKoreanDefinition || sense.hasKoreanBibleDefinition,
      )
      .toList(growable: true);
  if (_hasInjectedBiblicalFirstSense(entry) ||
      _hasMismatchedImportedFirstSense(entry, koreanSenses: senses)) {
    senses.removeAt(0);
  }
  return senses;
}

String _biblicalKoreanMeaning(DictionaryEntry entry) {
  final meaning = bibleWordKoreanDict[entry.wordNormalized];
  return DictionaryMeaningFormatter.format(meaning ?? '');
}

bool _hasInjectedBiblicalFirstSense(DictionaryEntry entry) {
  if (entry.senses.isEmpty) return false;
  final biblicalMeaning = _biblicalKoreanMeaning(entry);
  if (biblicalMeaning.isEmpty) return false;

  final first = entry.senses.first;
  return first.definition.trim().isNotEmpty &&
      first.displayDefinitionKo == biblicalMeaning;
}

bool _hasMismatchedImportedFirstSense(
  DictionaryEntry entry, {
  List<WordSense>? koreanSenses,
}) {
  if (entry.senses.isEmpty) return false;
  final senses =
      koreanSenses ??
      entry.senses
          .where(
            (sense) =>
                sense.hasKoreanDefinition || sense.hasKoreanBibleDefinition,
          )
          .toList(growable: false);
  if (senses.length < 2 || !identical(senses.first, entry.senses.first)) {
    return false;
  }

  return entry.senses.first.definition.trim().isNotEmpty &&
      senses.skip(1).any((sense) => sense.hasKoreanDefinition);
}

String _preferredPartOfSpeech(DictionaryEntry entry) {
  final visibleSenses = _visibleKoreanSenses(entry);
  if (visibleSenses.isNotEmpty) return visibleSenses.first.partOfSpeech;
  return entry.primaryPartOfSpeech;
}

String _posLabel(WordSense sense) {
  if (sense.partOfSpeech == 'unknown') return '단어';
  return sense.posLabel;
}
