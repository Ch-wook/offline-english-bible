// lib/features/vocabulary/data/datasources/vocabulary_local_datasource_impl.dart
// [NEW] Vocabulary local data source implementation (Drift)

import 'package:drift/drift.dart';

import '../../../../core/database/app_database.dart';

abstract interface class VocabularyLocalDataSource {
  Future<List<VocabularyItem>> getAllEntries();

  Future<VocabularyItem?> getEntry(int id);

  Future<VocabularyItem?> getEntryByWord(String word);

  Future<List<VocabularyItem>> getDueForReview();

  Future<int> insert(VocabularyItemsCompanion companion);

  Future<void> update(VocabularyItemsCompanion companion);

  Future<void> delete(int id);

  Future<int> getTotal();

  Future<int> getDueCount();

  Future<int> getLearnedCount();
}

final class VocabularyLocalDataSourceImpl implements VocabularyLocalDataSource {
  const VocabularyLocalDataSourceImpl(this._db);

  final AppDatabase _db;

  @override
  Future<List<VocabularyItem>> getAllEntries() =>
      (_db.select(_db.vocabularyItems)
        ..orderBy([(e) => OrderingTerm.desc(e.addedAt)])).get();

  @override
  Future<VocabularyItem?> getEntry(int id) =>
      (_db.select(_db.vocabularyItems)
        ..where((e) => e.id.equals(id))).getSingleOrNull();

  @override
  Future<VocabularyItem?> getEntryByWord(String word) =>
      (_db.select(_db.vocabularyItems)
        ..where((e) => e.word.equals(word.toLowerCase()))).getSingleOrNull();

  @override
  Future<List<VocabularyItem>> getDueForReview() {
    final now = DateTime.now();
    return (_db.select(_db.vocabularyItems)
          ..where(
            (t) =>
                t.nextReviewAt.isNull() |
                t.nextReviewAt.isSmallerOrEqualValue(now),
          )
          ..orderBy([(t) => OrderingTerm.asc(t.nextReviewAt)])
          ..limit(20))
        .get();
  }

  @override
  Future<int> insert(VocabularyItemsCompanion companion) =>
      _db.into(_db.vocabularyItems).insert(companion);

  @override
  Future<void> update(VocabularyItemsCompanion companion) async {
    final id = companion.id.value;
    await (_db.update(_db.vocabularyItems)
      ..where((entry) => entry.id.equals(id))).write(companion);
  }

  @override
  Future<void> delete(int id) =>
      (_db.delete(_db.vocabularyItems)..where((e) => e.id.equals(id))).go();

  @override
  Future<int> getTotal() async {
    final count = _db.vocabularyItems.id.count();
    final query = _db.selectOnly(_db.vocabularyItems)..addColumns([count]);
    final result = await query.getSingle();
    return result.read(count) ?? 0;
  }

  @override
  Future<int> getDueCount() async {
    final now = DateTime.now();
    final count = _db.vocabularyItems.id.count();
    final query =
        _db.selectOnly(_db.vocabularyItems)
          ..addColumns([count])
          ..where(
            _db.vocabularyItems.nextReviewAt.isNull() |
                _db.vocabularyItems.nextReviewAt.isSmallerOrEqualValue(now),
          );
    final result = await query.getSingle();
    return result.read(count) ?? 0;
  }

  @override
  Future<int> getLearnedCount() async {
    final count = _db.vocabularyItems.id.count();
    final query =
        _db.selectOnly(_db.vocabularyItems)
          ..addColumns([count])
          ..where(_db.vocabularyItems.isLearned.equals(true));
    final result = await query.getSingle();
    return result.read(count) ?? 0;
  }
}
