// lib/features/bible/data/datasources/user_local_datasource_impl.dart
// [NEW] 사용자 데이터 로컬 데이터소스 구현체 (Drift)

import 'package:drift/drift.dart';

import '../../../../core/database/app_database.dart';
import 'user_local_datasource.dart';

final class UserLocalDataSourceImpl implements UserLocalDataSource {
  const UserLocalDataSourceImpl(this._db);

  final AppDatabase _db;

  // ── Reading History ────────────────────────────────────────────────

  @override
  Future<void> saveReadingHistory({
    required int bookId,
    required int chapter,
    required String translationCode,
  }) async {
    await _db
        .into(_db.readingHistory)
        .insertOnConflictUpdate(
          ReadingHistoryCompanion(
            bookId: Value(bookId),
            chapter: Value(chapter),
            translationCode: Value(translationCode),
            accessedAt: Value(DateTime.now()),
          ),
        );
  }

  @override
  Future<ReadingHistoryData?> getLastReadChapter() => _db.getLastReadChapter();

  @override
  Future<List<ReadingHistoryData>> getRecentReadingHistory({int limit = 20}) =>
      (_db.select(_db.readingHistory)
            ..orderBy([(r) => OrderingTerm.desc(r.accessedAt)])
            ..limit(limit))
          .get();

  // ── Bookmarks ──────────────────────────────────────────────────────

  @override
  Future<List<Bookmark>> getAllBookmarks() => _db.getAllBookmarks();

  @override
  Future<bool> isVerseBookmarked({
    required int bookId,
    required int chapter,
    required int verse,
    required String translationCode,
  }) => _db.isVerseBookmarked(
    bookId: bookId,
    chapter: chapter,
    verse: verse,
    translationCode: translationCode,
  );

  @override
  Future<int> addBookmark({
    required int bookId,
    required int chapter,
    required int verse,
    required String translationCode,
    String? note,
  }) => _db
      .into(_db.bookmarks)
      .insert(
        BookmarksCompanion(
          bookId: Value(bookId),
          chapter: Value(chapter),
          verse: Value(verse),
          translationCode: Value(translationCode),
          note: Value(note ?? ''),
          createdAt: Value(DateTime.now()),
        ),
      );

  @override
  Future<void> removeBookmark(int id) =>
      (_db.delete(_db.bookmarks)..where((b) => b.id.equals(id))).go();

  // ── Highlights ─────────────────────────────────────────────────────

  @override
  Future<List<Highlight>> getChapterHighlights({
    required int bookId,
    required int chapter,
    required String translationCode,
  }) =>
      (_db.select(_db.highlights)..where(
        (h) =>
            h.bookId.equals(bookId) &
            h.chapter.equals(chapter) &
            h.translationCode.equals(translationCode),
      )).get();

  @override
  Future<int> addHighlight({
    required int bookId,
    required int chapter,
    required int verse,
    required String translationCode,
    required String color,
    int? startOffset,
    int? endOffset,
  }) => _db
      .into(_db.highlights)
      .insert(
        HighlightsCompanion(
          bookId: Value(bookId),
          chapter: Value(chapter),
          verse: Value(verse),
          translationCode: Value(translationCode),
          color: Value(color),
          wordStart: Value(startOffset ?? 0),
          wordEnd: Value(endOffset ?? startOffset ?? 0),
          createdAt: Value(DateTime.now()),
        ),
      );

  @override
  Future<void> removeHighlight(int id) =>
      (_db.delete(_db.highlights)..where((h) => h.id.equals(id))).go();
}
