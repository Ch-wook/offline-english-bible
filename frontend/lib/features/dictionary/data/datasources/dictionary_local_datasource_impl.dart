// lib/features/dictionary/data/datasources/dictionary_local_datasource_impl.dart
// [NEW] 사전 로컬 데이터소스 구현체 (Drift AppDatabase)

import 'package:drift/drift.dart';

import '../../../../core/database/app_database.dart';
import 'dictionary_local_datasource.dart';

final class DictionaryLocalDataSourceImpl implements DictionaryLocalDataSource {
  const DictionaryLocalDataSourceImpl(this._db);

  final AppDatabase _db;

  // ── Lookup ────────────────────────────────────────────────────────

  @override
  Future<DictionaryEntryData?> lookupWord(String wordNormalized) =>
      (_db.select(_db.dictionaryEntries)..where(
        (t) => t.wordNormalized.equals(wordNormalized),
      )).getSingleOrNull();

  @override
  Future<List<DictionaryEntryData>> lookupInflection(String form) async {
    final query = _db.select(_db.wordForms).join([
      innerJoin(
        _db.dictionaryEntries,
        _db.dictionaryEntries.id.equalsExp(_db.wordForms.entryId),
      ),
    ])..where(_db.wordForms.form.equals(form));

    final results = await query.get();
    return results.map((row) => row.readTable(_db.dictionaryEntries)).toList();
  }

  @override
  Future<List<WordSenseData>> getSenses(int entryId) =>
      (_db.select(_db.wordSenses)
            ..where((t) => t.entryId.equals(entryId))
            ..orderBy([(t) => OrderingTerm.asc(t.senseOrder)]))
          .get();

  @override
  Future<List<WordExampleData>> getExamples(int senseId) =>
      (_db.select(_db.wordExamples)
        ..where((t) => t.senseId.equals(senseId))).get();

  @override
  Future<List<WordnetRelationData>> getRelations(int entryId) =>
      (_db.select(_db.wordnetRelations)
        ..where((t) => t.fromSynsetId.equals(entryId))).get();

  @override
  Future<List<WordFormData>> getInflections(int entryId) =>
      (_db.select(_db.wordForms)
        ..where((t) => t.entryId.equals(entryId))).get();

  // ── Suggestions (FTS prefix) ──────────────────────────────────────

  @override
  Future<List<String>> getSuggestions(String prefix, {int limit = 10}) async {
    final normalized = prefix.toLowerCase().trim();
    if (normalized.isEmpty) return [];

    try {
      // FTS5 prefix search
      final rows =
          await _db
              .customSelect(
                '''
        SELECT e.word FROM dictionary_entries e
        JOIN dict_fts f ON f.rowid = e.id
        WHERE dict_fts MATCH ?
        ORDER BY e.frequency_rank ASC
        LIMIT $limit
        ''',
                variables: [Variable.withString('$normalized*')],
              )
              .get();
      return rows.map((r) => r.read<String>('word')).toList();
    } catch (_) {
      // FTS5 없으면 LIKE fallback
      final rows =
          await (_db.select(_db.dictionaryEntries)
                ..where(
                  (e) => e.wordNormalized.like('${normalized.toLowerCase()}%'),
                )
                ..orderBy([(e) => OrderingTerm.asc(e.frequencyRank)])
                ..limit(limit))
              .get();
      return rows.map((r) => r.word).toList();
    }
  }

  @override
  Future<bool> hasEntry(String wordNormalized) async {
    final row =
        await (_db.select(_db.dictionaryEntries)
              ..where((e) => e.wordNormalized.equals(wordNormalized))
              ..limit(1))
            .getSingleOrNull();
    return row != null;
  }

  @override
  Future<int> getEntryCount() async {
    final count =
        await _db
            .customSelect('SELECT COUNT(*) as cnt FROM dictionary_entries')
            .getSingle();
    return count.read<int>('cnt');
  }

  // ── Write ─────────────────────────────────────────────────────────

  @override
  Future<void> insertEntries(
    List<DictionaryEntriesCompanion> entries, {
    void Function(double)? onProgress,
  }) async {
    const batchSize = 200;
    for (var i = 0; i < entries.length; i += batchSize) {
      final end = (i + batchSize).clamp(0, entries.length);
      await _db.batch(
        (b) => b.insertAllOnConflictUpdate(
          _db.dictionaryEntries,
          entries.sublist(i, end),
        ),
      );
      onProgress?.call(end / entries.length);
    }
  }

  @override
  Future<void> insertSenses(List<WordSensesCompanion> senses) =>
      _db.batch((b) => b.insertAllOnConflictUpdate(_db.wordSenses, senses));

  @override
  Future<void> insertExamples(List<WordExamplesCompanion> examples) =>
      _db.batch((b) => b.insertAllOnConflictUpdate(_db.wordExamples, examples));

  @override
  Future<void> insertRelations(List<WordnetRelationsCompanion> relations) =>
      _db.batch(
        (b) => b.insertAllOnConflictUpdate(_db.wordnetRelations, relations),
      );

  @override
  Future<void> insertInflections(List<WordFormsCompanion> inflections) =>
      _db.batch((b) => b.insertAllOnConflictUpdate(_db.wordForms, inflections));
}
