// lib/features/vocabulary/data/datasources/vocabulary_local_datasource_impl.dart
// [NEW] 단어장 로컬 데이터소스 구현체 (Drift)

import 'package:drift/drift.dart';

import '../../../../core/database/app_database.dart';

abstract interface class VocabularyLocalDataSource {
  Future<List<VocabEntry>> getAllEntries();

  Future<VocabEntry?> getEntry(int id);

  Future<VocabEntry?> getEntryByWord(String word);

  Future<List<VocabEntry>> getDueForReview();

  Future<int> insert(VocabEntriesCompanion companion);

  Future<void> update(VocabEntriesCompanion companion);

  Future<void> delete(int id);

  Future<int> getTotal();

  Future<int> getDueCount();

  Future<int> getLearnedCount();
}

final class VocabularyLocalDataSourceImpl
    implements VocabularyLocalDataSource {
  const VocabularyLocalDataSourceImpl(this._db);

  final AppDatabase _db;

  @override
  Future<List<VocabEntry>> getAllEntries() =>
      (_db.select(_db.vocabEntries)
            ..orderBy([(e) => OrderingTerm.desc(e.addedAt)]))
          .get();

  @override
  Future<VocabEntry?> getEntry(int id) =>
      (_db.select(_db.vocabEntries)
            ..where((e) => e.id.equals(id)))
          .getSingleOrNull();

  @override
  Future<VocabEntry?> getEntryByWord(String word) =>
      (_db.select(_db.vocabEntries)
            ..where((e) => e.word.equals(word.toLowerCase())))
          .getSingleOrNull();

  @override
  Future<List<VocabEntry>> getDueForReview() => _db.customSelect(
        '''
        SELECT * FROM vocab_entries
        WHERE next_review_at IS NULL
           OR next_review_at <= ?
        ORDER BY next_review_at ASC
        LIMIT 20
        ''',
        variables: [Variable.withDateTime(DateTime.now())],
      ).map((row) {
        return VocabEntry(
          id: row.read<int>('id'),
          word: row.read<String>('word'),
          bookId: row.read<int>('book_id'),
          chapter: row.read<int>('chapter'),
          verse: row.read<int>('verse'),
          translationCode: row.read<String>('translation_code'),
          addedAt: row.read<DateTime>('added_at'),
          definition: row.readNullable<String>('definition'),
          note: row.readNullable<String>('note'),
          repetitions: row.read<int>('repetitions'),
          easeFactor: row.read<double>('ease_factor'),
          intervalDays: row.read<int>('interval_days'),
          nextReviewAt:
              row.readNullable<DateTime>('next_review_at'),
          lastReviewedAt:
              row.readNullable<DateTime>('last_reviewed_at'),
          isLearned: row.read<bool>('is_learned'),
        );
      }).get();

  @override
  Future<int> insert(VocabEntriesCompanion companion) =>
      _db.into(_db.vocabEntries).insert(companion);

  @override
  Future<void> update(VocabEntriesCompanion companion) =>
      _db.update(_db.vocabEntries).replace(companion);

  @override
  Future<void> delete(int id) =>
      (_db.delete(_db.vocabEntries)..where((e) => e.id.equals(id))).go();

  @override
  Future<int> getTotal() async {
    final r = await _db.customSelect(
      'SELECT COUNT(*) as cnt FROM vocab_entries',
    ).getSingle();
    return r.read<int>('cnt');
  }

  @override
  Future<int> getDueCount() async {
    final r = await _db.customSelect(
      '''
      SELECT COUNT(*) as cnt FROM vocab_entries
      WHERE next_review_at IS NULL OR next_review_at <= ?
      ''',
      variables: [Variable.withDateTime(DateTime.now())],
    ).getSingle();
    return r.read<int>('cnt');
  }

  @override
  Future<int> getLearnedCount() async {
    final r = await _db.customSelect(
      'SELECT COUNT(*) as cnt FROM vocab_entries WHERE is_learned = 1',
    ).getSingle();
    return r.read<int>('cnt');
  }
}
