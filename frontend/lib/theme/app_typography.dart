// lib/theme/app_typography.dart
// [NEW] 앱 전체 텍스트 스타일 정의

import 'package:flutter/material.dart';

/// 앱 타이포그래피 상수.
///
/// - [NotoSerif] : 성경 본문 (가독성, 전통적)
/// - [Inter]     : UI 전반 (클린, 현대적)
///
/// Google Fonts 사용 없이 bundled assets 의존.
abstract final class AppTypography {
  AppTypography._();

  static const String _bibleFont = 'NotoSerif';
  static const String _uiFont = 'Inter';

  // ── Bible Text ────────────────────────────────────────────────────
  static const TextStyle bibleBody = TextStyle(
    fontFamily: _bibleFont,
    fontSize: 17,
    height: 1.85,
    letterSpacing: 0.15,
    fontWeight: FontWeight.w400,
  );

  static const TextStyle bibleBodyLarge = TextStyle(
    fontFamily: _bibleFont,
    fontSize: 19,
    height: 1.85,
    letterSpacing: 0.1,
    fontWeight: FontWeight.w400,
  );

  static const TextStyle bibleBodySmall = TextStyle(
    fontFamily: _bibleFont,
    fontSize: 15,
    height: 1.75,
    letterSpacing: 0.2,
    fontWeight: FontWeight.w400,
  );

  static const TextStyle bibleBodyXSmall = TextStyle(
    fontFamily: _bibleFont,
    fontSize: 13,
    height: 1.65,
    letterSpacing: 0.2,
    fontWeight: FontWeight.w400,
  );

  static const TextStyle bibleItalic = TextStyle(
    fontFamily: _bibleFont,
    fontSize: 17,
    height: 1.85,
    fontStyle: FontStyle.italic,
    fontWeight: FontWeight.w400,
  );

  // ── Verse Number ──────────────────────────────────────────────────
  static const TextStyle verseNumber = TextStyle(
    fontFamily: _uiFont,
    fontSize: 11,
    height: 1.0,
    fontWeight: FontWeight.w700,
    letterSpacing: 0.3,
  );

  // ── Chapter Number (display) ──────────────────────────────────────
  static const TextStyle chapterNumber = TextStyle(
    fontFamily: _bibleFont,
    fontSize: 64,
    height: 0.9,
    fontWeight: FontWeight.w700,
    letterSpacing: -2.0,
  );

  // ── IPA Notation ──────────────────────────────────────────────────
  static const TextStyle ipa = TextStyle(
    fontFamily: _uiFont,
    fontSize: 14,
    height: 1.5,
    fontStyle: FontStyle.italic,
    letterSpacing: 0.3,
  );

  // ── Strong Number ─────────────────────────────────────────────────
  static const TextStyle strongNumber = TextStyle(
    fontFamily: _uiFont,
    fontSize: 11,
    height: 1.0,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.5,
  );

  // ── Original Language (Hebrew / Greek) ───────────────────────────
  static const TextStyle originalLanguage = TextStyle(
    fontFamily: _bibleFont,
    fontSize: 20,
    height: 1.6,
    fontWeight: FontWeight.w400,
  );

  // ── UI Text (Material Design 3 equivalents) ───────────────────────
  static const TextStyle displayLarge = TextStyle(
    fontFamily: _uiFont,
    fontSize: 57,
    height: 1.12,
    fontWeight: FontWeight.w400,
    letterSpacing: -0.25,
  );

  static const TextStyle displayMedium = TextStyle(
    fontFamily: _uiFont,
    fontSize: 45,
    height: 1.16,
    fontWeight: FontWeight.w400,
    letterSpacing: 0,
  );

  static const TextStyle headlineLarge = TextStyle(
    fontFamily: _uiFont,
    fontSize: 32,
    height: 1.25,
    fontWeight: FontWeight.w700,
    letterSpacing: -0.5,
  );

  static const TextStyle headlineMedium = TextStyle(
    fontFamily: _uiFont,
    fontSize: 28,
    height: 1.29,
    fontWeight: FontWeight.w600,
    letterSpacing: -0.3,
  );

  static const TextStyle headlineSmall = TextStyle(
    fontFamily: _uiFont,
    fontSize: 24,
    height: 1.33,
    fontWeight: FontWeight.w600,
    letterSpacing: -0.2,
  );

  static const TextStyle titleLarge = TextStyle(
    fontFamily: _uiFont,
    fontSize: 22,
    height: 1.27,
    fontWeight: FontWeight.w600,
    letterSpacing: 0,
  );

  static const TextStyle titleMedium = TextStyle(
    fontFamily: _uiFont,
    fontSize: 16,
    height: 1.5,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.15,
  );

  static const TextStyle titleSmall = TextStyle(
    fontFamily: _uiFont,
    fontSize: 14,
    height: 1.43,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.1,
  );

  static const TextStyle bodyLarge = TextStyle(
    fontFamily: _uiFont,
    fontSize: 16,
    height: 1.5,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.5,
  );

  static const TextStyle bodyMedium = TextStyle(
    fontFamily: _uiFont,
    fontSize: 14,
    height: 1.43,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.25,
  );

  static const TextStyle bodySmall = TextStyle(
    fontFamily: _uiFont,
    fontSize: 12,
    height: 1.33,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.4,
  );

  static const TextStyle labelLarge = TextStyle(
    fontFamily: _uiFont,
    fontSize: 14,
    height: 1.43,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.1,
  );

  static const TextStyle labelMedium = TextStyle(
    fontFamily: _uiFont,
    fontSize: 12,
    height: 1.33,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.5,
  );

  static const TextStyle labelSmall = TextStyle(
    fontFamily: _uiFont,
    fontSize: 11,
    height: 1.45,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.5,
  );

  // ── Dynamic Bible Font Size (user-configurable) ───────────────────
  static TextStyle bibleBodyWithSize(double fontSize, double lineHeight) =>
      TextStyle(
        fontFamily: _bibleFont,
        fontSize: fontSize,
        height: lineHeight,
        letterSpacing: 0.15,
        fontWeight: FontWeight.w400,
      );
}
