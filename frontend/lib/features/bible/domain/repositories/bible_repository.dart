// lib/features/bible/domain/repositories/bible_repository.dart
// [NEW] 성경 저장소 추상 인터페이스

import '../../../../core/error/failures.dart';
import '../../../../core/utils/result.dart';
import '../entities/book.dart';
import '../entities/chapter_content.dart';
import '../entities/verse.dart';

/// 성경 데이터에 접근하는 저장소 인터페이스.
/// 구현체는 data 레이어에 위치한다 (BibleRepositoryImpl).
abstract interface class BibleRepository {
  // ── Books ─────────────────────────────────────────────────────────

  /// 성경 66권 목록 조회 (순서대로).
  Future<Result<List<Book>, Failure>> getAllBooks();

  /// 단일 책 조회.
  Future<Result<Book, Failure>> getBook(int bookId);

  // ── Chapters ──────────────────────────────────────────────────────

  /// 특정 장(chapter)의 전체 절 조회.
  /// [parallelTranslationCode] 지정 시 대역 절도 함께 반환.
  Future<Result<ChapterContent, Failure>> getChapter({
    required int bookId,
    required int chapter,
    required String translationCode,
    String? parallelTranslationCode,
  });

  // ── Verses ────────────────────────────────────────────────────────

  /// 단일 절 조회.
  Future<Result<Verse, Failure>> getVerse({
    required int bookId,
    required int chapter,
    required int verseNumber,
    required String translationCode,
  });

  // ── Translation ───────────────────────────────────────────────────

  /// 특정 번역본의 데이터가 DB에 로드되어 있는지 확인.
  Future<Result<bool, Failure>> isTranslationLoaded(String translationCode);

  /// 로드된 번역본 코드 목록.
  Future<Result<List<String>, Failure>> getLoadedTranslations();

  // ── Search (FTS5) ─────────────────────────────────────────────────

  /// 전문 검색 (FTS5). 최대 [limit]건 반환.
  Future<Result<List<Verse>, Failure>> searchVerses({
    required String query,
    required String translationCode,
    int? bookId,
    String? testament,
    int limit = 50,
  });
}
