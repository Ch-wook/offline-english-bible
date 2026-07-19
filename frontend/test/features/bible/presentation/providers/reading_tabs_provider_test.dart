import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:offline_english_bible/core/database/app_database.dart';
import 'package:offline_english_bible/features/bible/presentation/providers/bible_reader_provider.dart';
import 'package:offline_english_bible/features/bible/presentation/providers/reading_tabs_provider.dart';

import '../../../../helpers/provider_container_helper.dart';
import '../../../../helpers/test_database_helper.dart';

void main() {
  late AppDatabase db;

  setUp(() {
    db = createTestDatabase();
  });

  tearDown(() => closeTestDatabase(db));

  test('tabs save and restore independent reading locations', () async {
    var container = createTestContainer(db: db, closeDatabaseOnDispose: false);
    final autoSaveSubscription = container.listen<void>(
      readingTabsAutoSaveProvider,
      (_, __) {},
      fireImmediately: true,
    );
    var state = await _waitForTabs(container);
    final firstId = state.activeTabId;

    container
        .read(bibleReaderProvider.notifier)
        .navigateTo(bookId: 43, chapter: 3);
    state = await _waitForTabs(
      container,
      (value) => value.activeTab.bookId == 43 && value.activeTab.chapter == 3,
    );
    await _waitForPersistedChapter(db, firstId, 3);
    container
        .read(bibleReaderProvider.notifier)
        .updateReadingPosition(verse: 16, fraction: 0.3, offset: 720);
    await _waitForTabs(container, (value) => value.activeTab.scrollVerse == 16);
    await _waitForPersistedPosition(db, firstId, verse: 16, offset: 720);

    expect(await container.read(readingTabsProvider.notifier).addTab(), isTrue);
    state = container.read(readingTabsProvider).requireValue;
    final secondId = state.activeTabId;
    container
        .read(bibleReaderProvider.notifier)
        .navigateTo(bookId: 19, chapter: 23);
    await _waitForTabs(
      container,
      (value) => value.activeTab.bookId == 19 && value.activeTab.chapter == 23,
    );
    await _waitForPersistedChapter(db, secondId, 23);
    container
        .read(bibleReaderProvider.notifier)
        .updateReadingPosition(verse: 4, fraction: 0.6, offset: 240);
    await _waitForPersistedPosition(db, secondId, verse: 4, offset: 240);

    await container.read(readingTabsProvider.notifier).selectTab(firstId);
    expect(container.read(bibleReaderProvider).bookId, 43);
    expect(container.read(bibleReaderProvider).chapter, 3);
    expect(container.read(bibleReaderProvider).scrollVerse, 16);
    expect(container.read(bibleReaderProvider).scrollFraction, 0.3);
    expect(container.read(bibleReaderProvider).scrollOffset, 720);
    autoSaveSubscription.close();
    container.dispose();

    container = createTestContainer(db: db, closeDatabaseOnDispose: false);
    addTearDown(container.dispose);
    state = await _waitForTabs(container);
    expect(state.activeTabId, firstId);
    expect(container.read(bibleReaderProvider).bookId, 43);
    expect(container.read(bibleReaderProvider).chapter, 3);
    expect(container.read(bibleReaderProvider).scrollVerse, 16);
    expect(container.read(bibleReaderProvider).scrollOffset, 720);

    await container.read(readingTabsProvider.notifier).selectTab(secondId);
    expect(container.read(bibleReaderProvider).bookId, 19);
    expect(container.read(bibleReaderProvider).chapter, 23);
    expect(
      await container.read(readingTabsProvider.notifier).closeTab(secondId),
      isTrue,
    );
    state = container.read(readingTabsProvider).requireValue;
    expect(state.tabs, hasLength(1));
    expect(state.activeTabId, firstId);

    final rows = await db.select(db.readingTabs).get();
    expect(rows, hasLength(1));
    expect(rows.where((row) => row.isActive), hasLength(1));
  });

  test('limits reading tabs to six', () async {
    final container = createTestContainer(
      db: db,
      closeDatabaseOnDispose: false,
    );
    addTearDown(container.dispose);
    await _waitForTabs(container);
    final notifier = container.read(readingTabsProvider.notifier);

    for (var i = 1; i < maxBibleReadingTabs; i++) {
      expect(await notifier.addTab(), isTrue);
    }
    expect(container.read(readingTabsProvider).requireValue.tabs, hasLength(6));
    expect(await notifier.addTab(), isFalse);
  });

  test('ignores a concurrent duplicate add request', () async {
    final container = createTestContainer(
      db: db,
      closeDatabaseOnDispose: false,
    );
    addTearDown(container.dispose);
    await _waitForTabs(container);
    final notifier = container.read(readingTabsProvider.notifier);

    final results = await Future.wait([notifier.addTab(), notifier.addTab()]);

    expect(results.where((added) => added), hasLength(1));
    expect(container.read(readingTabsProvider).requireValue.tabs, hasLength(2));
    expect(await db.select(db.readingTabs).get(), hasLength(2));
  });
}

Future<ReadingTabsState> _waitForTabs(
  ProviderContainer container, [
  bool Function(ReadingTabsState state)? predicate,
]) async {
  for (var attempt = 0; attempt < 1000; attempt++) {
    final value = container.read(readingTabsProvider).valueOrNull;
    if (value != null && (predicate == null || predicate(value))) return value;
    await Future<void>.delayed(const Duration(milliseconds: 5));
  }
  fail(
    'Timed out waiting for reading tabs. '
    'state=${container.read(readingTabsProvider)}, '
    'active=${container.read(readingTabsProvider).valueOrNull?.activeTab.bookId}:'
    '${container.read(readingTabsProvider).valueOrNull?.activeTab.chapter}, '
    'reader=${container.read(bibleReaderProvider).bookId}:'
    '${container.read(bibleReaderProvider).chapter}',
  );
}

Future<void> _waitForPersistedChapter(
  AppDatabase db,
  int id,
  int chapter,
) async {
  for (var attempt = 0; attempt < 1000; attempt++) {
    final row =
        await (db.select(db.readingTabs)
          ..where((tab) => tab.id.equals(id))).getSingleOrNull();
    if (row?.chapter == chapter) return;
    await Future<void>.delayed(const Duration(milliseconds: 5));
  }
  fail('Timed out waiting for tab $id to persist chapter $chapter');
}

Future<void> _waitForPersistedPosition(
  AppDatabase db,
  int id, {
  required int verse,
  required double offset,
}) async {
  for (var attempt = 0; attempt < 1000; attempt++) {
    final row =
        await (db.select(db.readingTabs)
          ..where((tab) => tab.id.equals(id))).getSingleOrNull();
    if (row?.scrollVerse == verse && row?.scrollOffset == offset) return;
    await Future<void>.delayed(const Duration(milliseconds: 5));
  }
  fail('Timed out waiting for tab $id to persist verse $verse at $offset');
}
