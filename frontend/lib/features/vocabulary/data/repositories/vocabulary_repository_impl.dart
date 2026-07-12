// lib/features/vocabulary/data/repositories/vocabulary_repository_impl.dart
// [NEW] Vocabulary repository implementation
import 'package:drift/drift.dart';

import '../../../../core/database/app_database.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/utils/result.dart';
import '../../domain/entities/vocab_item.dart';
import '../../domain/repositories/vocabulary_repository.dart';
import '../datasources/vocabulary_local_datasource_impl.dart';

final class VocabularyRepositoryImpl implements VocabularyRepository {
  const VocabularyRepositoryImpl(this._dataSource);

  final VocabularyLocalDataSource _dataSource;

  VocabItem _rowToEntity(VocabularyItem row) {
    return VocabItem(
      id: row.id,
      word: row.word,
      bookId: row.bookId,
      chapter: row.chapter,
      verse: row.verse,
      translationCode: row.translationCode,
      addedAt: row.addedAt,
      definition: (row.definition as String?) ?? '',
      note: (row.note as String?) ?? '',
      repetitions: row.repetitions,
      easeFactor: row.easeFactor,
      intervalDays: row.intervalDays,
      nextReviewAt: row.nextReviewAt,
      lastReviewedAt: row.lastReviewedAt,
      isLearned: row.isLearned,
    );
  }

  @override
  Future<Result<List<VocabItem>, Failure>> getAllVocabItems() async {
    try {
      final rows = await _dataSource.getAllEntries();
      return Success(rows.map(_rowToEntity).toList());
    } catch (e) {
      return FailureResult(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Result<VocabItem, Failure>> getVocabItem(int id) async {
    try {
      final row = await _dataSource.getEntry(id);
      if (row == null) {
        return const FailureResult(RecordNotFoundFailure('단어를 찾을 수 없습니다'));
      }
      return Success(_rowToEntity(row));
    } catch (e) {
      return FailureResult(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Result<bool, Failure>> isWordSaved(String word) async {
    try {
      final row = await _dataSource.getEntryByWord(word.toLowerCase());
      return Success(row != null);
    } catch (e) {
      return FailureResult(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Result<int, Failure>> addVocabItem({
    required String word,
    required int bookId,
    required int chapter,
    required int verse,
    required String translationCode,
    String? definition,
    String partOfSpeech = 'unknown',
    String ipa = '',
    String bibleDefinition = '',
  }) async {
    try {
      final normalized = word.trim().toLowerCase();
      final existing = await _dataSource.getEntryByWord(normalized);
      if (existing != null) return Success(existing.id);

      final id = await _dataSource.insert(
        VocabularyItemsCompanion(
          word: Value(normalized),
          wordNormalized: Value(normalized),
          partOfSpeech: Value(
            partOfSpeech.trim().isEmpty ? 'unknown' : partOfSpeech,
          ),
          definition: Value(definition ?? ''),
          bibleDefinition: Value(bibleDefinition),
          ipa: Value(ipa),
          bookId: Value(bookId),
          chapter: Value(chapter),
          verse: Value(verse),
          translationCode: Value(translationCode),
          addedAt: Value(DateTime.now()),
          repetitions: const Value(0),
          easeFactor: const Value(2.5),
          intervalDays: const Value(1),
          isLearned: const Value(false),
        ),
      );
      return Success(id);
    } catch (e) {
      return FailureResult(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Result<void, Failure>> removeVocabItem(int id) async {
    try {
      await _dataSource.delete(id);
      return const Success(null);
    } catch (e) {
      return FailureResult(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Result<void, Failure>> updateVocabItem(VocabItem item) async {
    try {
      await _dataSource.update(
        VocabularyItemsCompanion(
          id: Value(item.id),
          word: Value(item.word),
          bookId: Value(item.bookId),
          chapter: Value(item.chapter),
          verse: Value(item.verse),
          translationCode: Value(item.translationCode),
          addedAt: Value(item.addedAt),
          definition: Value(item.definition),
          note: Value(item.note),
          repetitions: Value(item.repetitions),
          easeFactor: Value(item.easeFactor),
          intervalDays: Value(item.intervalDays),
          nextReviewAt: Value(item.nextReviewAt),
          lastReviewedAt: Value(item.lastReviewedAt),
          isLearned: Value(item.isLearned),
        ),
      );
      return const Success(null);
    } catch (e) {
      return FailureResult(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Result<List<VocabItem>, Failure>> getDueForReview() async {
    try {
      final rows = await _dataSource.getDueForReview();
      return Success(rows.map(_rowToEntity).toList());
    } catch (e) {
      return FailureResult(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Result<void, Failure>> submitReview({
    required int vocabId,
    required int quality,
  }) async {
    try {
      final row = await _dataSource.getEntry(vocabId);
      if (row == null) {
        return const FailureResult(RecordNotFoundFailure('단어를 찾을 수 없습니다'));
      }
      final item = _rowToEntity(row);
      final updated = item.updateWithQuality(quality);
      return updateVocabItem(updated);
    } catch (e) {
      return FailureResult(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Result<VocabStats, Failure>> getStats() async {
    try {
      final results = await Future.wait([
        _dataSource.getTotal(),
        _dataSource.getDueCount(),
        _dataSource.getLearnedCount(),
      ]);
      return Success(
        VocabStats(
          total: results[0],
          dueCount: results[1],
          learnedCount: results[2],
        ),
      );
    } catch (e) {
      return FailureResult(DatabaseFailure(e.toString()));
    }
  }
}
