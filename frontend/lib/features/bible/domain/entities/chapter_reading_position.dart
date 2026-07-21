final class ChapterReadingPosition {
  const ChapterReadingPosition({
    required this.readingTabId,
    required this.bookId,
    required this.chapter,
    required this.scrollVerse,
    required this.scrollFraction,
    required this.scrollOffset,
    required this.updatedAt,
  });

  final int readingTabId;
  final int bookId;
  final int chapter;
  final int scrollVerse;
  final double scrollFraction;
  final double scrollOffset;
  final DateTime updatedAt;
}
