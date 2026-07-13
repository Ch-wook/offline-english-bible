import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:offline_english_bible/features/bible/presentation/providers/reading_tabs_provider.dart';
import 'package:offline_english_bible/features/bible/presentation/widgets/bible_reading_tabs_bar.dart';

import '../../../../helpers/provider_container_helper.dart';
import '../../../../helpers/test_database_helper.dart';

void main() {
  testWidgets('reading tabs stay usable on a narrow phone screen', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(320, 568);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

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
          home: Scaffold(bottomNavigationBar: BibleReadingTabsBar()),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('창 1'), findsOneWidget);
    expect(find.byTooltip('읽기 탭 추가'), findsOneWidget);
    expect(tester.takeException(), isNull);

    for (var i = 1; i < maxBibleReadingTabs; i++) {
      await container.read(readingTabsProvider.notifier).addTab();
    }
    await tester.pumpAndSettle();

    expect(find.byTooltip('읽기 탭은 최대 6개까지 사용할 수 있습니다'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
