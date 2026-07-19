// test/features/bible/data/repositories/bible_repository_impl_test.dart
// [NEW] BibleRepositoryImpl 통합 테스트 (인메모리 DB)

import 'package:drift/drift.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:offline_english_bible/core/database/app_database.dart';
import 'package:offline_english_bible/core/database/seed_data/bible_books_seed.dart';
import 'package:offline_english_bible/features/bible/data/datasources/bible_local_datasource_impl.dart';
import 'package:offline_english_bible/features/bible/data/repositories/bible_repository_impl.dart';
import 'package:offline_english_bible/features/bible/domain/repositories/bible_repository.dart';

import '../../../../helpers/test_database_helper.dart';

void main() {
  late AppDatabase db;
  late BibleRepository repository;

  setUp(() async {
    db = createTestDatabase();
    final dataSource = BibleLocalDataSourceImpl(db);
    repository = BibleRepositoryImpl(dataSource);

    // 테스트 데이터 삽입 (Genesis만)
    await db.batch(
      (b) => b.insertAllOnConflictUpdate(
        db.bibleBooks,
        [bibleBooksSeed().first], // Genesis
      ),
    );

    await db.batch(
      (b) => b.insertAllOnConflictUpdate(db.verseTranslations, [
        const VerseTranslationsCompanion(
          translationCode: Value('KJV'),
          bookId: Value(1),
          chapter: Value(1),
          verse: Value(1),
          textContent: Value(
            'In the beginning God created the heaven and the earth.',
          ),
        ),
        const VerseTranslationsCompanion(
          translationCode: Value('KJV'),
          bookId: Value(1),
          chapter: Value(1),
          verse: Value(2),
          textContent: Value('And the earth was without form, and void;'),
        ),
        const VerseTranslationsCompanion(
          translationCode: Value('KJV'),
          bookId: Value(1),
          chapter: Value(1),
          verse: Value(3),
          textContent: Value(
            'And God said, Let there be light: and there was light.',
          ),
        ),
        const VerseTranslationsCompanion(
          translationCode: Value('KJV'),
          bookId: Value(45),
          chapter: Value(1),
          verse: Value(31),
          textContent: Value(
            'Without understanding, covenantbreakers, without natural affection.',
          ),
        ),
        const VerseTranslationsCompanion(
          translationCode: Value('KOREAN_RV'),
          bookId: Value(1),
          chapter: Value(1),
          verse: Value(1),
          textContent: Value('태초에 하나님이 천지를 창조하시니라'),
        ),
        const VerseTranslationsCompanion(
          translationCode: Value('KOREAN_RV'),
          bookId: Value(1),
          chapter: Value(1),
          verse: Value(2),
          textContent: Value('땅이 혼돈하고 공허하며'),
        ),
      ]),
    );
  });

  tearDown(() => closeTestDatabase(db));

  // ── getAllBooks ──────────────────────────────────────────────────────

  group('getAllBooks', () {
    test('returns seeded list beginning with Genesis', () async {
      final result = await repository.getAllBooks();
      expect(result.isSuccess, isTrue);
      final books = result.valueOrNull!;
      expect(books.length, 66);
      expect(books.first.name, 'Genesis');
      expect(books.first.id, 1);
    });

    test('returns 66 books after full seed', () async {
      await db.batch(
        (b) => b.insertAllOnConflictUpdate(db.bibleBooks, bibleBooksSeed()),
      );
      final result = await repository.getAllBooks();
      expect(result.valueOrNull?.length, 66);
    });
  });

  // ── getBook ─────────────────────────────────────────────────────────

  group('getBook', () {
    test('returns Genesis by id 1', () async {
      final result = await repository.getBook(1);
      expect(result.isSuccess, isTrue);
      expect(result.valueOrNull?.name, 'Genesis');
      expect(result.valueOrNull?.isOldTestament, isTrue);
      expect(result.valueOrNull?.chapterCount, 50);
    });

    test('returns failure for nonexistent book', () async {
      final result = await repository.getBook(999);
      expect(result.isFailure, isTrue);
    });
  });

  // ── getChapter ──────────────────────────────────────────────────────

  group('getChapter', () {
    test('returns ChapterContent with 3 KJV verses', () async {
      final result = await repository.getChapter(
        bookId: 1,
        chapter: 1,
        translationCode: 'KJV',
      );
      expect(result.isSuccess, isTrue);
      final content = result.valueOrNull!;
      expect(content.verseCount, 3);
      expect(content.book.name, 'Genesis');
      expect(content.chapterNumber, 1);
      expect(content.translationCode, 'KJV');
    });

    test('verse 1 text matches KJV', () async {
      final result = await repository.getChapter(
        bookId: 1,
        chapter: 1,
        translationCode: 'KJV',
      );
      final verse1 = result.valueOrNull!.verseAt(1);
      expect(
        verse1?.text,
        'In the beginning God created the heaven and the earth.',
      );
    });

    test('returns chapter with parallel Korean verses', () async {
      final result = await repository.getChapter(
        bookId: 1,
        chapter: 1,
        translationCode: 'KJV',
        parallelTranslationCode: 'KOREAN_RV',
      );
      final content = result.valueOrNull!;
      expect(content.hasParallelVerses, isTrue);
      expect(content.parallelVerses!.length, 2);
      expect(content.parallelVerseAt(1)?.text, '태초에 하나님이 천지를 창조하시니라');
    });

    test('returns failure for nonexistent chapter', () async {
      final result = await repository.getChapter(
        bookId: 1,
        chapter: 999,
        translationCode: 'KJV',
      );
      expect(result.isFailure, isTrue);
    });
  });

  // ── isTranslationLoaded ─────────────────────────────────────────────

  group('isTranslationLoaded', () {
    test('returns true for KJV (data inserted)', () async {
      final result = await repository.isTranslationLoaded('KJV');
      expect(result.valueOrNull, isTrue);
    });

    test('returns false for unloaded translation', () async {
      final result = await repository.isTranslationLoaded('NONEXISTENT');
      expect(result.valueOrNull, isFalse);
    });
  });

  // ── searchVerses ─────────────────────────────────────────────────────

  group('searchVerses', () {
    test('returns empty list for empty query', () async {
      final result = await repository.searchVerses(
        query: '',
        translationCode: 'KJV',
      );
      expect(result.valueOrNull, isEmpty);
    });

    test('returns empty for blank query', () async {
      final result = await repository.searchVerses(
        query: '   ',
        translationCode: 'KJV',
      );
      expect(result.valueOrNull, isEmpty);
    });

    test('finds a rare long KJV word through the FTS index', () async {
      final result = await repository.searchVerses(
        query: 'covenantbreakers',
        translationCode: 'KJV',
      );

      expect(result.isSuccess, isTrue);
      expect(result.valueOrNull, hasLength(1));
      expect(result.valueOrNull!.single.bookId, 45);
      expect(result.valueOrNull!.single.verseNumber, 31);
    });

    test('applies old and new testament filters to FTS results', () async {
      final oldTestament = await repository.searchVerses(
        query: 'covenantbreakers',
        translationCode: 'KJV',
        testament: 'OT',
      );
      final newTestament = await repository.searchVerses(
        query: 'covenantbreakers',
        translationCode: 'KJV',
        testament: 'NT',
      );

      expect(oldTestament.valueOrNull, isEmpty);
      expect(newTestament.valueOrNull, hasLength(1));
    });
  });
}
