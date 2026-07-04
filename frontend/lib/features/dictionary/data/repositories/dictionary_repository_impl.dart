// lib/features/dictionary/data/repositories/dictionary_repository_impl.dart
// [NEW] DictionaryRepository 구현체

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/utils/result.dart';
import '../../domain/entities/dictionary_entry.dart';
import '../../domain/repositories/dictionary_repository.dart';
import '../datasources/dictionary_local_datasource.dart';
import '../mappers/dictionary_mapper.dart';

final class DictionaryRepositoryImpl implements DictionaryRepository {
  const DictionaryRepositoryImpl(this._dataSource);

  final DictionaryLocalDataSource _dataSource;

  @override
  Future<Result<DictionaryEntry, Failure>> lookupWord(String word) async {
    try {
      final normalized = word.toLowerCase().trim();

      // 1. 정확히 일치하는 단어 검색
      var row = await _dataSource.lookupWord(normalized);

      // 2. 없으면 활용형으로 검색 (created → create)
      if (row == null) {
        final inflectionMatches =
            await _dataSource.lookupInflection(normalized);
        if (inflectionMatches.isNotEmpty) {
          row = inflectionMatches.first;
        }
      }

      if (row == null) {
        return FailureResult(
          WordNotFoundFailure('단어를 찾을 수 없습니다: $word'),
        );
      }

      // senses + examples + relations + inflections 병렬 로드
      final results = await Future.wait([
        _dataSource.getSenses(row.id),
        _dataSource.getRelations(row.id),
        _dataSource.getInflections(row.id),
      ]);

      final senses = results[0] as List;
      final relations = results[1] as List;
      final inflections = results[2] as List;

      // 각 sense 의 examples 로드
      final exampleFutures = senses
          .map((s) => _dataSource.getExamples((s as dynamic).id as int));
      final exampleResults = await Future.wait(exampleFutures);

      final entry = DictionaryEntryMapper.toDomain(
        row: row,
        senses: List.from(senses),
        examples: exampleResults.map((e) => List.from(e)).toList(),
        relations: List.from(relations),
        inflections: List.from(inflections),
      );

      return Success(entry);
    } on DatabaseException catch (e) {
      return FailureResult(DatabaseFailure(e.message));
    } catch (e) {
      return FailureResult(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Result<bool, Failure>> hasEntry(String word) async {
    try {
      return Success(
        await _dataSource.hasEntry(word.toLowerCase().trim()),
      );
    } catch (e) {
      return FailureResult(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Result<List<String>, Failure>> getSuggestions(
    String prefix, {
    int limit = 10,
  }) async {
    try {
      return Success(
        await _dataSource.getSuggestions(prefix, limit: limit),
      );
    } catch (e) {
      return FailureResult(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Result<bool, Failure>> isDictionaryLoaded() async {
    try {
      final count = await _dataSource.getEntryCount();
      return Success(count > 0);
    } catch (e) {
      return FailureResult(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Result<int, Failure>> getEntryCount() async {
    try {
      return Success(await _dataSource.getEntryCount());
    } catch (e) {
      return FailureResult(DatabaseFailure(e.toString()));
    }
  }
}
