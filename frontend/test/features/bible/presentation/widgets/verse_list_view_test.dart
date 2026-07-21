import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:offline_english_bible/core/database/app_database.dart';
import 'package:offline_english_bible/features/bible/domain/entities/book.dart';
import 'package:offline_english_bible/features/bible/domain/entities/chapter_content.dart';
import 'package:offline_english_bible/features/bible/domain/entities/verse.dart';
import 'package:offline_english_bible/features/bible/presentation/providers/bible_reader_provider.dart';
import 'package:offline_english_bible/features/bible/presentation/widgets/verse_item.dart';
import 'package:offline_english_bible/features/bible/presentation/widgets/verse_list_view.dart';

import '../../../../helpers/provider_container_helper.dart';
import '../../../../helpers/test_database_helper.dart';

void main() {
  const book = Book(
    id: 1,
    name: 'Genesis',
    nameKorean: '창세기',
    abbreviation: 'Gen',
    abbreviationKorean: '창',
    testament: 'OT',
    orderIndex: 1,
    chapterCount: 50,
  );

  ChapterContent contentFor(int chapter) => ChapterContent(
    book: book,
    chapterNumber: chapter,
    verses: [
      for (var verse = 1; verse <= 20; verse++)
        Verse(
          bookId: 1,
          chapter: chapter,
          verseNumber: verse,
          text:
              'Verse $verse has enough text to create a readable line '
              'and a scrollable chapter for navigation testing.',
        ),
    ],
    translationCode: 'KJV',
  );

  Future<({AppDatabase db, ProviderContainer container})> pumpList(
    WidgetTester tester, {
    required int chapter,
    int targetVerse = 1,
  }) async {
    tester.view.physicalSize = const Size(360, 560);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    final db = createTestDatabase();
    final container = createTestContainer(db: db);
    container
        .read(bibleReaderProvider.notifier)
        .navigateTo(bookId: 1, chapter: chapter, verse: targetVerse);
    addTearDown(() async {
      container.dispose();
      await closeTestDatabase(db);
    });
    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: MaterialApp(
          home: Scaffold(body: VerseListView(content: contentFor(chapter))),
        ),
      ),
    );
    await tester.pumpAndSettle();
    return (db: db, container: container);
  }

  Future<void> repumpList(
    WidgetTester tester,
    ProviderContainer container, {
    required int chapter,
  }) async {
    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: MaterialApp(
          home: Scaffold(body: VerseListView(content: contentFor(chapter))),
        ),
      ),
    );
  }

  double chapterSlideOffset(WidgetTester tester) {
    final transform = tester.widget<Transform>(
      find.byKey(const ValueKey('chapter-slide-transform')),
    );
    return transform.transform.getTranslation().x;
  }

  testWidgets('reaching and pulling beyond the bottom keeps the chapter', (
    tester,
  ) async {
    final context = await pumpList(tester, chapter: 1);
    final scrollView = find.byType(SingleChildScrollView);

    await tester.scrollUntilVisible(
      find.text('2장'),
      400,
      scrollable: find.byType(Scrollable),
    );
    await tester.drag(scrollView, const Offset(0, -120));
    await tester.pumpAndSettle();

    expect(context.container.read(bibleReaderProvider).chapter, 1);
  });

  testWidgets('pulling beyond the top keeps the chapter', (tester) async {
    final context = await pumpList(tester, chapter: 2);

    await tester.drag(find.byType(SingleChildScrollView), const Offset(0, 120));
    await tester.pumpAndSettle();

    expect(context.container.read(bibleReaderProvider).chapter, 2);
  });

  testWidgets('swiping left opens the next chapter', (tester) async {
    final context = await pumpList(tester, chapter: 1);

    await tester.drag(
      find.byKey(const ValueKey('chapter-swipe-detector')),
      const Offset(-180, 0),
    );
    await tester.pumpAndSettle();

    expect(context.container.read(bibleReaderProvider).chapter, 2);
  });

  testWidgets('swiping right opens the previous chapter', (tester) async {
    final context = await pumpList(tester, chapter: 2);

    await tester.drag(
      find.byKey(const ValueKey('chapter-swipe-detector')),
      const Offset(180, 0),
    );
    await tester.pumpAndSettle();

    expect(context.container.read(bibleReaderProvider).chapter, 1);
  });

  testWidgets('chapter follows the finger then switches without a blank page', (
    tester,
  ) async {
    final context = await pumpList(tester, chapter: 1);
    final detector = find.byKey(const ValueKey('chapter-swipe-detector'));
    final gesture = await tester.startGesture(tester.getCenter(detector));

    await gesture.moveBy(const Offset(-20, 0));
    await tester.pump();
    await gesture.moveBy(const Offset(-90, 0));
    await tester.pump();
    expect(chapterSlideOffset(tester), inInclusiveRange(-24, -1));

    await gesture.up();
    await tester.pump();
    expect(context.container.read(bibleReaderProvider).chapter, 2);

    await repumpList(tester, context.container, chapter: 2);
    await tester.pump();
    expect(chapterSlideOffset(tester), closeTo(0, 0.01));
    expect(find.byType(VerseItem), findsNWidgets(20));
  });

  testWidgets('a short chapter swipe settles back without navigating', (
    tester,
  ) async {
    final context = await pumpList(tester, chapter: 1);
    final detector = find.byKey(const ValueKey('chapter-swipe-detector'));
    final gesture = await tester.startGesture(tester.getCenter(detector));

    await gesture.moveBy(const Offset(-20, 0));
    await tester.pump();
    await gesture.moveBy(const Offset(-36, 0));
    await tester.pump();
    expect(chapterSlideOffset(tester), inInclusiveRange(-24, -1));

    await gesture.up();
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 90));
    expect(chapterSlideOffset(tester).abs(), lessThan(24));
    await tester.pump(const Duration(milliseconds: 100));

    expect(chapterSlideOffset(tester), closeTo(0, 0.01));
    expect(context.container.read(bibleReaderProvider).chapter, 1);
  });

  testWidgets('scrolling records the visible verse and offset', (tester) async {
    final context = await pumpList(tester, chapter: 1);

    await tester.drag(
      find.byType(SingleChildScrollView),
      const Offset(0, -420),
    );
    await tester.pump(const Duration(milliseconds: 1100));

    final reader = context.container.read(bibleReaderProvider);
    expect(reader.scrollOffset, greaterThan(0));
    expect(reader.scrollVerse, greaterThan(1));
    expect(reader.scrollFraction, inInclusiveRange(0, 1));
  });

  testWidgets('saving position does not rebuild verse paragraphs', (
    tester,
  ) async {
    final context = await pumpList(tester, chapter: 1);
    final firstParagraph = find.descendant(
      of: find.byType(VerseItem).first,
      matching: find.byType(RichText),
    );
    final before = tester.widget<RichText>(firstParagraph);

    context.container
        .read(bibleReaderProvider.notifier)
        .updateReadingPosition(verse: 2, fraction: 0.2, offset: 80);
    await tester.pump();

    final after = tester.widget<RichText>(firstParagraph);
    expect(identical(after, before), isTrue);
  });

  testWidgets('auto scroll advances on frame ticks and stops cleanly', (
    tester,
  ) async {
    final context = await pumpList(tester, chapter: 1);
    final scrollView = tester.widget<SingleChildScrollView>(
      find.byType(SingleChildScrollView),
    );
    final controller = scrollView.controller!;

    context.container.read(bibleReaderProvider.notifier).toggleAutoScroll();
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 16));
    final before = controller.offset;
    await tester.pump(const Duration(milliseconds: 16));

    expect(controller.offset, greaterThan(before));

    context.container.read(bibleReaderProvider.notifier).toggleAutoScroll();
    await tester.pump();
    final stoppedAt = controller.offset;
    await tester.pump(const Duration(milliseconds: 100));

    expect(controller.offset, closeTo(stoppedAt, 0.01));
  });

  testWidgets('exact navigation restores the requested verse', (tester) async {
    final context = await pumpList(tester, chapter: 1, targetVerse: 15);

    final target = tester.getRect(find.byType(VerseItem).at(14));
    expect(target.top, lessThanOrEqualTo(1));
    expect(target.bottom, greaterThan(0));
    expect(context.container.read(bibleReaderProvider).scrollVerse, 15);
  });

  testWidgets('parallel view rebuild restores the same visible verse', (
    tester,
  ) async {
    final context = await pumpList(tester, chapter: 1);
    await tester.drag(
      find.byType(SingleChildScrollView),
      const Offset(0, -520),
    );
    await tester.pump(const Duration(milliseconds: 1100));
    final before = context.container.read(bibleReaderProvider);
    expect(before.scrollVerse, greaterThan(1));

    await tester.pumpWidget(const SizedBox.shrink());
    context.container.read(bibleReaderProvider.notifier).toggleParallelView();
    final parallelContent = ChapterContent(
      book: book,
      chapterNumber: 1,
      verses: contentFor(1).verses,
      translationCode: 'KJV',
      parallelTranslationCode: 'KOREAN_RV',
      parallelVerses: [
        for (var verse = 1; verse <= 20; verse++)
          Verse(
            bookId: 1,
            chapter: 1,
            verseNumber: verse,
            text: '$verse절의 한국어 대역 본문을 표시합니다.',
            translationCode: 'KOREAN_RV',
          ),
      ],
    );
    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: context.container,
        child: MaterialApp(
          home: Scaffold(body: VerseListView(content: parallelContent)),
        ),
      ),
    );
    await tester.pumpAndSettle();

    final restoredVerse = tester.getRect(
      find.byType(VerseItem).at(before.scrollVerse - 1),
    );
    expect(restoredVerse.top, lessThanOrEqualTo(1));
    expect(restoredVerse.bottom, greaterThan(0));
    expect(
      context.container.read(bibleReaderProvider).scrollVerse,
      before.scrollVerse,
    );
  });
}
