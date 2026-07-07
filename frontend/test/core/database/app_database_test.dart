// test/core/database/app_database_test.dart
// [NEW] AppDatabase 통합 테스트 (인메모리 SQLite)

import 'package:drift/drift.dart' hide isNotNull, isNull;
import 'package:flutter_test/flutter_test.dart';
import 'package:offline_english_bible/core/database/app_database.dart';

import '../../helpers/test_database_helper.dart';

void main() {
  late AppDatabase db;

  setUp(() {
    db = createTestDatabase();
  });

  tearDown(() async {
    await closeTestDatabase(db);
  });

  // ── Schema ──────────────────────────────────────────────────────────

  group('Database initialization', () {
    test('creates all tables without error', () async {
      // Migration onCreate 실행 확인
      // 어떤 테이블이든 쿼리가 성공하면 스키마가 정상 생성된 것
      final books = await db.getAllBooks();
      expect(books, isEmpty);
    });

    test('inserts default translation metadata on create', () async {
      final translations = await db.select(db.bibleTranslations).get();
      expect(translations.length, 2);
      final codes = translations.map((t) => t.code).toList();
      expect(codes, containsAll(['KJV', 'KOREAN_RV']));
    });

    test('KJV translation is public domain', () async {
      final kjv = await (db.select(db.bibleTranslations)
            ..where((t) => t.code.equals('KJV')))
          .getSingleOrNull();
      expect(kjv, isNotNull);
      expect(kjv!.copyright, 'Public Domain');
      expect(kjv.language, 'en');
    });

    test('개역한글 translation is public domain', () async {
      final rv = await (db.select(db.bibleTranslations)
            ..where((t) => t.code.equals('KOREAN_RV')))
          .getSingleOrNull();
      expect(rv, isNotNull);
      expect(rv!.copyright, 'Public Domain');
      expect(rv.language, 'ko');
    });
  });

  // ── Bible Books ──────────────────────────────────────────────────────

  group('BibleBooks', () {
    test('insert and retrieve a book', () async {
      await db.into(db.bibleBooks).insert(
            const BibleBooksCompanion(
              id: Value(1),
              name: Value('Genesis'),
              nameKorean: Value('창세기'),
              abbreviation: Value('Gen'),
              abbreviationKorean: Value('창'),
              testament: Value('OT'),
              orderIndex: Value(1),
              chapterCount: Value(50),
            ),
          );

      final books = await db.getAllBooks();
      expect(books.length, 1);
      expect(books.first.name, 'Genesis');
      expect(books.first.testament, 'OT');
    });
  });

  // ── Verse Translations ────────────────────────────────────────────────

  group('VerseTranslations', () {
    setUp(() async {
      // 창세기 삽입
      await db.into(db.bibleBooks).insert(
            const BibleBooksCompanion(
              id: Value(1),
              name: Value('Genesis'),
              nameKorean: Value('창세기'),
              abbreviation: Value('Gen'),
              abbreviationKorean: Value('창'),
              testament: Value('OT'),
              orderIndex: Value(1),
              chapterCount: Value(50),
            ),
          );
    });

    test('insert and query chapter verses', () async {
      await db.batch((b) => b.insertAll(db.verseTranslations, [
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
          textContent: Value(
            'And the earth was without form, and void;',
          ),
        ),
      ]));

      final verses = await db.getChapterVerses(
        translationCode: 'KJV',
        bookId: 1,
        chapter: 1,
      );
      expect(verses.length, 2);
      expect(verses.first.verse, 1);
      expect(verses[1].verse, 2);
    });

    test('returns empty list for nonexistent chapter', () async {
      final verses = await db.getChapterVerses(
        translationCode: 'KJV',
        bookId: 1,
        chapter: 999,
      );
      expect(verses, isEmpty);
    });
  });

  // ── Bookmarks ─────────────────────────────────────────────────────────

  group('Bookmarks', () {
    test('add and retrieve bookmark', () async {
      await db.into(db.bookmarks).insert(
            BookmarksCompanion(
              translationCode: const Value('KJV'),
              bookId: const Value(1),
              chapter: const Value(1),
              verse: const Value(1),
              createdAt: Value(DateTime.now()),
            ),
          );

      final bookmarks = await db.getAllBookmarks();
      expect(bookmarks.length, 1);
      expect(bookmarks.first.bookId, 1);
    });

    test('isVerseBookmarked returns true for existing bookmark', () async {
      final now = DateTime.now();
      await db.into(db.bookmarks).insert(
            BookmarksCompanion(
              translationCode: const Value('KJV'),
              bookId: const Value(1),
              chapter: const Value(1),
              verse: const Value(1),
              createdAt: Value(now),
            ),
          );

      final result = await db.isVerseBookmarked(
        bookId: 1,
        chapter: 1,
        verse: 1,
        translationCode: 'KJV',
      );
      expect(result, isTrue);
    });

    test('isVerseBookmarked returns false when not bookmarked', () async {
      final result = await db.isVerseBookmarked(
        bookId: 1,
        chapter: 1,
        verse: 1,
        translationCode: 'KJV',
      );
      expect(result, isFalse);
    });
  });

  // ── Vocabulary ─────────────────────────────────────────────────────────

  group('VocabularyItems', () {
    test('add vocabulary item and retrieve due items', () async {
      final past = DateTime.now().subtract(const Duration(days: 1));
      await db.into(db.vocabularyItems).insert(
            VocabularyItemsCompanion(
              word: const Value('grace'),
              wordNormalized: const Value('grace'),
              partOfSpeech: const Value('noun'),
              definition:
                  const Value('courteous goodwill; favor and love of God'),
              addedAt: Value(past),
              nextReviewAt: Value(past), // 복습 시간 경과
            ),
          );

      final due = await db.getDueVocabulary();
      expect(due.length, 1);
      expect(due.first.word, 'grace');
    });

    test('fully mastered word is not in due list', () async {
      final past = DateTime.now().subtract(const Duration(days: 1));
      await db.into(db.vocabularyItems).insert(
            VocabularyItemsCompanion(
              word: const Value('faith'),
              wordNormalized: const Value('faith'),
              partOfSpeech: const Value('noun'),
              definition: const Value('complete trust or confidence'),
              masteryLevel: const Value(5), // 완전 암기
              addedAt: Value(past),
              nextReviewAt: Value(past),
            ),
          );

      final due = await db.getDueVocabulary();
      expect(due, isEmpty);
    });
  });

  // ── Dictionary ──────────────────────────────────────────────────────────

  group('Dictionary lookupWord', () {
    test('finds word by normalized form', () async {
      await db.into(db.dictionaryEntries).insert(
            const DictionaryEntriesCompanion(
              word: Value('Grace'),
              wordNormalized: Value('grace'),
              ipaUs: Value('/ɡreɪs/'),
            ),
          );

      final entry = await db.lookupWord('Grace');
      expect(entry, isNotNull);
      expect(entry!.wordNormalized, 'grace');
    });

    test('returns null for unknown word', () async {
      final entry = await db.lookupWord('xyzunknown');
      expect(entry, isNull);
    });

    test('finds word via inflected form', () async {
      final entryId = await db.into(db.dictionaryEntries).insert(
            const DictionaryEntriesCompanion(
              word: Value('create'),
              wordNormalized: Value('create'),
            ),
          );

      await db.into(db.wordForms).insert(
            WordFormsCompanion(
              entryId: Value(entryId),
              formType: const Value('past_tense'),
              form: const Value('created'),
            ),
          );

      final entry = await db.lookupWord('created');
      expect(entry, isNotNull);
      expect(entry!.word, 'create');
    });
  });

  // ── Reading History ─────────────────────────────────────────────────────

  group('ReadingHistory', () {
    test('getLastReadChapter returns most recent entry', () async {
      final old = DateTime.now().subtract(const Duration(days: 2));
      final recent = DateTime.now().subtract(const Duration(hours: 1));

      await db.batch((b) => b.insertAll(db.readingHistory, [
        ReadingHistoryCompanion(
          bookId: const Value(1),
          chapter: const Value(1),
          translationCode: const Value('KJV'),
          accessedAt: Value(old),
        ),
        ReadingHistoryCompanion(
          bookId: const Value(1),
          chapter: const Value(3),
          translationCode: const Value('KJV'),
          accessedAt: Value(recent),
        ),
      ]));

      final last = await db.getLastReadChapter();
      expect(last, isNotNull);
      expect(last!.chapter, 3); // 최근 것이 반환되어야 함
    });

    test('returns null when no reading history', () async {
      final last = await db.getLastReadChapter();
      expect(last, isNull);
    });
  });
}
