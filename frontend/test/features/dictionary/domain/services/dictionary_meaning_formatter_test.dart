import 'package:flutter_test/flutter_test.dart';
import 'package:offline_english_bible/features/dictionary/domain/services/dictionary_meaning_formatter.dart';

void main() {
  group('DictionaryMeaningFormatter', () {
    test('removes imported English notes while preserving Korean context', () {
      const value =
          '종이, 시험지 (A sheet material used for writing on.); '
          '우리야(Bathsheba의 남편); Learning English (public domain)';

      expect(
        DictionaryMeaningFormatter.format(value),
        '종이, 시험지, 우리야(Bathsheba의 남편)',
      );
    });

    test('removes source-only and audio prompt fragments', () {
      expect(
        DictionaryMeaningFormatter.format(
          '은혜; 음성 듣기 미국; Learning English (public domain)',
        ),
        '은혜',
      );
      expect(
        DictionaryMeaningFormatter.format('Learning English (public domain)'),
        isEmpty,
      );
    });

    test(
      'compacts long comma-delimited meanings without breaking the limit',
      () {
        final value = List.generate(
          80,
          (index) => '한국어 뜻 ${index + 1}',
        ).join(', ');
        final formatted = DictionaryMeaningFormatter.format(value);

        expect(
          formatted.length,
          lessThanOrEqualTo(DictionaryMeaningFormatter.defaultMaxLength),
        );
        expect(formatted, startsWith('한국어 뜻 1, 한국어 뜻 2'));
        expect(formatted, endsWith('…'));
      },
    );

    test('uses a safe generic label for unknown source codes', () {
      expect(DictionaryMeaningFormatter.containsKorean('은혜'), isTrue);
      expect(DictionaryMeaningFormatter.containsKorean('grace'), isFalse);
    });

    test('rejects unusably small maximum lengths', () {
      expect(
        () => DictionaryMeaningFormatter.format('은혜', maxLength: 1),
        throwsArgumentError,
      );
    });
  });
}
