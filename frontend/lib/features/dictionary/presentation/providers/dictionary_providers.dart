// lib/features/dictionary/presentation/providers/dictionary_providers.dart
// [NEW] 사전 Riverpod Providers

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/di/providers.dart';
import '../../data/datasources/dictionary_local_datasource_impl.dart';
import '../../data/repositories/dictionary_repository_impl.dart';
import '../../domain/entities/dictionary_entry.dart';
import '../../domain/repositories/dictionary_repository.dart';
import '../../domain/usecases/lookup_word_usecase.dart';

// ── Repository ────────────────────────────────────────────────────────

final dictionaryRepositoryProvider =
    Provider<DictionaryRepository>((ref) {
  final db = ref.watch(appDatabaseProvider);
  final ds = DictionaryLocalDataSourceImpl(db);
  return DictionaryRepositoryImpl(ds);
});

// ── Use Cases ─────────────────────────────────────────────────────────

final lookupWordUseCaseProvider =
    Provider<LookupWordUseCase>((ref) {
  return LookupWordUseCase(ref.watch(dictionaryRepositoryProvider));
});

final getSuggestionsUseCaseProvider =
    Provider<GetSuggestionsUseCase>((ref) {
  return GetSuggestionsUseCase(
    ref.watch(dictionaryRepositoryProvider),
  );
});

// ── Data Providers ────────────────────────────────────────────────────

/// 단어 조회 FutureProvider.family.
final wordLookupProvider =
    FutureProvider.family<DictionaryEntry?, String>((ref, word) async {
  if (word.isEmpty) return null;
  final useCase = ref.watch(lookupWordUseCaseProvider);
  final result = await useCase(word);
  return result.valueOrNull; // 찾지 못해도 null (not error)
});

/// 자동완성 제안.
final wordSuggestionsProvider =
    FutureProvider.family<List<String>, String>((ref, prefix) async {
  if (prefix.length < 2) return [];
  final useCase = ref.watch(getSuggestionsUseCaseProvider);
  final result = await useCase(prefix);
  return result.valueOrNull ?? [];
});

/// 사전 로드 여부.
final isDictionaryLoadedProvider = FutureProvider<bool>((ref) async {
  final repo = ref.watch(dictionaryRepositoryProvider);
  final result = await repo.isDictionaryLoaded();
  return result.valueOrNull ?? false;
});

/// 사전 총 단어 수.
final dictionaryEntryCountProvider = FutureProvider<int>((ref) async {
  final repo = ref.watch(dictionaryRepositoryProvider);
  final result = await repo.getEntryCount();
  return result.valueOrNull ?? 0;
});
