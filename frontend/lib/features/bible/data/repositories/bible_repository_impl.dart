// lib/features/bible/data/repositories/bible_repository_impl.dart
// [NEW] BibleRepository 구현체

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/utils/result.dart';
import '../../domain/entities/book.dart';
import '../../domain/entities/chapter_content.dart';
import '../../domain/entities/verse.dart';
import '../../domain/repositories/bible_repository.dart';
import '../datasources/bible_local_datasource.dart';
import '../mappers/bible_mapper.dart';

final class BibleRepositoryImpl implements BibleRepository {
  const BibleRepositoryImpl(this._dataSource);

  final BibleLocalDataSource _dataSource;

  // ── Books ─────────────────────────────────────────────────────────

  @override
  Future<Result<List<Book>, Failure>> getAllBooks() async {
    try {
      final rows = await _dataSource.getAllBooks();
      return Success(rows.toDomain());
    } on DatabaseException catch (e) {
      return FailureResult(DatabaseFailure(e.message));
    } catch (e) {
      return FailureResult(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Result<Book, Failure>> getBook(int bookId) async {
    try {
      final row = await _dataSource.getBook(bookId);
      if (row == null) {
        return FailureResult(
          RecordNotFoundFailure('Book not found: id=$bookId'),
        );
      }
      return Success(row.toDomain());
    } on DatabaseException catch (e) {
      return FailureResult(DatabaseFailure(e.message));
    } catch (e) {
      return FailureResult(DatabaseFailure(e.toString()));
    }
  }

  // ── Chapters ──────────────────────────────────────────────────────

  @override
  Future<Result<ChapterContent, Failure>> getChapter({
    required int bookId,
    required int chapter,
    required String translationCode,
    String? parallelTranslationCode,
  }) async {
    try {
      // 책 정보
      final bookRow = await _dataSource.getBook(bookId);
      if (bookRow == null) {
        return FailureResult(
          ChapterNotFoundFailure(book: bookId, chapter: chapter),
        );
      }
      final book = bookRow.toDomain();

      // 주 번역본 절
      final verseRows = await _dataSource.getChapterVerses(
        translationCode: translationCode,
        bookId: bookId,
        chapter: chapter,
      );

      if (verseRows.isEmpty) {
        return FailureResult(
          ChapterNotFoundFailure(book: bookId, chapter: chapter),
        );
      }

      final verses = verseRows.toDomain();

      // 대역 번역본 절 (옵션)
      List<Verse>? parallelVerses;
      if (parallelTranslationCode != null) {
        final parallelRows = await _dataSource.getChapterVerses(
          translationCode: parallelTranslationCode,
          bookId: bookId,
          chapter: chapter,
        );
        if (parallelRows.isNotEmpty) {
          parallelVerses = parallelRows.toDomain();
        }
      }

      return Success(
        ChapterContent(
          book: book,
          chapterNumber: chapter,
          verses: verses,
          translationCode: translationCode,
          parallelVerses: parallelVerses,
          parallelTranslationCode: parallelTranslationCode,
        ),
      );
    } on DatabaseException catch (e) {
      return FailureResult(DatabaseFailure(e.message));
    } catch (e) {
      return FailureResult(DatabaseFailure(e.toString()));
    }
  }

  // ── Verses ────────────────────────────────────────────────────────

  @override
  Future<Result<Verse, Failure>> getVerse({
    required int bookId,
    required int chapter,
    required int verseNumber,
    required String translationCode,
  }) async {
    try {
      final row = await _dataSource.getVerse(
        translationCode: translationCode,
        bookId: bookId,
        chapter: chapter,
        verseNumber: verseNumber,
      );
      if (row == null) {
        return FailureResult(
          RecordNotFoundFailure(
            'Verse not found: $translationCode $bookId:$chapter:$verseNumber',
          ),
        );
      }
      return Success(row.toDomain());
    } on DatabaseException catch (e) {
      return FailureResult(DatabaseFailure(e.message));
    } catch (e) {
      return FailureResult(DatabaseFailure(e.toString()));
    }
  }

  // ── Translation Status ────────────────────────────────────────────

  @override
  Future<Result<bool, Failure>> isTranslationLoaded(
    String translationCode,
  ) async {
    try {
      return Success(await _dataSource.isTranslationLoaded(translationCode));
    } catch (e) {
      return FailureResult(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Result<List<String>, Failure>> getLoadedTranslations() async {
    try {
      return Success(await _dataSource.getLoadedTranslationCodes());
    } catch (e) {
      return FailureResult(DatabaseFailure(e.toString()));
    }
  }

  // ── Search ────────────────────────────────────────────────────────

  @override
  Future<Result<List<Verse>, Failure>> searchVerses({
    required String query,
    required String translationCode,
    int? bookId,
    String? testament,
    int limit = 50,
  }) async {
    if (query.trim().isEmpty) return const Success([]);
    try {
      final rows = await _dataSource.searchVerses(
        query: query.trim(),
        translationCode: translationCode,
        bookId: bookId,
        testament: testament,
        limit: limit,
      );
      return Success(rows.toDomain());
    } on DatabaseException catch (e) {
      return FailureResult(DatabaseFailure(e.message));
    } catch (e) {
      return FailureResult(DatabaseFailure(e.toString()));
    }
  }
}
