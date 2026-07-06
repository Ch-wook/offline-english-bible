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

  Future<void> insertSenses(List<WordSensesCompanion> senses);
  Future<void> insertExamples(List<WordExamplesCompanion> examples);
  Future<void> insertRelations(List<WordnetRelationsCompanion> relations);
  Future<void> insertInflections(List<WordFormsCompanion> inflections);
}

// ── Row type aliases (Drift generated) ───────────────────────────────

typedef DictionaryEntryRow = DictionaryEntryData;
typedef SenseRow = WordSenseData;
typedef ExampleRow = WordExampleData;
typedef WordNetRelationRow = WordnetRelationData;
typedef InflectionRow = WordFormData;
