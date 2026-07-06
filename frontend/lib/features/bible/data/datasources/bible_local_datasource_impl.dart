// lib/features/bible/data/datasources/bible_local_datasource_impl.dart
// [NEW] 성경 로컬 데이터소스 구현체 (Drift AppDatabase 위임)

import 'package:drift/drift.dart';

import '../../../../core/database/app_database.dart';
import 'bible_local_datasource.dart';

final class BibleLocalDataSourceImpl implements BibleLocalDataSource {
  const BibleLocalDataSourceImpl(this._db);

  final AppDatabase _db;

  // ── Books ─────────────────────────────────────────────────────────

  @override
  Future<List<BibleBook>> getAllBooks() => _db.getAllBooks();

  @override
  Future<BibleBook?> getBook(int bookId) =>
      (_db.select(_db.bibleBooks)
            ..where((b) => b.id.equals(bookId)))
          .getSingleOrNull();

  // ── Verses ────────────────────────────────────────────────────────

  @override
  Future<List<VerseTranslation>> getChapterVerses({
    required String translationCode,
    required int bookId,
    required int chapter,
  }) =>
      _db.getChapterVerses(
        translationCode: translationCode,
        bookId: bookId,
        chapter: chapter,
      );

  @override
  Future<VerseTranslation?> getVerse({
    required String translationCode,
    required int bookId,
    required int chapter,
    required int verseNumber,
  }) =>
      (_db.select(_db.verseTranslations)
            ..where(
              (v) =>
                  v.translationCode.equals(translationCode) &
                  v.bookId.equals(bookId) &
                  v.chapter.equals(chapter) &
                  v.verse.equals(verseNumber),
            ))
          .getSingleOrNull();

  // ── Translation Status ────────────────────────────────────────────

  @override
  Future<bool> isTranslationLoaded(String translationCode) async {
    final count = await (_db.select(_db.verseTranslations)
          ..where((v) => v.translationCode.equals(translationCode))
          ..limit(1))
        .getSingleOrNull();
    return count != null;
  }

  @override
  Future<List<String>> getLoadedTranslationCodes() async {
    final result = await _db.customSelect(
      'SELECT DISTINCT translation_code FROM verse_translations',
    ).get();
    return result
        .map((r) => r.read<String>('translation_code'))
        .toList();
  }

  // ── FTS5 Search ───────────────────────────────────────────────────

  @override
  Future<List<VerseTranslation>> searchVerses({
    required String query,
    required String translationCode,
    int? bookId,
    int limit = 50,
  }) async {
    final sanitized = query.replaceAll('"', '""');
    final bookFilter =
        bookId != null ? 'AND vt.book_id = $bookId' : '';

    final rows = await _db.customSelect(
      '''
      SELECT vt.*
      FROM verse_translations vt
      JOIN verses_fts fts ON fts.rowid = vt.id
      WHERE verses_fts MATCH '"$sanitized"'
        AND vt.translation_code = ?
        $bookFilter
      ORDER BY rank
      LIMIT $limit
      ''',
      variables: [Variable.withString(translationCode)],
    ).get();

    return rows
        .map(
          (r) => VerseTranslation(
            id: r.read<int>('id'),
            translationCode: r.read<String>('translation_code'),
            bookId: r.read<int>('book_id'),
            chapter: r.read<int>('chapter'),
            verse: r.read<int>('verse'),
            textContent: r.read<String>('text'),
            strongRefs: r.readNullable<String>('strong_refs'),
          ),
        )
        .toList();
  }

  // ── Write ─────────────────────────────────────────────────────────

  @override
  Future<void> insertBooks(List<BibleBooksCompanion> books) =>
      _db.batch((b) => b.insertAllOnConflictUpdate(_db.bibleBooks, books));

  @override
  Future<void> insertVersesBatch(
    List<VerseTranslationsCompanion> verses, {
    void Function(double progress)? onProgress,
    int batchSize = 500,
  }) async {
    final total = verses.length;
    if (total == 0) return;

    for (var i = 0; i < total; i += batchSize) {
      final end = (i + batchSize).clamp(0, total);
      final chunk = verses.sublist(i, end);

      await _db.batch(
        (b) => b.insertAllOnConflictUpdate(_db.verseTranslations, chunk),
      );

      onProgress?.call(end / total);
    }
  }

  @override
  Future<void> upsertTranslationMeta(
    BibleTranslationsCompanion meta,
  ) =>
      _db.into(_db.bibleTranslations).insertOnConflictUpdate(meta);
}
