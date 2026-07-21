import 'package:flutter_test/flutter_test.dart';
import 'package:offline_english_bible/core/database/app_database.dart';
import 'package:offline_english_bible/features/bible/data/datasources/user_local_datasource_impl.dart';

import '../../../../helpers/test_database_helper.dart';

void main() {
  late AppDatabase db;
  late UserLocalDataSourceImpl dataSource;

  setUp(() {
    db = createTestDatabase();
    dataSource = UserLocalDataSourceImpl(db);
  });

  tearDown(() => closeTestDatabase(db));

  test('adding the same bookmark twice remains idempotent', () async {
    await dataSource.addBookmark(
      bookId: 1,
      chapter: 1,
      verse: 1,
      translationCode: 'KJV',
    );
    await dataSource.addBookmark(
      bookId: 1,
      chapter: 1,
      verse: 1,
      translationCode: 'KJV',
      note: 'created',
    );

    final bookmarks = await dataSource.getAllBookmarks();
    expect(bookmarks, hasLength(1));
    expect(bookmarks.single.note, 'created');
  });

  test('changing a verse highlight replaces the previous color', () async {
    await dataSource.addHighlight(
      bookId: 1,
      chapter: 1,
      verse: 1,
      translationCode: 'KJV',
      color: 'yellow',
    );
    await dataSource.addHighlight(
      bookId: 1,
      chapter: 1,
      verse: 1,
      translationCode: 'KJV',
      color: 'blue',
    );

    final highlights = await dataSource.getChapterHighlights(
      bookId: 1,
      chapter: 1,
      translationCode: 'KJV',
    );
    expect(highlights, hasLength(1));
    expect(highlights.single.color, 'blue');
  });

  test(
    'reading tabs preserve independent locations and one active tab',
    () async {
      final firstId = await dataSource.createReadingTab(
        bookId: 1,
        chapter: 3,
        translationCode: 'KJV',
        isParallelView: true,
        parallelTranslationCode: 'KOREAN_RV',
        scrollVerse: 9,
        scrollFraction: 0.25,
        scrollOffset: 420,
        sortOrder: 0,
      );
      final secondId = await dataSource.createReadingTab(
        bookId: 43,
        chapter: 3,
        translationCode: 'KJV',
        isParallelView: false,
        parallelTranslationCode: 'KOREAN_RV',
        scrollVerse: 4,
        scrollFraction: 0.5,
        scrollOffset: 180,
        sortOrder: 1,
      );

      var tabs = await dataSource.getReadingTabs();
      expect(tabs.map((tab) => tab.id), [firstId, secondId]);
      expect(tabs.where((tab) => tab.isActive).single.id, secondId);

      await dataSource.setActiveReadingTab(firstId);
      tabs = await dataSource.getReadingTabs();
      expect(tabs.where((tab) => tab.isActive).single.id, firstId);
      expect(tabs.first.chapter, 3);
      expect(tabs.first.scrollVerse, 9);
      expect(tabs.first.scrollFraction, 0.25);
      expect(tabs.first.scrollOffset, 420);
      expect(tabs.last.bookId, 43);
    },
  );

  test(
    'chapter positions are upserted independently per reading tab',
    () async {
      final tabId = await dataSource.createReadingTab(
        bookId: 1,
        chapter: 1,
        translationCode: 'KJV',
        isParallelView: false,
        parallelTranslationCode: 'KOREAN_RV',
        scrollVerse: 1,
        scrollFraction: 0,
        scrollOffset: 0,
        sortOrder: 0,
      );
      final now = DateTime(2026, 7, 21);

      await dataSource.saveChapterReadingPosition(
        readingTabId: tabId,
        bookId: 1,
        chapter: 1,
        scrollVerse: 12,
        scrollFraction: 0.3,
        scrollOffset: 520,
        updatedAt: now,
      );
      await dataSource.saveChapterReadingPosition(
        readingTabId: tabId,
        bookId: 1,
        chapter: 2,
        scrollVerse: 7,
        scrollFraction: 0.6,
        scrollOffset: 280,
        updatedAt: now.add(const Duration(minutes: 1)),
      );
      await dataSource.saveChapterReadingPosition(
        readingTabId: tabId,
        bookId: 1,
        chapter: 1,
        scrollVerse: 14,
        scrollFraction: 0.4,
        scrollOffset: 640,
        updatedAt: now.add(const Duration(minutes: 2)),
      );

      var positions = await dataSource.getChapterReadingPositions(tabId);
      expect(positions, hasLength(2));
      final chapterOne = positions.singleWhere((row) => row.chapter == 1);
      expect(chapterOne.scrollVerse, 14);
      expect(chapterOne.scrollOffset, 640);

      await dataSource.deleteReadingTab(tabId);
      positions = await dataSource.getChapterReadingPositions(tabId);
      expect(positions, isEmpty);
    },
  );
}
