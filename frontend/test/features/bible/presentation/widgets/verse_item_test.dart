import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:offline_english_bible/features/bible/domain/entities/verse.dart';
import 'package:offline_english_bible/features/bible/presentation/widgets/verse_item.dart';

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
}
