import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:offline_english_bible/features/dictionary/domain/entities/dictionary_entry.dart';
import 'package:offline_english_bible/features/dictionary/domain/services/dictionary_meaning_formatter.dart';

void main() {
  test('every bundled word has a compact Korean display meaning', () async {
    final file = File('assets/data/dictionary_full.json');
    final entries = jsonDecode(await file.readAsString()) as List<dynamic>;

    expect(entries.length, greaterThanOrEqualTo(9800));

    for (final rawEntry in entries) {
      final entry = rawEntry as Map<String, dynamic>;
      final word = entry['word'] as String;
      final formatted = DictionaryMeaningFormatter.format(
        entry['korean_meaning'] as String? ?? '',
      );

      expect(
        formatted,
        isNotEmpty,
        reason: '$word must have a visible Korean meaning',
      );
      expect(
        DictionaryMeaningFormatter.containsKorean(formatted),
        isTrue,
        reason: '$word must display Korean text',
      );
      expect(
        formatted.length,
        lessThanOrEqualTo(DictionaryMeaningFormatter.defaultMaxLength),
        reason: '$word display meaning is too long',
      );

      for (final rawSense in entry['senses'] as List<dynamic>? ?? const []) {
        final sense = rawSense as Map<String, dynamic>;
        final sourcePos = sense['pos'] as String? ?? 'unknown';
        final label =
            WordSense(
              id: 0,
              partOfSpeech: sourcePos,
              senseOrder: 0,
              definition: '',
            ).posLabel;
        expect(
          DictionaryMeaningFormatter.containsKorean(label),
          isTrue,
          reason: '$word exposes raw part-of-speech label $sourcePos',
        );
        expect(label, isNot(contains('_')));
      }

      for (final rawForm
          in entry['inflections'] as List<dynamic>? ?? const []) {
        final form = rawForm as Map<String, dynamic>;
        final sourceType = form['type'] as String? ?? '';
        final value = form['form'] as String? ?? '';
        final label =
            InflectedForm(formType: sourceType, form: value).formTypeLabel;
        expect(
          value.trim(),
          isNotEmpty,
          reason: '$word has an empty inflection',
        );
        expect(
          DictionaryMeaningFormatter.containsKorean(label),
          isTrue,
          reason: '$word exposes raw inflection label $sourceType',
        );
        expect(label, isNot(contains('_')));
      }
    }
  });

  test('unknown dictionary labels never expose internal source values', () {
    const sense = WordSense(
      id: 0,
      partOfSpeech: 'source_internal_code',
      senseOrder: 0,
      definition: '',
    );

    expect(sense.posLabel, '단어');
    expect(
      const InflectedForm(
        formType: 'source_internal_code',
        form: 'word',
      ).formTypeLabel,
      '활용형',
    );
  });
}
