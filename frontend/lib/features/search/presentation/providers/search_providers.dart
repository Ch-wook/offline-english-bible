// lib/features/search/presentation/providers/search_providers.dart
// [NEW] 검색 Riverpod Providers

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/database/seed_data/bible_books_seed.dart';
import '../../../bible/domain/repositories/bible_repository.dart';
import '../../../bible/presentation/providers/bible_providers.dart';
import '../../../bible/presentation/providers/bible_reader_provider.dart';
import '../../domain/entities/search_result.dart';

// ── Search State ──────────────────────────────────────────────────────

final class SearchState {
  const SearchState({
    this.query = '',
    this.translationCode = 'KJV',
    this.bookId,
    this.testament,
    this.results = const [],
    this.isSearching = false,
    this.hasSearched = false,
  });

  final String query;
  final String translationCode;
  final int? bookId;
  final String? testament;
  final List<SearchResult> results;
  final bool isSearching;
  final bool hasSearched;

  bool get hasResults => results.isNotEmpty;
  bool get isEmpty => hasSearched && !isSearching && results.isEmpty;

  static const Object _unset = Object();

  SearchState copyWith({
    String? query,
    String? translationCode,
    Object? bookId = _unset,
    Object? testament = _unset,
    List<SearchResult>? results,
    bool? isSearching,
    bool? hasSearched,
  }) => SearchState(
    query: query ?? this.query,
    translationCode: translationCode ?? this.translationCode,
    bookId: identical(bookId, _unset) ? this.bookId : bookId as int?,
    testament:
        identical(testament, _unset) ? this.testament : testament as String?,
    results: results ?? this.results,
    isSearching: isSearching ?? this.isSearching,
    hasSearched: hasSearched ?? this.hasSearched,
  );
}

// ── Notifier ──────────────────────────────────────────────────────────

class SearchNotifier extends StateNotifier<SearchState> {
  SearchNotifier(this._repository) : super(const SearchState());

  final BibleRepository _repository;
  int _latestRequestId = 0;

  Future<void> search(String query, {String? translationCode}) async {
    final normalizedQuery = query.trim();
    if (normalizedQuery.isEmpty) {
      clear();
      return;
    }

    final requestId = ++_latestRequestId;
    final targetTranslation = translationCode ?? state.translationCode;
    final targetBookId = state.bookId;
    final targetTestament = state.testament;
    state = state.copyWith(
      query: normalizedQuery,
      translationCode: targetTranslation,
      isSearching: true,
      hasSearched: true,
    );

    final result = await _repository.searchVerses(
      query: normalizedQuery,
      translationCode: targetTranslation,
      bookId: targetBookId,
      testament: targetTestament,
    );
    if (requestId != _latestRequestId) return;

    result.when(
      success: (verses) {
        final searchResults =
            verses.map((v) {
              final bookInfo = bookNameMap[v.bookId];
              final highlighted = _highlightQuery(v.text, normalizedQuery);
              return SearchResult(
                verse: v,
                bookName: bookInfo?.en ?? '',
                bookNameKorean: bookInfo?.ko ?? '',
                highlightedText: highlighted,
              );
            }).toList();

        state = state.copyWith(results: searchResults, isSearching: false);
      },
      failure: (_) {
        state = state.copyWith(results: [], isSearching: false);
      },
    );
  }

  void setTranslation(String code) {
    state = state.copyWith(translationCode: code);
    if (state.query.isNotEmpty) {
      search(state.query, translationCode: code);
    }
  }

  void setBookFilter(int? bookId) {
    state = state.copyWith(bookId: bookId, testament: null);
    if (state.query.isNotEmpty) search(state.query);
  }

  void setTestamentFilter(String testament) {
    final next = state.testament == testament ? null : testament;
    state = state.copyWith(bookId: null, testament: next);
    if (state.query.isNotEmpty) search(state.query);
  }

  void clearFilters() {
    state = state.copyWith(bookId: null, testament: null);
    if (state.query.isNotEmpty) search(state.query);
  }

  void clear() {
    _latestRequestId++;
    state = state.copyWith(
      query: '',
      results: const [],
      isSearching: false,
      hasSearched: false,
    );
  }

  /// 검색어를 **굵게** 마크업 (간단한 case-insensitive replace).
  String _highlightQuery(String text, String query) {
    final escaped = query.toLowerCase().replaceAll(
      RegExp(r'[.*+?^${}()|[\]\\]'),
      r'\$&',
    );
    return text.replaceAllMapped(
      RegExp(escaped, caseSensitive: false),
      (m) => '**${m.group(0)}**',
    );
  }
}

// ── Providers ─────────────────────────────────────────────────────────

final searchNotifierProvider =
    StateNotifierProvider<SearchNotifier, SearchState>((ref) {
      return SearchNotifier(ref.watch(bibleRepositoryProvider));
    });

/// 현재 성경 읽기 위치에서 검색으로 이동.
final navigateToVerseProvider = Provider<void Function(SearchResult)>((ref) {
  return (result) {
    ref
        .read(bibleReaderProvider.notifier)
        .navigateTo(
          bookId: result.verse.bookId,
          chapter: result.verse.chapter,
          verse: result.verse.verseNumber,
        );
  };
});
