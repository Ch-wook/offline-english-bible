// lib/features/highlights/presentation/providers/highlights_providers.dart
// [NEW] 형광펜/북마크 Riverpod Providers

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/database/app_database.dart' show Highlight;
import '../../../../core/di/providers.dart';
import '../../../bible/data/datasources/user_local_datasource_impl.dart';

// ── Data Source ───────────────────────────────────────────────────────

final userDataSourceForHighlightsProvider = Provider((ref) {
  return UserLocalDataSourceImpl(ref.watch(appDatabaseProvider));
});

// ── Bookmarks ─────────────────────────────────────────────────────────

/// 모든 북마크 목록.
final allBookmarksProvider = FutureProvider((ref) async {
  final ds = ref.watch(userDataSourceForHighlightsProvider);
  return ds.getAllBookmarks();
});

/// 특정 절 북마크 여부.
final isVerseBookmarkedProvider = FutureProvider.family<
  bool,
  ({int bookId, int chapter, int verse, String translation})
>((ref, params) async {
  final ds = ref.watch(userDataSourceForHighlightsProvider);
  return ds.isVerseBookmarked(
    bookId: params.bookId,
    chapter: params.chapter,
    verse: params.verse,
    translationCode: params.translation,
  );
});

// ── Highlights ────────────────────────────────────────────────────────

/// 특정 장의 형광펜 목록.
final chapterHighlightsProvider = FutureProvider.family<
  List<Highlight>,
  ({int bookId, int chapter, String translation})
>((ref, params) async {
  final ds = ref.watch(userDataSourceForHighlightsProvider);
  return ds.getChapterHighlights(
    bookId: params.bookId,
    chapter: params.chapter,
    translationCode: params.translation,
  );
});

// ── Action Notifier ───────────────────────────────────────────────────

final class HighlightActionNotifier extends StateNotifier<void> {
  HighlightActionNotifier(this._ref) : super(null);

  final Ref _ref;

  Future<void> addBookmark({
    required int bookId,
    required int chapter,
    required int verse,
    required String translationCode,
    String? note,
  }) async {
    final ds = _ref.read(userDataSourceForHighlightsProvider);
    await ds.addBookmark(
      bookId: bookId,
      chapter: chapter,
      verse: verse,
      translationCode: translationCode,
      note: note,
    );
    _ref.invalidate(allBookmarksProvider);
    _ref.invalidate(isVerseBookmarkedProvider);
  }

  Future<void> removeBookmark(int id) async {
    final ds = _ref.read(userDataSourceForHighlightsProvider);
    await ds.removeBookmark(id);
    _ref.invalidate(allBookmarksProvider);
    _ref.invalidate(isVerseBookmarkedProvider);
  }

  Future<void> addHighlight({
    required int bookId,
    required int chapter,
    required int verse,
    required String translationCode,
    required String color,
  }) async {
    final ds = _ref.read(userDataSourceForHighlightsProvider);
    await ds.addHighlight(
      bookId: bookId,
      chapter: chapter,
      verse: verse,
      translationCode: translationCode,
      color: color,
    );
    _ref.invalidate(chapterHighlightsProvider);
  }

  Future<void> removeHighlight(int id) async {
    final ds = _ref.read(userDataSourceForHighlightsProvider);
    await ds.removeHighlight(id);
    _ref.invalidate(chapterHighlightsProvider);
  }
}

final highlightActionProvider =
    StateNotifierProvider<HighlightActionNotifier, void>((ref) {
      return HighlightActionNotifier(ref);
    });
