// lib/features/dictionary/domain/repositories/dictionary_repository.dart
// [NEW] 사전 저장소 인터페이스

import '../../../../core/error/failures.dart';
import '../../../../core/utils/result.dart';
import '../entities/dictionary_entry.dart';

abstract interface class DictionaryRepository {
  /// 단어 조회 (대소문자 무시, 활용형 포함).
  /// 'created' → 'create' 엔트리 반환.
  Future<Result<DictionaryEntry, Failure>> lookupWord(String word);

  /// 단어 존재 여부만 확인 (빠른 체크).
  Future<Result<bool, Failure>> hasEntry(String word);

  /// 자동완성 제안 목록 (prefix match).
  Future<Result<List<String>, Failure>> getSuggestions(
    String prefix, {
    int limit = 10,
  });

  /// 사전 데이터 로드 여부.
  Future<Result<bool, Failure>> isDictionaryLoaded();

  /// 사전 총 단어 수.
  Future<Result<int, Failure>> getEntryCount();
}
