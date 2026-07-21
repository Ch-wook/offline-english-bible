// lib/core/database/app_database.dart
// [NEW] Drift AppDatabase — 앱 전체 SQLite 데이터베이스 진입점

import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import 'seed_data/bible_books_seed.dart';
import 'tables/bible_tables.dart';
import 'tables/dictionary_tables.dart';
import 'tables/user_tables.dart';

part 'app_database.g.dart';

/// 앱 전체에서 사용하는 단일 SQLite 데이터베이스.
///
/// 성경 데이터, 사전 데이터, 사용자 데이터를 모두 담는다.
/// 성경/사전 데이터는 앱 설치 후 최초 1회 임포트된다.
///
/// WAL 모드 + NORMAL 동기화로 성능 최적화.
/// 단어 조회 목표: 200ms 이하.
@DriftDatabase(
  tables: [
    // Bible
    BibleBooks,
    BibleTranslations,
    VerseTranslations,
    CrossReferences,
    // Dictionary — Wiktionary
    DictionaryEntries,
    WordSenses,
    WordExamples,
    WordForms,
    // Dictionary — WordNet
    WordnetSynsets,
    WordnetLemmas,
    WordnetRelations,
    // Dictionary — Strong's
    StrongEntries,
    VerseStrongMappings,
    // Grammar
    GrammarRules,
    PosLookup,
    // User Data
    Bookmarks,
    Memos,
    Highlights,
    VocabularyItems,
    ReviewSessions,
    ReviewAnswers,
    ReadingHistory,
    ReadingTabs,
    ReadingPlans,
    ChapterReadingPositions,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase(super.e);

  @override
  int get schemaVersion => 5;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    beforeOpen: (details) async {
      // 성능 최적화 PRAGMA
      await customStatement('PRAGMA journal_mode=WAL');
      await customStatement('PRAGMA foreign_keys=ON');
      await customStatement('PRAGMA synchronous=NORMAL');
      await customStatement('PRAGMA cache_size=-32000'); // 32MB 캐시
      await customStatement('PRAGMA temp_store=MEMORY');
      await customStatement('PRAGMA mmap_size=268435456'); // 256MB mmap
      await _createIndexes();
    },
    onCreate: (m) async {
      await m.createAll();
      await _createIndexes();
      await _insertDefaultData();
    },
    onUpgrade: (m, from, to) async {
      if (from < 2) {
        await m.addColumn(dictionaryEntries, dictionaryEntries.koreanMeaning);
        await m.addColumn(dictionaryEntries, dictionaryEntries.synonymsJson);
        await m.addColumn(dictionaryEntries, dictionaryEntries.antonymsJson);
        await m.addColumn(
          dictionaryEntries,
          dictionaryEntries.relatedWordsJson,
        );
        await m.addColumn(wordSenses, wordSenses.definitionKo);
      }
      if (from < 3) {
        await m.createTable(readingTabs);
      } else if (from < 4) {
        await m.addColumn(readingTabs, readingTabs.scrollVerse);
        await m.addColumn(readingTabs, readingTabs.scrollFraction);
        await m.addColumn(readingTabs, readingTabs.scrollOffset);
      }
      if (from < 5) {
        await m.createTable(chapterReadingPositions);
      }
    },
  );

  // ── 인덱스 생성 (조회 성능 최적화) ─────────────────────────────────

  Future<void> _createIndexes() async {
    // 핵심: 번역본 + 책 + 장으로 절 조회 (Bible Reader 화면)
    await customStatement(
      'CREATE INDEX IF NOT EXISTS idx_verse_chapter_lookup '
      'ON verse_translations (translation_code, book_id, chapter)',
    );

    // 단어 조회 (Dictionary Bottom Sheet) — 목표: 200ms 이하
    await customStatement(
      'CREATE INDEX IF NOT EXISTS idx_dict_word_normalized '
      'ON dictionary_entries (word_normalized)',
    );
    await customStatement(
      'CREATE INDEX IF NOT EXISTS idx_dict_word_form '
      'ON word_forms (form)',
    );

    // Strong 번호 조회
    await customStatement(
      'CREATE INDEX IF NOT EXISTS idx_strong_number '
      'ON strong_entries (strong_number)',
    );

    // POS 조회 (문법 분석 엔진)
    await customStatement(
      'CREATE INDEX IF NOT EXISTS idx_pos_word '
      'ON pos_lookup (word_normalized)',
    );

    // 단어-절 매핑 조회
    await customStatement(
      'CREATE INDEX IF NOT EXISTS idx_strong_mapping_verse '
      'ON verse_strong_mappings (book_id, chapter, verse)',
    );

    // WordNet 조회
    await customStatement(
      'CREATE INDEX IF NOT EXISTS idx_wordnet_lemma_entry '
      'ON wordnet_lemmas (entry_id)',
    );

    // 북마크 조회
    await customStatement(
      'CREATE INDEX IF NOT EXISTS idx_bookmark_verse '
      'ON bookmarks (book_id, chapter, verse)',
    );

    // 읽기 기록 (최근 읽은 곳)
    await customStatement(
      'CREATE INDEX IF NOT EXISTS idx_reading_history_accessed '
      'ON reading_history (accessed_at DESC)',
    );

    await customStatement(
      'CREATE INDEX IF NOT EXISTS idx_reading_tabs_order '
      'ON reading_tabs (sort_order, id)',
    );

    await customStatement(
      'CREATE INDEX IF NOT EXISTS idx_chapter_positions_tab '
      'ON chapter_reading_positions (reading_tab_id, updated_at DESC)',
    );

    // 단어장 복습 스케줄
    await customStatement(
      'CREATE INDEX IF NOT EXISTS idx_vocabulary_review '
      'ON vocabulary_items (next_review_at, mastery_level)',
    );

    // FTS5 가상 테이블 (전문 검색)
    await customStatement('''
      CREATE VIRTUAL TABLE IF NOT EXISTS verses_fts USING fts5(
        text,
        content=verse_translations,
        content_rowid=id,
        tokenize="unicode61"
      )
    ''');

    await customStatement('''
      CREATE TRIGGER IF NOT EXISTS verse_ai AFTER INSERT ON verse_translations BEGIN
        INSERT INTO verses_fts(rowid, text) VALUES (new.id, new.text);
      END
    ''');

    await customStatement('''
      CREATE TRIGGER IF NOT EXISTS verse_ad AFTER DELETE ON verse_translations BEGIN
        INSERT INTO verses_fts(verses_fts, rowid, text)
        VALUES('delete', old.id, old.text);
      END
    ''');
  }

  // ── 기본 데이터 삽입 ──────────────────────────────────────────────

  Future<void> _insertDefaultData() async {
    // 번역본 메타데이터 등록
    await batch((b) {
      b.insertAll(bibleTranslations, [
        const BibleTranslationsCompanion(
          code: Value('KJV'),
          name: Value('King James Version'),
          language: Value('en'),
          copyright: Value('Public Domain'),
        ),
        const BibleTranslationsCompanion(
          code: Value('KOREAN_RV'),
          name: Value('개역한글'),
          language: Value('ko'),
          copyright: Value('Public Domain'),
        ),
      ]);
      b.insertAll(bibleBooks, bibleBooksSeed());
    });
  }

  // ── 단어 조회 (핵심 기능: < 200ms) ──────────────────────────────────

  /// 단어 정규화 후 사전 항목 조회.
  /// [word]: 원형 또는 활용형 모두 허용.
  Future<DictionaryEntryData?> lookupWord(String word) async {
    final normalized = word.toLowerCase().trim();

    // 1차: 정확 일치
    final exact =
        await (select(
          dictionaryEntries,
        )..where((e) => e.wordNormalized.equals(normalized))).getSingleOrNull();
    if (exact != null) return exact;

    // 2차: 활용형 역추적
    final form =
        await (select(wordForms)
          ..where((f) => f.form.equals(normalized))).getSingleOrNull();
    if (form == null) return null;

    return (select(dictionaryEntries)
      ..where((e) => e.id.equals(form.entryId))).getSingleOrNull();
  }

  /// 단어의 모든 뜻 조회 (품사별).
  Future<List<WordSenseData>> getWordSenses(int entryId) =>
      (select(wordSenses)
            ..where((s) => s.entryId.equals(entryId))
            ..orderBy([(s) => OrderingTerm.asc(s.senseOrder)]))
          .get();

  /// 단어 동의어/반의어 조회 (WordNet).
  Future<List<DictionaryEntryData>> getSynonyms(int entryId) async {
    final lemmas =
        await (select(wordnetLemmas)
          ..where((l) => l.entryId.equals(entryId))).get();
    if (lemmas.isEmpty) return [];

    final synsetIds = lemmas.map((l) => l.synsetId).toList();
    final synonymLemmas =
        await (select(wordnetLemmas)..where(
          (l) => l.synsetId.isIn(synsetIds) & l.entryId.equals(entryId).not(),
        )).get();

    if (synonymLemmas.isEmpty) return [];
    final entryIds = synonymLemmas.map((l) => l.entryId).toSet().toList();
    return (select(dictionaryEntries)..where((e) => e.id.isIn(entryIds))).get();
  }

  // ── 성경 조회 ─────────────────────────────────────────────────────

  /// 특정 장의 모든 절 조회.
  Future<List<VerseTranslation>> getChapterVerses({
    required String translationCode,
    required int bookId,
    required int chapter,
  }) =>
      (select(verseTranslations)
            ..where(
              (v) =>
                  v.translationCode.equals(translationCode) &
                  v.bookId.equals(bookId) &
                  v.chapter.equals(chapter),
            )
            ..orderBy([(v) => OrderingTerm.asc(v.verse)]))
          .get();

  /// 모든 성경 책 목록 (순서대로).
  Future<List<BibleBook>> getAllBooks() =>
      (select(bibleBooks)
        ..orderBy([(b) => OrderingTerm.asc(b.orderIndex)])).get();

  // ── 북마크 ────────────────────────────────────────────────────────

  Future<List<Bookmark>> getAllBookmarks() =>
      (select(bookmarks)
        ..orderBy([(b) => OrderingTerm.desc(b.createdAt)])).get();

  Future<bool> isVerseBookmarked({
    required int bookId,
    required int chapter,
    required int verse,
    required String translationCode,
  }) async {
    final result =
        await (select(bookmarks)..where(
          (b) =>
              b.bookId.equals(bookId) &
              b.chapter.equals(chapter) &
              b.verse.equals(verse) &
              b.translationCode.equals(translationCode),
        )).getSingleOrNull();
    return result != null;
  }

  // ── 단어장 ────────────────────────────────────────────────────────

  /// 복습 대기 단어 조회 (다음 복습 시간이 지난 것).
  Future<List<VocabularyItem>> getDueVocabulary() {
    final now = DateTime.now();
    return (select(vocabularyItems)
          ..where(
            (v) =>
                v.nextReviewAt.isSmallerOrEqualValue(now) &
                v.masteryLevel.isSmallerThanValue(5),
          )
          ..orderBy([
            (v) => OrderingTerm.asc(v.nextReviewAt),
            (v) => OrderingTerm.asc(v.masteryLevel),
          ]))
        .get();
  }

  // ── 읽기 기록 ─────────────────────────────────────────────────────

  Future<ReadingHistoryData?> getLastReadChapter() =>
      (select(readingHistory)
            ..orderBy([(r) => OrderingTerm.desc(r.accessedAt)])
            ..limit(1))
          .getSingleOrNull();
}

// ── Database Connection Factory ───────────────────────────────────────

/// Android/iOS용 네이티브 SQLite 연결 생성.
QueryExecutor createDatabaseConnection(String dbName) {
  return LazyDatabase(() async {
    final dir = await getApplicationDocumentsDirectory();
    final file = File(p.join(dir.path, dbName));
    return NativeDatabase.createInBackground(file);
  });
}

/// 테스트용 인메모리 데이터베이스 연결.
QueryExecutor createInMemoryConnection() => NativeDatabase.memory();
