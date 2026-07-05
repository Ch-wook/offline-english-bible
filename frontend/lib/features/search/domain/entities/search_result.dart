// lib/features/search/domain/entities/search_result.dart
// [NEW] 전문 검색 결과 엔티티

import '../../bible/domain/entities/verse.dart';

/// 성경 전문 검색(FTS5) 결과.
final class SearchResult {
  const SearchResult({
    required this.verse,
    required this.bookName,
    required this.bookNameKorean,
    required this.highlightedText,
    this.score = 0.0,
  });

  final Verse verse;
  final String bookName;
  final String bookNameKorean;

  /// 검색어가 bold 마크업된 텍스트.
  final String highlightedText;

  /// 검색 관련도 점수 (FTS5 rank).
  final double score;

  String get reference =>
      '$bookNameKorean ${verse.chapter}:${verse.verseNumber}';

  @override
  String toString() =>
      'SearchResult(${verse.translationCode} $reference)';
}

/// 검색 파라미터.
final class SearchParams {
  const SearchParams({
    required this.query,
    required this.translationCode,
    this.bookId,
    this.testament,
    this.limit = 50,
  });

  final String query;
  final String translationCode;

  /// 특정 책으로 제한 (null = 전체).
  final int? bookId;

  /// 'OT' | 'NT' (null = 전체).
  final String? testament;

  final int limit;

  bool get hasBookFilter => bookId != null;
  bool get hasTestamentFilter => testament != null;

  SearchParams copyWith({
    String? query,
    String? translationCode,
    int? bookId,
    String? testament,
    int? limit,
  }) =>
      SearchParams(
        query: query ?? this.query,
        translationCode: translationCode ?? this.translationCode,
        bookId: bookId ?? this.bookId,
        testament: testament ?? this.testament,
        limit: limit ?? this.limit,
      );
}
