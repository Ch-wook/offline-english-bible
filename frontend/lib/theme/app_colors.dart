// lib/theme/app_colors.dart
// [NEW] 앱 전체 색상 팔레트 정의

import 'package:flutter/material.dart';

abstract final class AppColors {
  AppColors._();

  // ── Light Theme ───────────────────────────────────────────────────
  static const Color lightPrimary = Color(0xFF2B5797); // Royal Blue
  static const Color lightOnPrimary = Color(0xFFFFFFFF);
  static const Color lightPrimaryContainer = Color(0xFFD6E4FF);
  static const Color lightOnPrimaryContainer = Color(0xFF001A41);

  static const Color lightSecondary = Color(0xFF8B6000); // Amber/Gold
  static const Color lightOnSecondary = Color(0xFFFFFFFF);
  static const Color lightSecondaryContainer = Color(0xFFFFDDB3);
  static const Color lightOnSecondaryContainer = Color(0xFF2B1700);

  static const Color lightTertiary = Color(0xFF3A6B3B); // Sage Green
  static const Color lightOnTertiary = Color(0xFFFFFFFF);
  static const Color lightTertiaryContainer = Color(0xFFBCF0B7);
  static const Color lightOnTertiaryContainer = Color(0xFF002107);

  static const Color lightError = Color(0xFFBA1A1A);
  static const Color lightOnError = Color(0xFFFFFFFF);
  static const Color lightErrorContainer = Color(0xFFFFDAD6);
  static const Color lightOnErrorContainer = Color(0xFF410002);

  static const Color lightBackground = Color(0xFFF5F3EE); // Warm parchment
  static const Color lightOnBackground = Color(0xFF1B1C17);
  static const Color lightSurface = Color(0xFFFFFBFF);
  static const Color lightOnSurface = Color(0xFF1B1C17);
  static const Color lightSurfaceVariant = Color(0xFFE1E2EB);
  static const Color lightOnSurfaceVariant = Color(0xFF44464E);
  static const Color lightOutline = Color(0xFF74757F);
  static const Color lightOutlineVariant = Color(0xFFC4C5CF);

  // ── Dark Theme ────────────────────────────────────────────────────
  static const Color darkPrimary = Color(0xFFAAC7FF); // Luminous blue
  static const Color darkOnPrimary = Color(0xFF002D6F);
  static const Color darkPrimaryContainer = Color(0xFF00429B);
  static const Color darkOnPrimaryContainer = Color(0xFFD6E4FF);

  static const Color darkSecondary = Color(0xFFFFBA4A); // Warm gold
  static const Color darkOnSecondary = Color(0xFF472A00);
  static const Color darkSecondaryContainer = Color(0xFF664000);
  static const Color darkOnSecondaryContainer = Color(0xFFFFDDB3);

  static const Color darkTertiary = Color(0xFFA1D39D); // Soft sage
  static const Color darkOnTertiary = Color(0xFF073910);
  static const Color darkTertiaryContainer = Color(0xFF225126);
  static const Color darkOnTertiaryContainer = Color(0xFFBCF0B7);

  static const Color darkError = Color(0xFFFFB4AB);
  static const Color darkOnError = Color(0xFF690005);
  static const Color darkErrorContainer = Color(0xFF93000A);
  static const Color darkOnErrorContainer = Color(0xFFFFDAD6);

  static const Color darkBackground = Color(0xFF0D1117); // Deep GitHub-dark navy
  static const Color darkOnBackground = Color(0xFFE3E2E6);
  static const Color darkSurface = Color(0xFF13181F);
  static const Color darkOnSurface = Color(0xFFE3E2E6);
  static const Color darkSurfaceVariant = Color(0xFF1C2637);
  static const Color darkOnSurfaceVariant = Color(0xFFC5C6D0);
  static const Color darkOutline = Color(0xFF8E8F99);
  static const Color darkOutlineVariant = Color(0xFF44464E);

  // ── Highlight Colors (형광펜) ─────────────────────────────────────
  static const Color highlightYellow = Color(0xFFFFF176);
  static const Color highlightGreen = Color(0xFFA5D6A7);
  static const Color highlightBlue = Color(0xFF90CAF9);
  static const Color highlightPink = Color(0xFFF48FB1);
  static const Color highlightOrange = Color(0xFFFFCC80);

  static const List<Color> highlightColors = [
    highlightYellow,
    highlightGreen,
    highlightBlue,
    highlightPink,
    highlightOrange,
  ];

  // ── Bible-Specific Semantic Colors ───────────────────────────────
  static const Color verseNumberLight = Color(0xFF8B6000);
  static const Color verseNumberDark = Color(0xFFFFBA4A);

  static const Color strongNumberLight = Color(0xFF6A3B9A);
  static const Color strongNumberDark = Color(0xFFCDA8F0);

  static const Color hebrewTextColor = Color(0xFF8B1A1A);
  static const Color greekTextColor = Color(0xFF1A4E8B);

  static const Color kjvBadgeLight = Color(0xFF2B5797);
  static const Color kjvBadgeDark = Color(0xFFAAC7FF);

  static const Color koreanBadgeLight = Color(0xFF3A6B3B);
  static const Color koreanBadgeDark = Color(0xFFA1D39D);

  // ── Surface Elevation Overlays ────────────────────────────────────
  static const Color surface1Dark = Color(0xFF171D25);
  static const Color surface2Dark = Color(0xFF1B222C);
  static const Color surface3Dark = Color(0xFF1F2733);

  static const Color surface1Light = Color(0xFFF0EEE9);
  static const Color surface2Light = Color(0xFFEBE9E3);
  static const Color surface3Light = Color(0xFFE5E3DC);
}
