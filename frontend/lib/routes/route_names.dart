// lib/routes/route_names.dart
// [NEW] 라우트 이름 / 경로 상수

abstract final class RoutePaths {
  RoutePaths._();

  // ── Primary destinations (opened from the reader overflow menu) ──
  static const String bible = '/bible';
  static const String vocabulary = '/vocabulary';
  static const String search = '/search';
  static const String settings = '/settings';

  // ── Bible Sub-routes ──────────────────────────────────────────────
  static const String bookSelector = '/bible/books';
  static const String bibleChapter = '/bible/:bookId/:chapter';
  static const String parallelView = '/bible/parallel';

  // ── Dictionary ────────────────────────────────────────────────────
  static const String wordDetail = '/word/:word';

  // ── Vocabulary Sub-routes ─────────────────────────────────────────
  static const String vocabularyReview = '/vocabulary/review';
  static const String vocabularyDetail = '/vocabulary/:id';

  // ── Search Sub-routes ─────────────────────────────────────────────
  static const String searchResults = '/search/results';

  // ── User Data ─────────────────────────────────────────────────────
  static const String bookmarkList = '/bookmarks';
  static const String memoList = '/memos';
  static const String readingHistory = '/history';
  static const String readingPlan = '/plan';

  // ── Auth ──────────────────────────────────────────────────────────
  static const String login = '/auth/login';
  static const String register = '/auth/register';

  // ── Helpers ───────────────────────────────────────────────────────

  /// /bible/:bookId/:chapter 에 파라미터 채우기
  static String bibleChapterPath(int bookId, int chapter) =>
      '/bible/$bookId/$chapter';

  static String wordDetailPath(String word) => '/word/$word';

  static String vocabularyDetailPath(int id) => '/vocabulary/$id';
}

abstract final class RouteNames {
  RouteNames._();

  static const String bibleShell = 'bible-shell';
  static const String bible = 'bible';
  static const String bookSelector = 'book-selector';
  static const String bibleChapter = 'bible-chapter';
  static const String parallelView = 'parallel-view';
  static const String vocabulary = 'vocabulary';
  static const String vocabularyReview = 'vocabulary-review';
  static const String vocabularyDetail = 'vocabulary-detail';
  static const String search = 'search';
  static const String searchResults = 'search-results';
  static const String settings = 'settings';
  static const String wordDetail = 'word-detail';
  static const String bookmarkList = 'bookmark-list';
  static const String memoList = 'memo-list';
  static const String readingHistory = 'reading-history';
  static const String readingPlan = 'reading-plan';
  static const String login = 'login';
  static const String register = 'register';
}
