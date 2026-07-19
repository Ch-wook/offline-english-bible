import '../entities/reading_tab.dart';

abstract interface class ReadingTabsRepository {
  Future<List<BibleReadingTab>> getTabs();

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
  });

  Future<void> updateTab(BibleReadingTab tab);

  Future<void> setActiveTab(int id);

  Future<void> deleteTab(int id);
}
