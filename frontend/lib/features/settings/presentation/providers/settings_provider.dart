// lib/features/settings/presentation/providers/settings_provider.dart
// [NEW] 설정 StateNotifier + Provider

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../domain/entities/app_settings.dart';

// ── Hive Box Name ─────────────────────────────────────────────────────
const _settingsKey = 'settings';

// ── Settings Repository ───────────────────────────────────────────────

class SettingsRepository {
  SettingsRepository(this._box);

  final Box<dynamic> _box;

  AppSettings load() {
    final raw = _box.get(_settingsKey);
    if (raw == null) return const AppSettings();
    try {
      return AppSettings.fromMap(raw as Map<dynamic, dynamic>);
    } catch (_) {
      return const AppSettings();
    }
  }

  Future<void> save(AppSettings settings) =>
      _box.put(_settingsKey, settings.toMap());
}

// ── Provider ──────────────────────────────────────────────────────────

/// Hive Box provider — main() 에서 override 로 주입.
final settingsBoxProvider = Provider<Box<dynamic>>((ref) {
  throw UnimplementedError(
    'settingsBoxProvider must be overridden in main() after Hive.init()',
  );
});

final settingsRepositoryProvider = Provider<SettingsRepository>((ref) {
  return SettingsRepository(ref.watch(settingsBoxProvider));
});

final settingsProvider = StateNotifierProvider<SettingsNotifier, AppSettings>((
  ref,
) {
  final repo = ref.watch(settingsRepositoryProvider);
  return SettingsNotifier(repo);
});

// ── Convenience Selectors ─────────────────────────────────────────────

/// 테마 모드만 구독 (불필요한 리빌드 방지).
final themeModeProvider = Provider<ThemeMode>((ref) {
  return ref.watch(settingsProvider.select((s) => s.themeMode));
});

/// 기본 번역본 코드.
final defaultTranslationProvider = Provider<String>((ref) {
  return ref.watch(settingsProvider.select((s) => s.defaultTranslation));
});

/// 성경 본문 폰트 크기.
final bibleFontSizeProvider = Provider<double>((ref) {
  return ref.watch(settingsProvider.select((s) => s.fontSize));
});

/// 행간.
final bibleLineSpacingProvider = Provider<double>((ref) {
  return ref.watch(settingsProvider.select((s) => s.lineSpacing));
});

/// 대역 보기 활성화 여부.
final parallelViewProvider = Provider<bool>((ref) {
  return ref.watch(settingsProvider.select((s) => s.parallelView));
});

// ── StateNotifier ─────────────────────────────────────────────────────

class SettingsNotifier extends StateNotifier<AppSettings> {
  SettingsNotifier(this._repo) : super(_repo.load());

  final SettingsRepository _repo;

  Future<void> setThemeMode(ThemeMode mode) =>
      _update(state.copyWith(themeMode: mode));

  Future<void> setFontSize(double size) =>
      _update(state.copyWith(fontSize: size.clamp(12.0, 28.0)));

  Future<void> setLineSpacing(double spacing) =>
      _update(state.copyWith(lineSpacing: spacing.clamp(1.4, 2.5)));

  Future<void> setFontFamily(String family) =>
      _update(state.copyWith(fontFamily: family));

  Future<void> setDefaultTranslation(String code) =>
      _update(state.copyWith(defaultTranslation: code));

  Future<void> setDefaultKoreanTranslation(String code) =>
      _update(state.copyWith(defaultKoreanTranslation: code));

  Future<void> toggleAutoScroll() =>
      _update(state.copyWith(autoScroll: !state.autoScroll));

  Future<void> setAutoScrollSpeed(double speed) =>
      _update(state.copyWith(autoScrollSpeed: speed.clamp(10.0, 200.0)));

  Future<void> toggleParallelView() =>
      _update(state.copyWith(parallelView: !state.parallelView));

  Future<void> setParallelLeftLanguage(String lang) =>
      _update(state.copyWith(parallelLeftLanguage: lang));

  Future<void> toggleShowVerseNumbers() =>
      _update(state.copyWith(showVerseNumbers: !state.showVerseNumbers));

  Future<void> toggleShowStrongNumbers() =>
      _update(state.copyWith(showStrongNumbers: !state.showStrongNumbers));

  Future<void> toggleKeepScreenOn() =>
      _update(state.copyWith(keepScreenOn: !state.keepScreenOn));

  Future<void> resetToDefaults() => _update(const AppSettings());

  Future<void> _update(AppSettings updated) async {
    state = updated;
    await _repo.save(updated);
  }
}
