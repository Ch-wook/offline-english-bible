// test/features/bible/domain/usecases/get_all_books_usecase_test.dart
// [NEW] GetAllBooksUseCase 유닛 테스트

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:offline_english_bible/core/error/failures.dart';
import 'package:offline_english_bible/core/utils/result.dart';
import 'package:offline_english_bible/features/bible/domain/entities/book.dart';
import 'package:offline_english_bible/features/bible/domain/repositories/bible_repository.dart';
import 'package:offline_english_bible/features/bible/domain/usecases/get_all_books_usecase.dart';

class _MockBibleRepository extends Mock implements BibleRepository {}

void main() {
  late _MockBibleRepository mockRepo;
  late GetAllBooksUseCase useCase;

  setUp(() {
    mockRepo = _MockBibleRepository();
    useCase = GetAllBooksUseCase(mockRepo);
  });

  // 테스트용 샘플 책 목록
  final sampleBooks = List.generate(
    66,
    (i) => Book(
      id: i + 1,
      name: 'Book ${i + 1}',
      nameKorean: '책 ${i + 1}',
      abbreviation: 'Bk${i + 1}',
      abbreviationKorean: '책${i + 1}',
      testament: i < 39 ? 'OT' : 'NT',
      orderIndex: i + 1,
      chapterCount: 10,
    ),
  );

  group('GetAllBooksUseCase', () {
    test('call() returns 66 books on success', () async {
      when(() => mockRepo.getAllBooks())
          .thenAnswer((_) async => Success(sampleBooks));

      final result = await useCase();

      expect(result.isSuccess, isTrue);
      expect(result.valueOrNull?.length, 66);
      verify(() => mockRepo.getAllBooks()).called(1);
    });

    test('call() returns FailureResult on repository error', () async {
      when(() => mockRepo.getAllBooks()).thenAnswer(
        (_) async => const FailureResult(DatabaseFailure('DB error')),
      );

      final result = await useCase();

      expect(result.isFailure, isTrue);
      expect(result.failureOrNull, isA<DatabaseFailure>());
    });

    test('grouped() separates OT and NT correctly', () async {
      when(() => mockRepo.getAllBooks())
          .thenAnswer((_) async => Success(sampleBooks));

      final result = await useCase.grouped();

      expect(result.isSuccess, isTrue);
      final grouped = result.valueOrNull!;
      expect(grouped.oldTestament.length, 39);
      expect(grouped.newTestament.length, 27);
      expect(grouped.totalBooks, 66);
    });

    test('grouped() returns failure when repository fails', () async {
      when(() => mockRepo.getAllBooks()).thenAnswer(
        (_) async => const FailureResult(DatabaseFailure('fail')),
      );

      final result = await useCase.grouped();
      expect(result.isFailure, isTrue);
    });

    test('all OT books have testament == OT', () async {
      when(() => mockRepo.getAllBooks())
          .thenAnswer((_) async => Success(sampleBooks));

      final result = await useCase.grouped();
      final ot = result.valueOrNull!.oldTestament;
      expect(ot.every((b) => b.isOldTestament), isTrue);
    });

    test('all NT books have testament == NT', () async {
      when(() => mockRepo.getAllBooks())
          .thenAnswer((_) async => Success(sampleBooks));

      final result = await useCase.grouped();
      final nt = result.valueOrNull!.newTestament;
      expect(nt.every((b) => b.isNewTestament), isTrue);
    });
  });

  group('Book entity', () {
    test('localizedName returns Korean when lang is ko', () {
      const book = Book(
        id: 1,
        name: 'Genesis',
        nameKorean: '창세기',
        abbreviation: 'Gen',
        abbreviationKorean: '창',
        testament: 'OT',
        orderIndex: 1,
        chapterCount: 50,
      );
      expect(book.localizedName('ko'), '창세기');
      expect(book.localizedName('en'), 'Genesis');
    });

    test('isOldTestament and isNewTestament work correctly', () {
      const ot = Book(
        id: 1, name: 'Gen', nameKorean: '창', abbreviation: 'Gen',
        abbreviationKorean: '창', testament: 'OT', orderIndex: 1, chapterCount: 50,
      );
      const nt = Book(
        id: 40, name: 'Matt', nameKorean: '마', abbreviation: 'Matt',
        abbreviationKorean: '마', testament: 'NT', orderIndex: 40, chapterCount: 28,
      );
      expect(ot.isOldTestament, isTrue);
      expect(ot.isNewTestament, isFalse);
      expect(nt.isNewTestament, isTrue);
      expect(nt.isOldTestament, isFalse);
    });

    test('Book equality is by id', () {
      const a = Book(
        id: 1, name: 'Genesis', nameKorean: '창세기', abbreviation: 'Gen',
        abbreviationKorean: '창', testament: 'OT', orderIndex: 1, chapterCount: 50,
      );
      const b = Book(
        id: 1, name: 'Different', nameKorean: '다름', abbreviation: 'Diff',
        abbreviationKorean: '다', testament: 'OT', orderIndex: 1, chapterCount: 10,
      );
      const c = Book(
        id: 2, name: 'Exodus', nameKorean: '출', abbreviation: 'Exod',
        abbreviationKorean: '출', testament: 'OT', orderIndex: 2, chapterCount: 40,
      );
      expect(a, equals(b)); // same id
      expect(a, isNot(equals(c))); // different id
    });
  });
}
