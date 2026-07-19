import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

import '../../../scripts/src/kjv_contextual_korean_corrections.dart';
import '../../../scripts/src/parallel_bible_korean_enricher.dart';

void main() {
  test('reviewed contextual corrections are unique and bundled', () {
    final dictionary =
        (jsonDecode(File('assets/data/dictionary_full.json').readAsStringSync())
                as List<dynamic>)
            .cast<Map<String, dynamic>>();
    final byWord = {
      for (final entry in dictionary) entry['word']! as String: entry,
    };

    expect(kjvContextualKoreanCorrections, hasLength(635));
    for (final correction in kjvContextualKoreanCorrections.entries) {
      expect(
        byWord[correction.key]?['korean_meaning'],
        correction.value,
        reason: '${correction.key} must use its reviewed Korean meaning',
      );
    }
  });

  test('parallel Bible enrichment does not guess general-word meanings', () {
    final temp = Directory.systemTemp.createTempSync('parallel-bible-test-');
    addTearDown(() => temp.deleteSync(recursive: true));
    final kjv = File('${temp.path}/kjv.json')..writeAsStringSync(
      jsonEncode([
        {'b': 1, 'c': 1, 'v': 1, 't': 'A rareword appears here.'},
      ]),
    );
    final korean = File('${temp.path}/korean.json')..writeAsStringSync(
      jsonEncode([
        {'b': 1, 'c': 1, 'v': 1, 't': '희귀한 낱말이 여기에 나온다.'},
      ]),
    );
    final entries = <Map<String, dynamic>>[
      {
        'word': 'rareword',
        'korean_meaning': '',
        'senses': [
          {
            'pos': 'unknown',
            'definition': 'A rare word.',
            'definition_ko': '',
            'bible_definition': '',
          },
        ],
        'inflections': <Map<String, dynamic>>[],
      },
    ];

    final report = enrichFromParallelBible(
      entries: entries,
      kjvPath: kjv.path,
      koreanPath: korean.path,
    );

    expect(report.contextMeanings, 0);
    expect(report.unresolved, 1);
    expect(entries.single['korean_meaning'], isEmpty);
    expect(
      (entries.single['senses']! as List<dynamic>).single['definition_ko'],
      isEmpty,
    );
  });
}
