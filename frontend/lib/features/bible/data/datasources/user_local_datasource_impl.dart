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

  // ── Reading Tabs ─────────────────────────────────────────────────

  @override
  Future<List<ReadingTabData>> getReadingTabs() =>
      (_db.select(_db.readingTabs)..orderBy([
        (tab) => OrderingTerm.asc(tab.sortOrder),
        (tab) => OrderingTerm.asc(tab.id),
      ])).get();

  @override
  Future<int> createReadingTab({
    required int bookId,
    required int chapter,
    required String translationCode,
    required bool isParallelView,
    required String parallelTranslationCode,
    required int scrollVerse,
    required double scrollFraction,
    required double scrollOffset,
    required int sortOrder,
  }) => _db.transaction(() async {
    await _db
        .update(_db.readingTabs)
        .write(const ReadingTabsCompanion(isActive: Value(false)));
    return _db
        .into(_db.readingTabs)
        .insert(
          ReadingTabsCompanion(
            bookId: Value(bookId),
            chapter: Value(chapter),
            translationCode: Value(translationCode),
            isParallelView: Value(isParallelView),
            parallelTranslationCode: Value(parallelTranslationCode),
            scrollVerse: Value(scrollVerse),
            scrollFraction: Value(scrollFraction),
            scrollOffset: Value(scrollOffset),
            sortOrder: Value(sortOrder),
            isActive: const Value(true),
            updatedAt: Value(DateTime.now()),
          ),
        );
  });

  @override
  Future<void> updateReadingTab(ReadingTabData tab) async {
    await (_db.update(_db.readingTabs)
      ..where((row) => row.id.equals(tab.id))).write(
      ReadingTabsCompanion(
        bookId: Value(tab.bookId),
        chapter: Value(tab.chapter),
        translationCode: Value(tab.translationCode),
        isParallelView: Value(tab.isParallelView),
        parallelTranslationCode: Value(tab.parallelTranslationCode),
        scrollVerse: Value(tab.scrollVerse),
        scrollFraction: Value(tab.scrollFraction),
        scrollOffset: Value(tab.scrollOffset),
        sortOrder: Value(tab.sortOrder),
        isActive: Value(tab.isActive),
        updatedAt: Value(tab.updatedAt),
      ),
    );
  }

  @override
  Future<void> setActiveReadingTab(int id) => _db.transaction(() async {
    final target =
        await (_db.select(_db.readingTabs)
          ..where((tab) => tab.id.equals(id))).getSingleOrNull();
    if (target == null) throw StateError('읽기 탭을 찾을 수 없습니다: $id');

    await _db
        .update(_db.readingTabs)
        .write(const ReadingTabsCompanion(isActive: Value(false)));
    await (_db.update(_db.readingTabs)
      ..where((tab) => tab.id.equals(id))).write(
      ReadingTabsCompanion(
        isActive: const Value(true),
        updatedAt: Value(DateTime.now()),
      ),
    );
  });

  @override
  Future<void> deleteReadingTab(int id) =>
      (_db.delete(_db.readingTabs)..where((tab) => tab.id.equals(id))).go();

  @override
  Future<List<ChapterReadingPositionData>> getChapterReadingPositions(
    int readingTabId,
  ) =>
      (_db.select(_db.chapterReadingPositions)
            ..where((position) => position.readingTabId.equals(readingTabId))
            ..orderBy([(position) => OrderingTerm.desc(position.updatedAt)]))
          .get();

  @override
  Future<void> saveChapterReadingPosition({
    required int readingTabId,
    required int bookId,
    required int chapter,
    required int scrollVerse,
    required double scrollFraction,
    required double scrollOffset,
    required DateTime updatedAt,
  }) async {
    await _db
        .into(_db.chapterReadingPositions)
        .insertOnConflictUpdate(
          ChapterReadingPositionsCompanion(
            readingTabId: Value(readingTabId),
            bookId: Value(bookId),
            chapter: Value(chapter),
            scrollVerse: Value(scrollVerse),
            scrollFraction: Value(scrollFraction),
            scrollOffset: Value(scrollOffset),
            updatedAt: Value(updatedAt),
          ),
        );
  }

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
  }) async => _db.transaction(() async {
    final existing =
        await (_db.select(_db.bookmarks)..where(
          (bookmark) =>
              bookmark.bookId.equals(bookId) &
              bookmark.chapter.equals(chapter) &
              bookmark.verse.equals(verse) &
              bookmark.translationCode.equals(translationCode),
        )).getSingleOrNull();

    final companion = BookmarksCompanion(
      bookId: Value(bookId),
      chapter: Value(chapter),
      verse: Value(verse),
      translationCode: Value(translationCode),
      note: Value(note ?? existing?.note ?? ''),
      createdAt: Value(existing?.createdAt ?? DateTime.now()),
    );

    if (existing == null) {
      return _db.into(_db.bookmarks).insert(companion);
    }

    await (_db.update(_db.bookmarks)
      ..where((bookmark) => bookmark.id.equals(existing.id))).write(companion);
    return existing.id;
  });

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
  }) async => _db.transaction(() async {
    await (_db.delete(_db.highlights)..where(
      (h) =>
          h.bookId.equals(bookId) &
          h.chapter.equals(chapter) &
          h.verse.equals(verse) &
          h.translationCode.equals(translationCode),
    )).go();

    return _db
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
  });

  @override
  Future<void> removeHighlight(int id) =>
      (_db.delete(_db.highlights)..where((h) => h.id.equals(id))).go();
}
