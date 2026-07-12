import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:offline_english_bible/core/database/app_database.dart';
import 'package:offline_english_bible/features/bible/domain/entities/book.dart';
import 'package:offline_english_bible/features/bible/domain/entities/chapter_content.dart';
import 'package:offline_english_bible/features/bible/domain/entities/verse.dart';
import 'package:offline_english_bible/features/bible/presentation/pages/bible_reader_page.dart';
import 'package:offline_english_bible/features/bible/presentation/providers/bible_providers.dart';
import 'package:offline_english_bible/features/bible/presentation/widgets/verse_item.dart';

import '../../../../helpers/provider_container_helper.dart';
import '../../../../helpers/test_database_helper.dart';

void main() {
  const content = ChapterContent(
    book: Book(
      id: 1,
      name: 'Genesis',
      nameKorean: '창세기',
      abbreviation: 'Gen',
      abbreviationKorean: '창',
      testament: 'OT',
      orderIndex: 1,
      chapterCount: 50,
    ),
    chapterNumber: 1,
    verses: [
      Verse(
        bookId: 1,
        chapter: 1,
        verseNumber: 1,
        text: 'In the beginning God created the heaven and the earth.',
      ),
    ],
    translationCode: 'KJV',
  );

  Future<({AppDatabase db, ProviderContainer container})> pumpReader(
    WidgetTester tester,
  ) async {
    tester.view.physicalSize = const Size(320, 568);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    final db = createTestDatabase();
    final container = createTestContainer(
      db: db,
      additionalOverrides: [
        currentChapterProvider.overrideWith((ref) async => content),
      ],
    );
    addTearDown(() async {
      container.dispose();
      await closeTestDatabase(db);
    });

    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: const MaterialApp(home: BibleReaderPage()),
      ),
    );
    await tester.pumpAndSettle();
    expect(tester.takeException(), isNull);
    return (db: db, container: container);
  }

  testWidgets('long press applies and displays a verse highlight', (
    tester,
  ) async {
    final testContext = await pumpReader(tester);

    await tester.longPress(find.byType(VerseItem));
    await tester.pumpAndSettle();
    await tester.tap(find.byTooltip('형광펜'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('노랑'));
    await tester.pumpAndSettle();

    final highlights =
        await testContext.db.select(testContext.db.highlights).get();
    expect(highlights, hasLength(1));
    expect(highlights.single.color, 'yellow');
    expect(find.textContaining('형광펜이 적용되었습니다'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('long press saves a bookmark without layout overflow', (
    tester,
  ) async {
    final testContext = await pumpReader(tester);

    await tester.longPress(find.byType(VerseItem));
    await tester.pumpAndSettle();
    await tester.tap(find.byTooltip('북마크'));
    await tester.pumpAndSettle();

    final bookmarks =
        await testContext.db.select(testContext.db.bookmarks).get();
    expect(bookmarks, hasLength(1));
    expect(find.text('북마크에 저장했습니다'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
