// lib/features/dictionary/data/datasources/dictionary_local_datasource_impl.dart
// [NEW] 사전 로컬 데이터소스 구현체 (Drift AppDatabase)

import 'package:drift/drift.dart';

import '../../../../core/database/app_database.dart';
import 'dictionary_local_datasource.dart';

final class DictionaryLocalDataSourceImpl
    implements DictionaryLocalDataSource {
  const DictionaryLocalDataSourceImpl(this._db);

  final AppDatabase _db;

  // ── Lookup ────────────────────────────────────────────────────────

  @override
  Future<DictionaryEntries$Row?> lookupWord(String wordNormalized) =>
      (_db.select(_db.dictionaryEntries)
            ..where((e) => e.wordNormalized.equals(wordNormalized)))
          .getSingleOrNull();

  @override
  Future<List<DictionaryEntries$Row>> lookupInflection(String form) async {
    final rows = await (_db.select(_db.inflections)
          ..where((i) => i.form.equals(form)))
        .get();
    if (rows.isEmpty) return [];
    final entryIds = rows.map((r) => r.entryId).toSet().toList();
    return (_db.select(_db.dictionaryEntries)
          ..where((e) => e.id.isIn(entryIds)))
        .get();
  }

  @override
  Future<List<Senses$Row>> getSenses(int entryId) =>
      (_db.select(_db.senses)
            ..where((s) => s.entryId.equals(entryId))
            ..orderBy([
              (s) => OrderingTerm.asc(s.partOfSpeech),
              (s) => OrderingTerm.asc(s.senseOrder),
            ]))
          .get();

  @override
  Future<List<Examples$Row>> getExamples(int senseId) =>
      (_db.select(_db.examples)
            ..where((e) => e.senseId.equals(senseId)))
          .get();

  @override
  Future<List<WordNetRelations$Row>> getRelations(int entryId) =>
      (_db.select(_db.wordNetRelations)
            ..where((r) => r.entryId.equals(entryId)))
          .get();

  @override
  Future<List<Inflections$Row>> getInflections(int entryId) =>
      (_db.select(_db.inflections)
            ..where((i) => i.entryId.equals(entryId)))
          .get();

  // ── Suggestions (FTS prefix) ──────────────────────────────────────

  @override
  Future<List<String>> getSuggestions(
    String prefix, {
    int limit = 10,
  }) async {
    final normalized = prefix.toLowerCase().trim();
    if (normalized.isEmpty) return [];

    try {
      // FTS5 prefix search
      final rows = await _db.customSelect(
        '''
        SELECT e.word FROM dictionary_entries e
        JOIN dict_fts f ON f.rowid = e.id
        WHERE dict_fts MATCH ?
        ORDER BY e.frequency_rank ASC
        LIMIT $limit
        ''',
        variables: [Variable.withString('$normalized*')],
      ).get();
      return rows.map((r) => r.read<String>('word')).toList();
    } catch (_) {
      // FTS5 없으면 LIKE fallback
      final rows = await (_db.select(_db.dictionaryEntries)
            ..where(
              (e) => e.wordNormalized
                  .like('${normalized.toLowerCase()}%'),
            )
            ..orderBy([(e) => OrderingTerm.asc(e.frequencyRank)])
            ..limit(limit))
          .get();
      return rows.map((r) => r.word).toList();
    }
  }

  @override
  Future<bool> hasEntry(String wordNormalized) async {
    final row = await (_db.select(_db.dictionaryEntries)
          ..where((e) => e.wordNormalized.equals(wordNormalized))
          ..limit(1))
        .getSingleOrNull();
    return row != null;
  }

  @override
  Future<int> getEntryCount() async {
    final count = await _db.customSelect(
      'SELECT COUNT(*) as cnt FROM dictionary_entries',
    ).getSingle();
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
  Future<void> insertSenses(List<SensesCompanion> senses) =>
      _db.batch(
        (b) => b.insertAllOnConflictUpdate(_db.senses, senses),
      );

  @override
  Future<void> insertExamples(List<ExamplesCompanion> examples) =>
      _db.batch(
        (b) => b.insertAllOnConflictUpdate(_db.examples, examples),
      );

  @override
  Future<void> insertRelations(
    List<WordNetRelationsCompanion> relations,
  ) =>
      _db.batch(
        (b) => b.insertAllOnConflictUpdate(_db.wordNetRelations, relations),
      );

  @override
  Future<void> insertInflections(
    List<InflectionsCompanion> inflections,
  ) =>
      _db.batch(
        (b) => b.insertAllOnConflictUpdate(_db.inflections, inflections),
      );
}
