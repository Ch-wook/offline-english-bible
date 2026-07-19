// lib/features/bible/data/datasources/bible_local_datasource.dart
// [NEW] 성경 로컬 데이터소스 추상 인터페이스

import '../../../../core/database/app_database.dart';

/// SQLite AppDatabase 에 직접 접근하는 데이터소스 인터페이스.
/// Data 레이어에서만 사용한다.
abstract interface class BibleLocalDataSource {
  // ── Read ──────────────────────────────────────────────────────────

  Future<List<BibleBook>> getAllBooks();

  Future<BibleBook?> getBook(int bookId);

  Future<List<VerseTranslation>> getChapterVerses({
    required String translationCode,
    required int bookId,
    required int chapter,
  });

  Future<VerseTranslation?> getVerse({
    required String translationCode,
    required int bookId,
    required int chapter,
    required int verseNumber,
  });

  Future<bool> isTranslationLoaded(String translationCode);

  Future<List<String>> getLoadedTranslationCodes();

  Future<List<VerseTranslation>> searchVerses({
    required String query,
    required String translationCode,
    int? bookId,
    String? testament,
    int limit = 50,
  });

  // ── Write ─────────────────────────────────────────────────────────

  Future<void> insertBooks(List<BibleBooksCompanion> books);

  /// 절 배치 삽입. [onProgress]: 0.0~1.0 진행률 콜백.
  Future<void> insertVersesBatch(
    List<VerseTranslationsCompanion> verses, {
    void Function(double progress)? onProgress,
    int batchSize = 500,
  });

  Future<void> upsertTranslationMeta(BibleTranslationsCompanion meta);
}
