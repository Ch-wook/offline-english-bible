// lib/features/dictionary/data/mappers/dictionary_mapper.dart
// [NEW] Drift 데이터클래스 → 도메인 엔티티 변환 매퍼

import '../../../../core/database/app_database.dart';
import '../../domain/entities/dictionary_entry.dart';

abstract final class DictionaryEntryMapper {
  static DictionaryEntry toDomain({
    required DictionaryEntries$Row row,
    required List<Senses$Row> senses,
    required List<List<Examples$Row>> examples,
    required List<WordNetRelations$Row> relations,
    required List<Inflections$Row> inflections,
  }) {
    final domainSenses = <WordSense>[];
    for (var i = 0; i < senses.length; i++) {
      final sense = senses[i];
      final senseExamples = i < examples.length ? examples[i] : <Examples$Row>[];

      domainSenses.add(
        WordSense(
          id: sense.id,
          partOfSpeech: sense.partOfSpeech,
          senseOrder: sense.senseOrder,
          definition: sense.definition,
          bibleDefinition: sense.bibleDefinition ?? '',
          register: sense.register ?? '',
          isArchaic: sense.isArchaic ?? false,
          examples: senseExamples
              .map(
                (e) => WordExample(
                  text: e.text,
                  type: e.type,
                  sourceReference: e.sourceReference ?? '',
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
          synonyms.add(r.relatedWord);
        case 'antonym':
          antonyms.add(r.relatedWord);
        default:
          relatedWords.add(r.relatedWord);
      }
    }

    return DictionaryEntry(
      id: row.id,
      word: row.word,
      wordNormalized: row.wordNormalized,
      ipaUs: row.ipaUs ?? '',
      ipaUk: row.ipaUk ?? '',
      frequencyRank: row.frequencyRank ?? 999999,
      bibleFrequency: row.bibleFrequency ?? 0,
      etymology: row.etymology ?? '',
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
    );
  }
}
