final class BibleReadingTab {
  const BibleReadingTab({
    required this.id,
    required this.bookId,
    required this.chapter,
    required this.translationCode,
    required this.isParallelView,
    required this.parallelTranslationCode,
    required this.sortOrder,
    required this.isActive,
    required this.updatedAt,
  });

  final int id;
  final int bookId;
  final int chapter;
  final String translationCode;
  final bool isParallelView;
  final String parallelTranslationCode;
  final int sortOrder;
  final bool isActive;
  final DateTime updatedAt;

  BibleReadingTab copyWith({
    int? id,
    int? bookId,
    int? chapter,
    String? translationCode,
    bool? isParallelView,
    String? parallelTranslationCode,
    int? sortOrder,
    bool? isActive,
    DateTime? updatedAt,
  }) => BibleReadingTab(
    id: id ?? this.id,
    bookId: bookId ?? this.bookId,
    chapter: chapter ?? this.chapter,
    translationCode: translationCode ?? this.translationCode,
    isParallelView: isParallelView ?? this.isParallelView,
    parallelTranslationCode:
        parallelTranslationCode ?? this.parallelTranslationCode,
    sortOrder: sortOrder ?? this.sortOrder,
    isActive: isActive ?? this.isActive,
    updatedAt: updatedAt ?? this.updatedAt,
  );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BibleReadingTab &&
          id == other.id &&
          bookId == other.bookId &&
          chapter == other.chapter &&
          translationCode == other.translationCode &&
          isParallelView == other.isParallelView &&
          parallelTranslationCode == other.parallelTranslationCode &&
          sortOrder == other.sortOrder &&
          isActive == other.isActive;

  @override
  int get hashCode => Object.hash(
    id,
    bookId,
    chapter,
    translationCode,
    isParallelView,
    parallelTranslationCode,
    sortOrder,
    isActive,
  );
}
