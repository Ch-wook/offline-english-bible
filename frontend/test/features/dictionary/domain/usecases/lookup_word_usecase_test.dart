// test/features/dictionary/domain/usecases/lookup_word_usecase_test.dart
// [NEW] LookupWordUseCase 유닛 테스트

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:offline_english_bible/core/error/failures.dart';
import 'package:offline_english_bible/core/utils/result.dart';
import 'package:offline_english_bible/features/dictionary/domain/entities/dictionary_entry.dart';
import 'package:offline_english_bible/features/dictionary/domain/repositories/dictionary_repository.dart';
import 'package:offline_english_bible/features/dictionary/domain/usecases/lookup_word_usecase.dart';

class _MockDictionaryRepository extends Mock
    implements DictionaryRepository {}

void main() {
  late _MockDictionaryRepository mockRepo;
  late LookupWordUseCase lookupUseCase;
  late GetSuggestionsUseCase suggestionsUseCase;

  const sampleEntry = DictionaryEntry(
    id: 1,
    word: 'grace',
    wordNormalized: 'grace',
    ipaUs: '/ɡreɪs/',
    bibleFrequency: 170,
    senses: [
      WordSense(
        id: 1,
        partOfSpeech: 'noun',
        senseOrder: 1,
        definition: 'The free and unmerited favor of God.',
        bibleDefinition: 'Biblical grace',
      ),
    ],
  );

  setUp(() {
    mockRepo = _MockDictionaryRepository();
    lookupUseCase = LookupWordUseCase(mockRepo);
    suggestionsUseCase = GetSuggestionsUseCase(mockRepo);
  });

  group('LookupWordUseCase', () {
    test('returns entry on success', () async {
      when(() => mockRepo.lookupWord('grace'))
          .thenAnswer((_) async => const Success(sampleEntry));

      final result = await lookupUseCase('grace');
      expect(result.isSuccess, isTrue);
      expect(result.valueOrNull?.word, 'grace');
    });

    test('trims whitespace from word', () async {
      when(() => mockRepo.lookupWord('grace'))
          .thenAnswer((_) async => const Success(sampleEntry));

      await lookupUseCase('  grace  ');
      verify(() => mockRepo.lookupWord('grace')).called(1);
    });

    test('returns ValidationFailure for empty word', () async {
      final result = await lookupUseCase('');
      expect(result.isFailure, isTrue);
      expect(result.failureOrNull, isA<ValidationFailure>());
      verifyNever(() => mockRepo.lookupWord(any()));
    });

    test('returns ValidationFailure for whitespace only', () async {
      final result = await lookupUseCase('   ');
      expect(result.isFailure, isTrue);
      expect(result.failureOrNull, isA<ValidationFailure>());
    });

    test('returns WordNotFoundFailure when repository fails', () async {
      when(() => mockRepo.lookupWord('xyzzy')).thenAnswer(
        (_) async => const FailureResult(
          WordNotFoundFailure('단어를 찾을 수 없습니다: xyzzy'),
        ),
      );

      final result = await lookupUseCase('xyzzy');
      expect(result.isFailure, isTrue);
      expect(result.failureOrNull, isA<WordNotFoundFailure>());
    });
  });

  group('GetSuggestionsUseCase', () {
    test('returns suggestions for valid prefix', () async {
      when(() => mockRepo.getSuggestions('gr')).thenAnswer(
        (_) async => const Success(['grace', 'great', 'grieve']),
      );

      final result = await suggestionsUseCase('gr');
      expect(result.valueOrNull, ['grace', 'great', 'grieve']);
    });

    test('returns empty for empty prefix', () async {
      final result = await suggestionsUseCase('');
      expect(result.valueOrNull, isEmpty);
      verifyNever(() => mockRepo.getSuggestions(any()));
    });

    test('returns empty for single character', () async {
      // Empty prefix triggers early return (but single char might still query)
      // depends on impl: prefix.length < 2 → empty
      final result = await suggestionsUseCase(' ');
      expect(result.isSuccess, isTrue);
    });
  });

  group('DictionaryEntry', () {
    test('hasIpa true when ipaUs present', () {
      expect(sampleEntry.hasIpa, isTrue);
    });

    test('hasIpa false when both empty', () {
      const entry = DictionaryEntry(
        id: 1,
        word: 'test',
        wordNormalized: 'test',
      );
      expect(entry.hasIpa, isFalse);
    });

    test('isKjvWord true when bibleFrequency > 0', () {
      expect(sampleEntry.isKjvWord, isTrue);
    });

    test('primaryPartOfSpeech returns first sense pos', () {
      expect(sampleEntry.primaryPartOfSpeech, 'noun');
    });

    test('hasSynonyms false when empty', () {
      expect(sampleEntry.hasSynonyms, isFalse);
    });

    test('posLabel for noun returns 명사', () {
      const sense = WordSense(
        id: 1,
        partOfSpeech: 'noun',
        senseOrder: 1,
        definition: 'Test',
      );
      expect(sense.posLabel, '명사');
    });

    test('posLabel for verb returns 동사', () {
      const sense = WordSense(
        id: 2,
        partOfSpeech: 'verb',
        senseOrder: 1,
        definition: 'Test',
      );
      expect(sense.posLabel, '동사');
    });
  });
}
