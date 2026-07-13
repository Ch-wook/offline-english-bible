import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:offline_english_bible/features/bible/domain/entities/verse.dart';
import 'package:offline_english_bible/features/bible/presentation/widgets/verse_item.dart';
import 'package:offline_english_bible/features/settings/presentation/providers/settings_provider.dart';

import '../../../../helpers/provider_container_helper.dart';
import '../../../../helpers/test_database_helper.dart';

void main() {
  testWidgets('renders a saved verse highlight behind the text', (
    tester,
  ) async {
    final db = createTestDatabase();
    final container = createTestContainer(db: db);
    addTearDown(() async {
      container.dispose();
      await closeTestDatabase(db);
    });

    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: const MaterialApp(
          home: Scaffold(
            body: VerseItem(
              verse: Verse(
                bookId: 1,
                chapter: 1,
                verseNumber: 1,
                text: 'In the beginning God created the heaven and the earth.',
              ),
              highlightColorCode: 'yellow',
            ),
          ),
        ),
      ),
    );
    await tester.pump();

    final containerWidget = tester.widget<AnimatedContainer>(
      find.byType(AnimatedContainer),
    );
    final decoration = containerWidget.decoration! as BoxDecoration;
    expect(decoration.color, isNot(equals(Colors.transparent)));
  });

  testWidgets('parallel text uses the same readable size and line height', (
    tester,
  ) async {
    final db = createTestDatabase();
    final container = createTestContainer(db: db);
    addTearDown(() async {
      container.dispose();
      await closeTestDatabase(db);
    });

    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: const MaterialApp(
          home: Scaffold(
            body: VerseItem(
              verse: Verse(
                bookId: 1,
                chapter: 1,
                verseNumber: 1,
                text: 'In the beginning God created.',
              ),
              parallelVerse: Verse(
                bookId: 1,
                chapter: 1,
                verseNumber: 1,
                text: '태초에 하나님이 천지를 창조하시니라',
                translationCode: 'KOREAN_RV',
              ),
            ),
          ),
        ),
      ),
    );
    await tester.pump();

    final primary = tester.widget<RichText>(
      find.descendant(
        of: find.byKey(const ValueKey('primary-KJV-1')),
        matching: find.byType(RichText),
      ),
    );
    final parallel = tester.widget<RichText>(
      find.descendant(
        of: find.byKey(const ValueKey('parallel-KOREAN_RV-1')),
        matching: find.byType(RichText),
      ),
    );
    final primarySpans = (primary.text as TextSpan).children!.cast<TextSpan>();
    final parallelSpans =
        (parallel.text as TextSpan).children!.cast<TextSpan>();
    final primaryBody = primarySpans.firstWhere((span) => span.text == 'In');
    final parallelBody = parallelSpans.single;

    expect(primarySpans.first.text, '1  ');
    expect(primaryBody.style!.fontSize, 17);
    expect(parallelBody.style!.fontSize, primaryBody.style!.fontSize);
    expect(parallelBody.style!.height, primaryBody.style!.height);

    await container.read(settingsProvider.notifier).toggleShowVerseNumbers();
    await tester.pump();
    final hiddenNumberText = tester.widget<RichText>(
      find.descendant(
        of: find.byKey(const ValueKey('primary-KJV-1')),
        matching: find.byType(RichText),
      ),
    );
    final hiddenSpans =
        (hiddenNumberText.text as TextSpan).children!.cast<TextSpan>();
    expect(hiddenSpans.first.text, 'In');
  });
}
