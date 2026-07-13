import '../../../../core/database/app_database.dart';
import '../../domain/entities/reading_tab.dart';
import '../../domain/repositories/reading_tabs_repository.dart';
import '../datasources/user_local_datasource.dart';

final class ReadingTabsRepositoryImpl implements ReadingTabsRepository {
  const ReadingTabsRepositoryImpl(this._dataSource);

  final UserLocalDataSource _dataSource;

  @override
  Future<List<BibleReadingTab>> getTabs() async =>
      (await _dataSource.getReadingTabs()).map(_toDomain).toList();

  @override
  Future<BibleReadingTab> createTab({
    required int bookId,
    required int chapter,
    required String translationCode,
    required bool isParallelView,
    required String parallelTranslationCode,
    required int sortOrder,
  }) async {
    final id = await _dataSource.createReadingTab(
      bookId: bookId,
      chapter: chapter,
      translationCode: translationCode,
      isParallelView: isParallelView,
      parallelTranslationCode: parallelTranslationCode,
      sortOrder: sortOrder,
    );
    final created = (await _dataSource.getReadingTabs()).firstWhere(
      (tab) => tab.id == id,
    );
    return _toDomain(created);
  }

  @override
  Future<void> updateTab(BibleReadingTab tab) =>
      _dataSource.updateReadingTab(_toData(tab));

  @override
  Future<void> setActiveTab(int id) => _dataSource.setActiveReadingTab(id);

  @override
  Future<void> deleteTab(int id) => _dataSource.deleteReadingTab(id);

  static BibleReadingTab _toDomain(ReadingTabData row) => BibleReadingTab(
    id: row.id,
    bookId: row.bookId,
    chapter: row.chapter,
    translationCode: row.translationCode,
    isParallelView: row.isParallelView,
    parallelTranslationCode: row.parallelTranslationCode,
    sortOrder: row.sortOrder,
    isActive: row.isActive,
    updatedAt: row.updatedAt,
  );

  static ReadingTabData _toData(BibleReadingTab tab) => ReadingTabData(
    id: tab.id,
    bookId: tab.bookId,
    chapter: tab.chapter,
    translationCode: tab.translationCode,
    isParallelView: tab.isParallelView,
    parallelTranslationCode: tab.parallelTranslationCode,
    sortOrder: tab.sortOrder,
    isActive: tab.isActive,
    updatedAt: tab.updatedAt,
  );
}
