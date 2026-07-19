// lib/features/bible/data/datasources/user_local_datasource.dart
// [NEW] 사용자 데이터 로컬 데이터소스 인터페이스
// (북마크, 형광펜, 읽기 기록, 메모)

import '../../../../core/database/app_database.dart';

abstract interface class UserLocalDataSource {
  // ── Reading History ────────────────────────────────────────────────
  Future<void> saveReadingHistory({
    required int bookId,
    required int chapter,
    required String translationCode,
  });

  Future<ReadingHistoryData?> getLastReadChapter();

  Future<List<ReadingHistoryData>> getRecentReadingHistory({int limit = 20});

  // ── Reading Tabs ─────────────────────────────────────────────────
  Future<List<ReadingTabData>> getReadingTabs();

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
  });

  Future<void> updateReadingTab(ReadingTabData tab);

  Future<void> setActiveReadingTab(int id);

  Future<void> deleteReadingTab(int id);

  // ── Bookmarks ──────────────────────────────────────────────────────
  Future<List<Bookmark>> getAllBookmarks();

  Future<bool> isVerseBookmarked({
    required int bookId,
    required int chapter,
    required int verse,
    required String translationCode,
  });

  Future<int> addBookmark({
    required int bookId,
    required int chapter,
    required int verse,
    required String translationCode,
    String? note,
  });

  Future<void> removeBookmark(int id);

  // ── Highlights ─────────────────────────────────────────────────────
  Future<List<Highlight>> getChapterHighlights({
    required int bookId,
    required int chapter,
    required String translationCode,
  });

  Future<int> addHighlight({
    required int bookId,
    required int chapter,
    required int verse,
    required String translationCode,
    required String color,
    int? startOffset,
    int? endOffset,
  });

  Future<void> removeHighlight(int id);
}
