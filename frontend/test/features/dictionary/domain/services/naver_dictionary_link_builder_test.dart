// test/features/dictionary/domain/services/naver_dictionary_link_builder_test.dart

import 'package:flutter_test/flutter_test.dart';
import 'package:offline_english_bible/features/dictionary/domain/services/naver_dictionary_link_builder.dart';

void main() {
  const builder = NaverDictionaryLinkBuilder();

  group('NaverDictionaryLinkBuilder', () {
    test('builds a Naver English Dictionary search URL', () {
      final uri = builder.buildSearchUri('grace');

      expect(uri.toString(), 'https://en.dict.naver.com/#/search?query=grace');
    });

    test('trims surrounding punctuation from tapped Bible words', () {
      final uri = builder.buildSearchUri('  "grace."  ');

      expect(uri.toString(), 'https://en.dict.naver.com/#/search?query=grace');
    });

    test('encodes words before placing them in the Naver hash route', () {
      final uri = builder.buildSearchUri("God's grace");

      expect(
        uri.toString(),
        'https://en.dict.naver.com/#/search?query=God%27s%20grace',
      );
    });

    test('normalizes smart apostrophes', () {
      final uri = builder.buildSearchUri('God\u2019s');

      expect(
        uri.toString(),
        'https://en.dict.naver.com/#/search?query=God%27s',
      );
    });

    test('throws for an empty search term', () {
      expect(
        () => builder.buildSearchUri(' ... '),
        throwsA(isA<ArgumentError>()),
      );
    });
  });
}
