// lib/features/bible/domain/entities/verse.dart
// [NEW] 절(Verse) 도메인 엔티티

import 'dart:convert';

/// 성경 한 절(verse)을 나타내는 불변 도메인 엔티티.
final class Verse {
  const Verse({
    required this.bookId,
    required this.chapter,
    required this.verseNumber,
    required this.text,
    this.translationCode = 'KJV',
    this.strongRefs = const [],
  });

  final int bookId;
  final int chapter;
  final int verseNumber;

  /// 해당 번역본의 절 본문.
  final String text;

  /// 번역본 코드 ('KJV' | 'KOREAN_RV').
  final String translationCode;

  /// Strong 번호 목록 (e.g., ['H430', 'H3068']). KJV에서만 유효.
  final List<String> strongRefs;

  bool get hasStrongRefs => strongRefs.isNotEmpty;
  bool get isEnglish => translationCode == 'KJV';
  bool get isKorean => translationCode == 'KOREAN_RV';

  /// 절 참조 형식 (e.g., 'Gen 1:1').
  String get reference => 'Book $bookId $chapter:$verseNumber';

  /// Strong 번호를 JSON 문자열에서 파싱.
  static List<String> parseStrongRefs(String? json) {
    if (json == null || json.isEmpty) return const [];
    try {
      return List<String>.from(jsonDecode(json) as List);
    } catch (_) {
      return const [];
    }
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Verse &&
          bookId == other.bookId &&
          chapter == other.chapter &&
          verseNumber == other.verseNumber &&
          translationCode == other.translationCode;

  @override
  int get hashCode =>
      Object.hash(bookId, chapter, verseNumber, translationCode);

  @override
  String toString() =>
      'Verse($translationCode $bookId:$chapter:$verseNumber)';
}
