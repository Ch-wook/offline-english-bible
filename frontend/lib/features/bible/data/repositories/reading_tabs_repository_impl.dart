import '../../../../core/database/app_database.dart';
import '../../domain/entities/chapter_reading_position.dart';
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
    required int scrollVerse,
    required double scrollFraction,
    required double scrollOffset,
    required int sortOrder,
  }) async {
    final id = await _dataSource.createReadingTab(
      bookId: bookId,
      chapter: chapter,
      translationCode: translationCode,
      isParallelView: isParallelView,
      parallelTranslationCode: parallelTranslationCode,
      scrollVerse: scrollVerse,
      scrollFraction: scrollFraction,
      scrollOffset: scrollOffset,
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

  @override
  Future<List<ChapterReadingPosition>> getChapterPositions(
    int readingTabId,
  ) async =>
      (await _dataSource.getChapterReadingPositions(
        readingTabId,
      )).map(_positionToDomain).toList();

  @override
  Future<void> saveChapterPosition(ChapterReadingPosition position) =>
      _dataSource.saveChapterReadingPosition(
        readingTabId: position.readingTabId,
        bookId: position.bookId,
        chapter: position.chapter,
        scrollVerse: position.scrollVerse,
        scrollFraction: position.scrollFraction,
        scrollOffset: position.scrollOffset,
        updatedAt: position.updatedAt,
      );

  static BibleReadingTab _toDomain(ReadingTabData row) => BibleReadingTab(
    id: row.id,
    bookId: row.bookId,
    chapter: row.chapter,
    translationCode: row.translationCode,
    isParallelView: row.isParallelView,
    parallelTranslationCode: row.parallelTranslationCode,
    scrollVerse: row.scrollVerse,
    scrollFraction: row.scrollFraction,
    scrollOffset: row.scrollOffset,
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
    scrollVerse: tab.scrollVerse,
    scrollFraction: tab.scrollFraction,
    scrollOffset: tab.scrollOffset,
    sortOrder: tab.sortOrder,
    isActive: tab.isActive,
    updatedAt: tab.updatedAt,
  );

  static ChapterReadingPosition _positionToDomain(
    ChapterReadingPositionData row,
  ) => ChapterReadingPosition(
    readingTabId: row.readingTabId,
    bookId: row.bookId,
    chapter: row.chapter,
    scrollVerse: row.scrollVerse,
    scrollFraction: row.scrollFraction,
    scrollOffset: row.scrollOffset,
    updatedAt: row.updatedAt,
  );
}
