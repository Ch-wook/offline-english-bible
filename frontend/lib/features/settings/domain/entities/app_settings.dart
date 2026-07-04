// lib/features/settings/domain/entities/app_settings.dart
// [NEW] 앱 설정 엔티티 (Hive 직렬화 없이 순수 Dart)

import 'package:flutter/material.dart';

/// 앱 전체 사용자 설정.
/// Hive Box<dynamic> 에 직렬화되어 저장된다.
class AppSettings {
  const AppSettings({
    this.themeMode = ThemeMode.system,
    this.fontSize = 17.0,
    this.lineSpacing = 1.85,
    this.fontFamily = 'NotoSerif',
    this.defaultTranslation = 'KJV',
    this.defaultKoreanTranslation = 'KOREAN_RV',
    this.autoScroll = false,
    this.autoScrollSpeed = 50.0,
    this.parallelView = false,
    this.parallelLeftLanguage = 'ko',
    this.showVerseNumbers = true,
    this.showStrongNumbers = false,
    this.keepScreenOn = true,
  });

  /// 테마 모드 (라이트 / 다크 / 시스템).
  final ThemeMode themeMode;

  /// 성경 본문 폰트 크기 (12.0 ~ 28.0).
  final double fontSize;

  /// 행간 (1.4 ~ 2.5).
  final double lineSpacing;

  /// 폰트 패밀리 ('NotoSerif' | 'Inter').
  final String fontFamily;

  /// 기본 영어 번역본 코드.
  final String defaultTranslation;

  /// 기본 한국어 번역본 코드.
  final String defaultKoreanTranslation;

  /// 자동 스크롤 사용 여부.
  final bool autoScroll;

  /// 자동 스크롤 속도 (픽셀/초, 10 ~ 200).
  final double autoScrollSpeed;

  /// 대역 보기 (한영 병렬 표시).
  final bool parallelView;

  /// 대역 왼쪽 언어 ('ko' | 'en').
  final String parallelLeftLanguage;

  /// 절 번호 표시.
  final bool showVerseNumbers;

  /// Strong 번호 표시.
  final bool showStrongNumbers;

  /// 읽기 중 화면 켜기 유지.
  final bool keepScreenOn;

  AppSettings copyWith({
    ThemeMode? themeMode,
    double? fontSize,
    double? lineSpacing,
    String? fontFamily,
    String? defaultTranslation,
    String? defaultKoreanTranslation,
    bool? autoScroll,
    double? autoScrollSpeed,
    bool? parallelView,
    String? parallelLeftLanguage,
    bool? showVerseNumbers,
    bool? showStrongNumbers,
    bool? keepScreenOn,
  }) =>
      AppSettings(
        themeMode: themeMode ?? this.themeMode,
        fontSize: fontSize ?? this.fontSize,
        lineSpacing: lineSpacing ?? this.lineSpacing,
        fontFamily: fontFamily ?? this.fontFamily,
        defaultTranslation: defaultTranslation ?? this.defaultTranslation,
        defaultKoreanTranslation:
            defaultKoreanTranslation ?? this.defaultKoreanTranslation,
        autoScroll: autoScroll ?? this.autoScroll,
        autoScrollSpeed: autoScrollSpeed ?? this.autoScrollSpeed,
        parallelView: parallelView ?? this.parallelView,
        parallelLeftLanguage:
            parallelLeftLanguage ?? this.parallelLeftLanguage,
        showVerseNumbers: showVerseNumbers ?? this.showVerseNumbers,
        showStrongNumbers: showStrongNumbers ?? this.showStrongNumbers,
        keepScreenOn: keepScreenOn ?? this.keepScreenOn,
      );

  // ── Hive 직렬화 ────────────────────────────────────────────────────

  static const _keyThemeMode = 'themeMode';
  static const _keyFontSize = 'fontSize';
  static const _keyLineSpacing = 'lineSpacing';
  static const _keyFontFamily = 'fontFamily';
  static const _keyDefaultTranslation = 'defaultTranslation';
  static const _keyDefaultKorean = 'defaultKoreanTranslation';
  static const _keyAutoScroll = 'autoScroll';
  static const _keyAutoScrollSpeed = 'autoScrollSpeed';
  static const _keyParallelView = 'parallelView';
  static const _keyParallelLeft = 'parallelLeftLanguage';
  static const _keyShowVerse = 'showVerseNumbers';
  static const _keyShowStrong = 'showStrongNumbers';
  static const _keyKeepScreen = 'keepScreenOn';

  Map<String, dynamic> toMap() => {
        _keyThemeMode: themeMode.index,
        _keyFontSize: fontSize,
        _keyLineSpacing: lineSpacing,
        _keyFontFamily: fontFamily,
        _keyDefaultTranslation: defaultTranslation,
        _keyDefaultKorean: defaultKoreanTranslation,
        _keyAutoScroll: autoScroll,
        _keyAutoScrollSpeed: autoScrollSpeed,
        _keyParallelView: parallelView,
        _keyParallelLeft: parallelLeftLanguage,
        _keyShowVerse: showVerseNumbers,
        _keyShowStrong: showStrongNumbers,
        _keyKeepScreen: keepScreenOn,
      };

  factory AppSettings.fromMap(Map<dynamic, dynamic> map) => AppSettings(
        themeMode:
            ThemeMode.values[map[_keyThemeMode] as int? ?? 0],
        fontSize: (map[_keyFontSize] as num?)?.toDouble() ?? 17.0,
        lineSpacing: (map[_keyLineSpacing] as num?)?.toDouble() ?? 1.85,
        fontFamily: map[_keyFontFamily] as String? ?? 'NotoSerif',
        defaultTranslation:
            map[_keyDefaultTranslation] as String? ?? 'KJV',
        defaultKoreanTranslation:
            map[_keyDefaultKorean] as String? ?? 'KOREAN_RV',
        autoScroll: map[_keyAutoScroll] as bool? ?? false,
        autoScrollSpeed:
            (map[_keyAutoScrollSpeed] as num?)?.toDouble() ?? 50.0,
        parallelView: map[_keyParallelView] as bool? ?? false,
        parallelLeftLanguage:
            map[_keyParallelLeft] as String? ?? 'ko',
        showVerseNumbers: map[_keyShowVerse] as bool? ?? true,
        showStrongNumbers: map[_keyShowStrong] as bool? ?? false,
        keepScreenOn: map[_keyKeepScreen] as bool? ?? true,
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppSettings &&
          themeMode == other.themeMode &&
          fontSize == other.fontSize &&
          lineSpacing == other.lineSpacing &&
          fontFamily == other.fontFamily &&
          defaultTranslation == other.defaultTranslation &&
          defaultKoreanTranslation == other.defaultKoreanTranslation &&
          autoScroll == other.autoScroll &&
          autoScrollSpeed == other.autoScrollSpeed &&
          parallelView == other.parallelView &&
          parallelLeftLanguage == other.parallelLeftLanguage &&
          showVerseNumbers == other.showVerseNumbers &&
          showStrongNumbers == other.showStrongNumbers &&
          keepScreenOn == other.keepScreenOn;

  @override
  int get hashCode => Object.hash(
        themeMode,
        fontSize,
        lineSpacing,
        fontFamily,
        defaultTranslation,
        defaultKoreanTranslation,
        autoScroll,
        autoScrollSpeed,
        parallelView,
        parallelLeftLanguage,
        showVerseNumbers,
        showStrongNumbers,
        keepScreenOn,
      );

  @override
  String toString() =>
      'AppSettings(themeMode: $themeMode, fontSize: $fontSize, '
      'translation: $defaultTranslation, parallel: $parallelView)';
}
