// lib/features/vocabulary/domain/repositories/vocabulary_repository.dart
// [NEW] 단어장 저장소 인터페이스

import '../../../../core/error/failures.dart';
import '../../../../core/utils/result.dart';
import '../entities/vocab_item.dart';

abstract interface class VocabularyRepository {
  // ── CRUD ──────────────────────────────────────────────────────────

  Future<Result<List<VocabItem>, Failure>> getAllVocabItems();

  Future<Result<VocabItem, Failure>> getVocabItem(int id);

  Future<Result<bool, Failure>> isWordSaved(String word);

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
  });

  Future<Result<void, Failure>> removeVocabItem(int id);

  Future<Result<void, Failure>> updateVocabItem(VocabItem item);

  // ── SRS ───────────────────────────────────────────────────────────

  /// 오늘 복습해야 할 단어 목록.
  Future<Result<List<VocabItem>, Failure>> getDueForReview();

  /// SM-2 복습 결과 저장.
  Future<Result<void, Failure>> submitReview({
    required int vocabId,
    required int quality,
  });

  // ── Stats ─────────────────────────────────────────────────────────

  Future<Result<VocabStats, Failure>> getStats();
}

/// 단어장 통계.
final class VocabStats {
  const VocabStats({
    required this.total,
    required this.dueCount,
    required this.learnedCount,
  });

  final int total;
  final int dueCount;
  final int learnedCount;

  int get notLearnedCount => total - learnedCount;
}
