// lib/features/dictionary/data/mappers/dictionary_mapper.dart
// [NEW] Drift 데이터클래스 → 도메인 엔티티 변환 매퍼

import 'dart:convert';

import '../../../../core/database/app_database.dart';
import '../../domain/entities/dictionary_entry.dart';

abstract final class DictionaryEntryMapper {
  static DictionaryEntry toDomain({
    required DictionaryEntryData row,
    required List<WordSenseData> senses,
    required List<List<WordExampleData>> examples,
    required List<WordFormData> inflections,
  }) {
    final domainSenses = <WordSense>[];
    final koreanMeaning = row.koreanMeaning;

    for (var i = 0; i < senses.length; i++) {
      final sense = senses[i];
      final senseExamples =
          i < examples.length ? examples[i] : <WordExampleData>[];

      domainSenses.add(
        WordSense(
          id: sense.id,
          partOfSpeech: sense.partOfSpeech,
          senseOrder: sense.senseOrder,
          definition: sense.definition,
          definitionKo: sense.definitionKo,
          bibleDefinition: sense.bibleDefinition,
          register: sense.register,
          isArchaic: sense.isArchaic,
          examples:
              senseExamples
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
      synonyms: _decodeWords(row.synonymsJson),
      antonyms: _decodeWords(row.antonymsJson),
      relatedWords: _decodeWords(row.relatedWordsJson),
      inflectedForms:
          inflections
              .map((i) => InflectedForm(formType: i.formType, form: i.form))
              .toList(),
      koreanMeaning: koreanMeaning,
    );
  }

  static List<String> _decodeWords(String value) {
    try {
      return (jsonDecode(value) as List<dynamic>)
          .map((item) => item.toString())
          .where((item) => item.trim().isNotEmpty)
          .toList(growable: false);
    } catch (_) {
      return const [];
    }
  }
}
