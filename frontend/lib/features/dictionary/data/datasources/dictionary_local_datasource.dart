// lib/features/dictionary/data/datasources/dictionary_local_datasource.dart
// [NEW] 사전 로컬 데이터소스 인터페이스

import '../../../../core/database/app_database.dart';

abstract interface class DictionaryLocalDataSource {
  Future<DictionaryEntryRow?> lookupWord(String wordNormalized);

  Future<List<DictionaryEntryRow>> lookupInflection(String form);

  Future<List<SenseRow>> getSenses(int entryId);

  Future<List<ExampleRow>> getExamples(int senseId);

  Future<List<WordNetRelationRow>> getRelations(int entryId);

  Future<List<InflectionRow>> getInflections(int entryId);

  Future<List<String>> getSuggestions(String prefix, {int limit = 10});

  Future<bool> hasEntry(String wordNormalized);

  Future<int> getEntryCount();

  Future<void> insertEntries(
    List<DictionaryEntriesCompanion> entries, {
    void Function(double)? onProgress,
  });

  Future<void> insertSenses(List<SensesCompanion> senses);

  Future<void> insertExamples(List<ExamplesCompanion> examples);

  Future<void> insertRelations(List<WordNetRelationsCompanion> relations);

  Future<void> insertInflections(List<InflectionsCompanion> inflections);
}

// ── Row type aliases (Drift generated) ───────────────────────────────

typedef DictionaryEntryRow = DictionaryEntries$Row;
typedef SenseRow = Senses$Row;
typedef ExampleRow = Examples$Row;
typedef WordNetRelationRow = WordNetRelations$Row;
typedef InflectionRow = Inflections$Row;
