// lib/features/bible/domain/entities/chapter_content.dart
// [NEW] 장(Chapter) 컨텐츠 도메인 엔티티 — 성경 읽기 화면의 핵심 데이터

import 'book.dart';
import 'verse.dart';

/// 한 장(chapter)의 전체 내용.
/// 대역 보기(parallel view) 지원을 위해 [parallelVerses] 포함.
final class ChapterContent {
  const ChapterContent({
    required this.book,
    required this.chapterNumber,
    required this.verses,
    required this.translationCode,
    this.parallelVerses,
    this.parallelTranslationCode,
  });

  final Book book;
  final int chapterNumber;

  /// 주 번역본 절 목록 (정렬됨).
  final List<Verse> verses;

  /// 주 번역본 코드 ('KJV' | 'KOREAN_RV').
  final String translationCode;

  /// 대역 번역본 절 목록 (대역 보기 활성 시).
  final List<Verse>? parallelVerses;

  /// 대역 번역본 코드.
  final String? parallelTranslationCode;

  bool get hasParallelVerses =>
      parallelVerses != null && parallelVerses!.isNotEmpty;

  bool get isEmpty => verses.isEmpty;

  int get verseCount => verses.length;

  /// 특정 절 번호로 verse 조회.
  Verse? verseAt(int verseNumber) {
    try {
      return verses.firstWhere((v) => v.verseNumber == verseNumber);
    } catch (_) {
      return null;
    }
  }

  /// 대역 verse 조회.
  Verse? parallelVerseAt(int verseNumber) {
    if (parallelVerses == null) return null;
    try {
      return parallelVerses!.firstWhere((v) => v.verseNumber == verseNumber);
    } catch (_) {
      return null;
    }
  }

  /// 이전 장 존재 여부.
  bool get hasPreviousChapter => chapterNumber > 1;

  /// 다음 장 존재 여부.
  bool get hasNextChapter => chapterNumber < book.chapterCount;

  ChapterContent copyWith({
    Book? book,
    int? chapterNumber,
    List<Verse>? verses,
    String? translationCode,
    List<Verse>? parallelVerses,
    String? parallelTranslationCode,
  }) =>
      ChapterContent(
        book: book ?? this.book,
        chapterNumber: chapterNumber ?? this.chapterNumber,
        verses: verses ?? this.verses,
        translationCode: translationCode ?? this.translationCode,
        parallelVerses: parallelVerses ?? this.parallelVerses,
        parallelTranslationCode:
            parallelTranslationCode ?? this.parallelTranslationCode,
      );

  @override
  String toString() =>
      'ChapterContent($translationCode ${book.name} $chapterNumber, ${verses.length} verses)';
}
