import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

void main() {
  test('bundled Bibles and dictionary cover every tappable KJV word', () {
    final kjv = _loadList('assets/data/kjv_full.json');
    final korean = _loadList('assets/data/korean_rv_full.json');
    final dictionary = _loadList('assets/data/dictionary_full.json');

    expect(kjv, hasLength(31102));
    expect(korean.length, greaterThanOrEqualTo(31102));
    expect(dictionary.length, greaterThan(9000));

    final words = <String>{};
    for (final rawVerse in kjv) {
      final verse = rawVerse as Map<String, dynamic>;
      words.addAll(_tokenize(verse['t']! as String));
    }

    final entryWords = <String>{};
    final forms = <String>{};
    final entriesByWord = <String, Map<String, dynamic>>{};
    for (final rawEntry in dictionary) {
      final entry = rawEntry as Map<String, dynamic>;
      final word = entry['word']! as String;
      entryWords.add(word);
      entriesByWord[word] = entry;
      for (final rawForm in entry['inflections']! as List<dynamic>) {
        forms.add((rawForm as Map<String, dynamic>)['form']! as String);
      }
    }

    final missing = words.difference({...entryWords, ...forms});
    expect(missing, isEmpty, reason: 'Missing KJV words: ${missing.take(30)}');
    expect(words.length, greaterThan(12000));

    for (final word in ['grace', 'beginning', 'create', 'love', 'jesus']) {
      final entry = entriesByWord[word];
      expect(entry, isNotNull, reason: '$word must have a dictionary entry');
      final senses = entry!['senses']! as List<dynamic>;
      expect(senses, isNotEmpty);
      expect(
        senses.any((rawSense) {
          final sense = rawSense as Map<String, dynamic>;
          return (sense['definition']! as String).isNotEmpty ||
              (sense['definition_ko']! as String).isNotEmpty;
        }),
        isTrue,
      );
    }
  });
}

List<dynamic> _loadList(String path) =>
    jsonDecode(File(path).readAsStringSync()) as List<dynamic>;

Iterable<String> _tokenize(String text) sync* {
  final pattern = RegExp(r"[A-Za-z]+(?:['’][A-Za-z]+)*");
  for (final match in pattern.allMatches(text)) {
    var word = match.group(0)!.toLowerCase().replaceAll('’', "'");
    if (word.endsWith("'s") && word.length > 2) {
      word = word.substring(0, word.length - 2);
    }
    yield word;
  }
}
