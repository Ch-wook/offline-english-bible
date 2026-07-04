// lib/features/dictionary/domain/usecases/lookup_word_usecase.dart
// [NEW] 단어 조회 유스케이스

import '../../../../core/error/failures.dart';
import '../../../../core/utils/result.dart';
import '../entities/dictionary_entry.dart';
import '../repositories/dictionary_repository.dart';

/// 단어를 사전에서 조회한다.
/// - 대소문자 무시
/// - 활용형 → 원형 자동 변환 (created → create)
/// - 찾지 못하면 WordNotFoundFailure
final class LookupWordUseCase {
  const LookupWordUseCase(this._repository);

  final DictionaryRepository _repository;

  Future<Result<DictionaryEntry, Failure>> call(String word) async {
    final trimmed = word.trim();
    if (trimmed.isEmpty) {
      return const FailureResult(
        ValidationFailure('단어를 입력해주세요'),
      );
    }
    return _repository.lookupWord(trimmed);
  }
}

/// 자동완성 제안 유스케이스.
final class GetSuggestionsUseCase {
  const GetSuggestionsUseCase(this._repository);

  final DictionaryRepository _repository;

  Future<Result<List<String>, Failure>> call(
    String prefix, {
    int limit = 10,
  }) {
    if (prefix.trim().isEmpty) return Future.value(const Success([]));
    return _repository.getSuggestions(prefix.trim(), limit: limit);
  }
}
