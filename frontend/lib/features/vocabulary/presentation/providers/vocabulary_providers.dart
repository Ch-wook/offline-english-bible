// lib/features/vocabulary/presentation/providers/vocabulary_providers.dart
// [NEW] 단어장 Riverpod Providers

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/di/providers.dart';
import '../../data/datasources/vocabulary_local_datasource_impl.dart';
import '../../data/repositories/vocabulary_repository_impl.dart';
import '../../domain/entities/vocab_item.dart';
import '../../domain/repositories/vocabulary_repository.dart';

// ── Repository ────────────────────────────────────────────────────────

final vocabularyRepositoryProvider =
    Provider<VocabularyRepository>((ref) {
  final db = ref.watch(appDatabaseProvider);
  final ds = VocabularyLocalDataSourceImpl(db);
  return VocabularyRepositoryImpl(ds);
});

// ── Vocab List ────────────────────────────────────────────────────────

final allVocabItemsProvider = FutureProvider<List<VocabItem>>((ref) async {
  final repo = ref.watch(vocabularyRepositoryProvider);
  final result = await repo.getAllVocabItems();
  return result.valueOrNull ?? [];
});

// ── SRS Due ───────────────────────────────────────────────────────────

final dueForReviewProvider = FutureProvider<List<VocabItem>>((ref) async {
  final repo = ref.watch(vocabularyRepositoryProvider);
  final result = await repo.getDueForReview();
  return result.valueOrNull ?? [];
});

// ── Stats ─────────────────────────────────────────────────────────────

final vocabStatsProvider =
    FutureProvider<VocabStats>((ref) async {
  final repo = ref.watch(vocabularyRepositoryProvider);
  final result = await repo.getStats();
  return result.valueOrNull ??
      const VocabStats(
        total: 0,
        dueCount: 0,
        learnedCount: 0,
        streak: 0,
      );
});

// ── Word Saved Check ──────────────────────────────────────────────────

final isWordSavedProvider =
    FutureProvider.family<bool, String>((ref, word) async {
  final repo = ref.watch(vocabularyRepositoryProvider);
  final result = await repo.isWordSaved(word);
  return result.valueOrNull ?? false;
});

// ── Actions ───────────────────────────────────────────────────────────

final addVocabWordProvider =
    Provider<Future<void> Function(String, int, int, int, String)>((ref) {
  return (word, bookId, chapter, verse, translationCode) async {
    final repo = ref.read(vocabularyRepositoryProvider);
    await repo.addVocabItem(
      word: word,
      bookId: bookId,
      chapter: chapter,
      verse: verse,
      translationCode: translationCode,
    );
    ref.invalidate(allVocabItemsProvider);
    ref.invalidate(vocabStatsProvider);
    ref.invalidate(dueForReviewProvider);
    ref.invalidate(isWordSavedProvider(word));
  };
});

final submitReviewProvider =
    Provider<Future<void> Function(int, int)>((ref) {
  return (vocabId, quality) async {
    final repo = ref.read(vocabularyRepositoryProvider);
    await repo.submitReview(vocabId: vocabId, quality: quality);
    ref.invalidate(dueForReviewProvider);
    ref.invalidate(allVocabItemsProvider);
    ref.invalidate(vocabStatsProvider);
  };
});
