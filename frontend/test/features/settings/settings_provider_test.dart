// test/features/settings/settings_provider_test.dart
// [NEW] 설정 Provider 유닛 테스트

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:offline_english_bible/features/settings/domain/entities/app_settings.dart';
import 'package:offline_english_bible/features/settings/presentation/providers/settings_provider.dart';

import '../../helpers/provider_container_helper.dart';

void main() {
  group('AppSettings', () {
    test('default values are correct', () {
      const s = AppSettings();
      expect(s.themeMode, ThemeMode.system);
      expect(s.fontSize, 17.0);
      expect(s.lineSpacing, 1.85);
      expect(s.defaultTranslation, 'KJV');
      expect(s.defaultKoreanTranslation, 'KOREAN_RV');
      expect(s.parallelView, isFalse);
      expect(s.autoScroll, isFalse);
    });

    test('copyWith updates only specified fields', () {
      const s = AppSettings();
      final updated = s.copyWith(fontSize: 20.0, parallelView: true);
      expect(updated.fontSize, 20.0);
      expect(updated.parallelView, isTrue);
      // Unchanged fields
      expect(updated.themeMode, ThemeMode.system);
      expect(updated.defaultTranslation, 'KJV');
    });

    test('serialization round-trip', () {
      const original = AppSettings(
        themeMode: ThemeMode.dark,
        fontSize: 19.0,
        lineSpacing: 2.0,
        parallelView: true,
        defaultTranslation: 'KJV',
      );
      final map = original.toMap();
      final restored = AppSettings.fromMap(map);
      expect(restored, equals(original));
    });

    test('equality', () {
      const a = AppSettings(fontSize: 18.0);
      const b = AppSettings(fontSize: 18.0);
      const c = AppSettings(fontSize: 20.0);
      expect(a, equals(b));
      expect(a, isNot(equals(c)));
    });

    test('fromMap with missing keys falls back to defaults', () {
      final s = AppSettings.fromMap({});
      expect(s.themeMode, ThemeMode.system);
      expect(s.fontSize, 17.0);
    });
  });

  group('SettingsNotifier', () {
    test('setThemeMode updates themeMode', () async {
      final container = createTestContainer();
      addTearDown(container.dispose);

      final notifier = container.read(settingsProvider.notifier);
      await notifier.setThemeMode(ThemeMode.dark);

      expect(container.read(settingsProvider).themeMode, ThemeMode.dark);
    });

    test('setFontSize clamps to valid range', () async {
      final container = createTestContainer();
      addTearDown(container.dispose);

      final notifier = container.read(settingsProvider.notifier);
      await notifier.setFontSize(5.0); // below min (12)
      expect(container.read(settingsProvider).fontSize, 12.0);

      await notifier.setFontSize(100.0); // above max (28)
      expect(container.read(settingsProvider).fontSize, 28.0);
    });

    test('toggleParallelView flips boolean', () async {
      final container = createTestContainer();
      addTearDown(container.dispose);

      final notifier = container.read(settingsProvider.notifier);
      expect(container.read(settingsProvider).parallelView, isFalse);

      await notifier.toggleParallelView();
      expect(container.read(settingsProvider).parallelView, isTrue);

      await notifier.toggleParallelView();
      expect(container.read(settingsProvider).parallelView, isFalse);
    });

    test('resetToDefaults restores all fields', () async {
      final container = createTestContainer();
      addTearDown(container.dispose);

      final notifier = container.read(settingsProvider.notifier);
      await notifier.setFontSize(24.0);
      await notifier.setThemeMode(ThemeMode.dark);
      await notifier.toggleParallelView();

      await notifier.resetToDefaults();
      final s = container.read(settingsProvider);
      expect(s.fontSize, 17.0);
      expect(s.themeMode, ThemeMode.system);
      expect(s.parallelView, isFalse);
    });

    test('themeModeProvider reflects current themeMode', () async {
      final container = createTestContainer();
      addTearDown(container.dispose);

      await container.read(settingsProvider.notifier).setThemeMode(ThemeMode.light);
      expect(container.read(themeModeProvider), ThemeMode.light);
    });
  });
}
