// lib/features/dictionary/data/mappers/dictionary_mapper.dart
// [NEW] Drift 데이터클래스 → 도메인 엔티티 변환 매퍼

import '../../../../core/data/bible_word_korean_dict.dart';
import '../../../../core/database/app_database.dart';
import '../../domain/entities/dictionary_entry.dart';

abstract final class DictionaryEntryMapper {
  static DictionaryEntry toDomain({
    required DictionaryEntryData row,
    required List<WordSenseData> senses,
    required List<List<WordExampleData>> examples,
    required List<WordnetRelationData> relations,
    required List<WordFormData> inflections,
  }) {
    final domainSenses = <WordSense>[];
    final koreanMeaning = bibleWordKoreanDict[row.wordNormalized] ?? '';

    for (var i = 0; i < senses.length; i++) {
      final sense = senses[i];
      final senseExamples = i < examples.length ? examples[i] : <WordExampleData>[];

      domainSenses.add(
        WordSense(
          id: sense.id,
          partOfSpeech: sense.partOfSpeech,
          senseOrder: sense.senseOrder,
          definition: sense.definition,
          definitionKo: i == 0 ? koreanMeaning : '', // 첫 번째 sense에만 전체 의미 할당 (또는 구조상 모든 sense에 할당해도 됨)
          bibleDefinition: sense.bibleDefinition,
          register: sense.register,
          isArchaic: sense.isArchaic,
          examples: senseExamples
              .map(
                (e) => WordExample(
                  text: e.textContent,
                  type: e.exampleType,
                  sourceReference: e.sourceReference,
                ),
              )
              .toList(),
        ),
      );
    }

    // WordNet 관계 분류
    final synonyms = <String>[];
    final antonyms = <String>[];
    final relatedWords = <String>[];
    for (final r in relations) {
      switch (r.relationType) {
        case 'synonym':
          synonyms.add(r.toSynsetId.toString());
        case 'antonym':
          antonyms.add(r.toSynsetId.toString());
        default:
          relatedWords.add(r.toSynsetId.toString());
      }
    }

    return DictionaryEntry(
      id: row.id,
      word: row.word,
      wordNormalized: row.wordNormalized,
      ipaUs: row.ipaUs,
      ipaUk: row.ipaUk,
      frequencyRank: row.frequencyRank,
      bibleFrequency: row.bibleFrequency,
      etymology: row.etymology,
      senses: domainSenses,
      synonyms: synonyms,
      antonyms: antonyms,
      relatedWords: relatedWords,
      inflectedForms: inflections
          .map(
            (i) => InflectedForm(
              formType: i.formType,
              form: i.form,
            ),
          )
          .toList(),
      koreanMeaning: koreanMeaning,
    );
  }
}
