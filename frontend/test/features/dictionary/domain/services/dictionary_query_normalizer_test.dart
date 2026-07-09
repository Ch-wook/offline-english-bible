// test/features/dictionary/domain/services/dictionary_query_normalizer_test.dart

import 'package:flutter_test/flutter_test.dart';
import 'package:offline_english_bible/features/dictionary/domain/services/dictionary_query_normalizer.dart';

void main() {
  const normalizer = DictionaryQueryNormalizer();

  group('DictionaryQueryNormalizer', () {
    test('lowercases tapped words', () {
      expect(normalizer.normalize('Grace'), 'grace');
    });

    test('trims punctuation around Bible tokens', () {
      expect(normalizer.normalize(' "grace." '), 'grace');
    });

    test('normalizes smart apostrophes', () {
      expect(normalizer.normalize('Lord\u2019s'), 'lord');
    });

    test('strips possessive suffixes for dictionary lookup', () {
      expect(normalizer.normalize("God's"), 'god');
    });

    test('returns empty for punctuation only', () {
      expect(normalizer.normalize('...'), isEmpty);
    });
  });
}
