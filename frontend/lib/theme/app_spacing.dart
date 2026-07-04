// lib/theme/app_spacing.dart
// [NEW] 앱 전체 간격 / 반지름 상수

abstract final class AppSpacing {
  AppSpacing._();

  // ── Base Spacing ──────────────────────────────────────────────────
  static const double xs = 4.0;
  static const double sm = 8.0;
  static const double md = 12.0;
  static const double lg = 16.0;
  static const double xl = 20.0;
  static const double xxl = 24.0;
  static const double xxxl = 32.0;
  static const double xxxxl = 48.0;
  static const double huge = 64.0;

  // ── Border Radius ─────────────────────────────────────────────────
  static const double radiusXs = 4.0;
  static const double radiusSm = 8.0;
  static const double radiusMd = 12.0;
  static const double radiusLg = 16.0;
  static const double radiusXl = 20.0;
  static const double radiusXxl = 28.0;
  static const double radiusFull = 999.0;

  // ── Icon Sizes ────────────────────────────────────────────────────
  static const double iconXs = 14.0;
  static const double iconSm = 18.0;
  static const double iconMd = 22.0;
  static const double iconLg = 28.0;
  static const double iconXl = 36.0;

  // ── Page Padding ──────────────────────────────────────────────────
  static const double pagePaddingHorizontal = 16.0;
  static const double pagePaddingVertical = 12.0;

  // ── Bottom Sheet ──────────────────────────────────────────────────
  static const double bottomSheetPeek = 56.0;
  static const double bottomSheetHandleWidth = 36.0;
  static const double bottomSheetHandleHeight = 4.0;

  // ── Bible Reader ──────────────────────────────────────────────────
  static const double verseSpacing = 8.0;
  static const double chapterTitleSize = 32.0;
  static const double verseNumberWidth = 28.0;

  // ── Navigation ────────────────────────────────────────────────────
  static const double navBarHeight = 80.0;
  static const double appBarHeight = 56.0;
}
