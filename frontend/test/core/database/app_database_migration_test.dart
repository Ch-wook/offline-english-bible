import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:offline_english_bible/core/database/app_database.dart';

void main() {
  test(
    'schema 4 upgrades chapter positions without losing reading tabs',
    () async {
      final tempDirectory = await Directory.systemTemp.createTemp(
        'offline-bible-migration-',
      );
      final databaseFile = File('${tempDirectory.path}/app.sqlite');
      addTearDown(() async {
        if (tempDirectory.existsSync()) {
          await tempDirectory.delete(recursive: true);
        }
      });

      var database = AppDatabase(NativeDatabase(databaseFile));
      await database
          .into(database.readingTabs)
          .insert(
            ReadingTabsCompanion(
              bookId: const Value(9),
              chapter: const Value(2),
              translationCode: const Value('KJV'),
              isParallelView: const Value(false),
              parallelTranslationCode: const Value('KOREAN_RV'),
              scrollVerse: const Value(11),
              scrollFraction: const Value(0.4),
              scrollOffset: const Value(640),
              sortOrder: const Value(0),
              isActive: const Value(true),
              updatedAt: Value(DateTime(2026, 7, 21)),
            ),
          );
      await database.customStatement('DROP TABLE chapter_reading_positions');
      await database.customStatement('PRAGMA user_version = 4');
      await database.close();

      database = AppDatabase(NativeDatabase(databaseFile));
      addTearDown(database.close);
      final tabs = await database.select(database.readingTabs).get();
      final positionTables =
          await database
              .customSelect(
                "SELECT name FROM sqlite_master "
                "WHERE type = 'table' AND name = 'chapter_reading_positions'",
              )
              .get();

      expect(tabs, hasLength(1));
      expect(tabs.single.bookId, 9);
      expect(tabs.single.chapter, 2);
      expect(tabs.single.scrollVerse, 11);
      expect(tabs.single.scrollOffset, 640);
      expect(positionTables, hasLength(1));
    },
  );
}
