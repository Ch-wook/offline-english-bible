// lib/features/bible/domain/entities/book.dart
// [NEW] 성경 책 도메인 엔티티

/// 성경 66권 중 하나를 나타내는 불변 도메인 엔티티.
final class Book {
  const Book({
    required this.id,
    required this.name,
    required this.nameKorean,
    required this.abbreviation,
    required this.abbreviationKorean,
    required this.testament,
    required this.orderIndex,
    required this.chapterCount,
  });

  /// 성경 순서 ID (1 = Genesis … 66 = Revelation).
  final int id;

  /// 영어 이름 (e.g., 'Genesis').
  final String name;

  /// 한국어 이름 (e.g., '창세기').
  final String nameKorean;

  /// 영어 약어 (e.g., 'Gen').
  final String abbreviation;

  /// 한국어 약어 (e.g., '창').
  final String abbreviationKorean;

  /// 'OT' (구약) | 'NT' (신약).
  final String testament;

  /// 성경 순서 (1-based).
  final int orderIndex;

  /// 장(chapter) 수.
  final int chapterCount;

  bool get isOldTestament => testament == 'OT';
  bool get isNewTestament => testament == 'NT';

  /// 지역화 이름 반환.
  String localizedName(String languageCode) =>
      languageCode == 'ko' ? nameKorean : name;

  /// 지역화 약어 반환.
  String localizedAbbreviation(String languageCode) =>
      languageCode == 'ko' ? abbreviationKorean : abbreviation;

  Book copyWith({
    int? id,
    String? name,
    String? nameKorean,
    String? abbreviation,
    String? abbreviationKorean,
    String? testament,
    int? orderIndex,
    int? chapterCount,
  }) =>
      Book(
        id: id ?? this.id,
        name: name ?? this.name,
        nameKorean: nameKorean ?? this.nameKorean,
        abbreviation: abbreviation ?? this.abbreviation,
        abbreviationKorean:
            abbreviationKorean ?? this.abbreviationKorean,
        testament: testament ?? this.testament,
        orderIndex: orderIndex ?? this.orderIndex,
        chapterCount: chapterCount ?? this.chapterCount,
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is Book && id == other.id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() => 'Book($id: $name / $nameKorean, $testament)';
}
