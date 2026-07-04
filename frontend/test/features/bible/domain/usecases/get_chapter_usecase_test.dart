// test/features/bible/domain/usecases/get_chapter_usecase_test.dart
// [NEW] GetChapterUseCase 유닛 테스트

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:offline_english_bible/core/error/failures.dart';
import 'package:offline_english_bible/core/utils/result.dart';
import 'package:offline_english_bible/features/bible/domain/entities/book.dart';
import 'package:offline_english_bible/features/bible/domain/entities/chapter_content.dart';
import 'package:offline_english_bible/features/bible/domain/entities/verse.dart';
import 'package:offline_english_bible/features/bible/domain/repositories/bible_repository.dart';
import 'package:offline_english_bible/features/bible/domain/usecases/get_chapter_usecase.dart';

class _MockBibleRepository extends Mock implements BibleRepository {}

void main() {
  late _MockBibleRepository mockRepo;
  late GetChapterUseCase useCase;

  const genesisBook = Book(
    id: 1,
    name: 'Genesis',
    nameKorean: '창세기',
    abbreviation: 'Gen',
    abbreviationKorean: '창',
    testament: 'OT',
    orderIndex: 1,
    chapterCount: 50,
  );

  final genesis1Verses = List.generate(
    31,
    (i) => Verse(
      bookId: 1,
      chapter: 1,
      verseNumber: i + 1,
      text: 'Verse ${i + 1} text',
      translationCode: 'KJV',
    ),
  );

  final genesis1Content = ChapterContent(
    book: genesisBook,
    chapterNumber: 1,
    verses: genesis1Verses,
    translationCode: 'KJV',
  );

  setUp(() {
    mockRepo = _MockBibleRepository();
    useCase = GetChapterUseCase(mockRepo);
  });

  setUpAll(() {
    registerFallbackValue(const GetChapterParams(
      bookId: 1,
      chapter: 1,
      translationCode: 'KJV',
    ));
  });

  group('GetChapterUseCase', () {
    test('returns ChapterContent on success', () async {
      when(
        () => mockRepo.getChapter(
          bookId: 1,
          chapter: 1,
          translationCode: 'KJV',
          parallelTranslationCode: null,
        ),
      ).thenAnswer((_) async => Success(genesis1Content));

      final result = await useCase(
        const GetChapterParams(bookId: 1, chapter: 1, translationCode: 'KJV'),
      );

      expect(result.isSuccess, isTrue);
      expect(result.valueOrNull?.verseCount, 31);
      expect(result.valueOrNull?.book.name, 'Genesis');
    });

    test('returns failure when chapter not found', () async {
      when(
        () => mockRepo.getChapter(
          bookId: 1,
          chapter: 999,
          translationCode: 'KJV',
          parallelTranslationCode: null,
        ),
      ).thenAnswer(
        (_) async =>
            const FailureResult(ChapterNotFoundFailure(book: 1, chapter: 999)),
      );

      final result = await useCase(
        const GetChapterParams(bookId: 1, chapter: 999, translationCode: 'KJV'),
      );

      expect(result.isFailure, isTrue);
      expect(result.failureOrNull, isA<ChapterNotFoundFailure>());
    });

    test('passes parallelTranslationCode to repository', () async {
      when(
        () => mockRepo.getChapter(
          bookId: 1,
          chapter: 1,
          translationCode: 'KJV',
          parallelTranslationCode: 'KOREAN_RV',
        ),
      ).thenAnswer((_) async => Success(genesis1Content));

      await useCase(
        const GetChapterParams(
          bookId: 1,
          chapter: 1,
          translationCode: 'KJV',
          parallelTranslationCode: 'KOREAN_RV',
        ),
      );

      verify(
        () => mockRepo.getChapter(
          bookId: 1,
          chapter: 1,
          translationCode: 'KJV',
          parallelTranslationCode: 'KOREAN_RV',
        ),
      ).called(1);
    });
  });

  group('GetChapterParams', () {
    test('nextChapter increments chapter', () {
      const params = GetChapterParams(bookId: 1, chapter: 1, translationCode: 'KJV');
      final next = params.nextChapter();
      expect(next.chapter, 2);
      expect(next.bookId, 1);
    });

    test('previousChapter decrements chapter', () {
      const params = GetChapterParams(bookId: 1, chapter: 5, translationCode: 'KJV');
      final prev = params.previousChapter();
      expect(prev.chapter, 4);
    });

    test('previousChapter stays at 1 if already at first chapter', () {
      const params = GetChapterParams(bookId: 1, chapter: 1, translationCode: 'KJV');
      final prev = params.previousChapter();
      expect(prev.chapter, 1);
    });
  });

  group('ChapterContent', () {
    test('verseAt returns correct verse', () {
      final content = genesis1Content;
      final verse = content.verseAt(3);
      expect(verse, isNotNull);
      expect(verse!.verseNumber, 3);
    });

    test('verseAt returns null for nonexistent verse', () {
      expect(genesis1Content.verseAt(999), isNull);
    });

    test('hasPreviousChapter false when chapter == 1', () {
      expect(genesis1Content.hasPreviousChapter, isFalse);
    });

    test('hasNextChapter true when chapter < chapterCount', () {
      expect(genesis1Content.hasNextChapter, isTrue);
    });

    test('hasParallelVerses false when null', () {
      expect(genesis1Content.hasParallelVerses, isFalse);
    });

    test('hasParallelVerses true when parallel verses provided', () {
      final content = genesis1Content.copyWith(
        parallelVerses: [
          const Verse(
            bookId: 1,
            chapter: 1,
            verseNumber: 1,
            text: '태초에',
            translationCode: 'KOREAN_RV',
          ),
        ],
      );
      expect(content.hasParallelVerses, isTrue);
    });
  });
}
