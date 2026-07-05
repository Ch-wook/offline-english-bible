// lib/features/highlights/domain/entities/highlight.dart
// [NEW] 형광펜/북마크 도메인 엔티티

/// 절 형광펜 마킹.
final class VerseHighlight {
  const VerseHighlight({
    required this.id,
    required this.bookId,
    required this.chapter,
    required this.verse,
    required this.translationCode,
    required this.color,
    required this.createdAt,
    this.note = '',
  });

  final int id;
  final int bookId;
  final int chapter;
  final int verse;
  final String translationCode;

  /// 색상 코드 (e.g. '#FFEB3B', 'yellow', 'green', 'blue', 'pink').
  final String color;

  final DateTime createdAt;
  final String note;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is VerseHighlight && id == other.id;

  @override
  int get hashCode => id.hashCode;
}

/// 절 북마크.
final class VerseBookmark {
  const VerseBookmark({
    required this.id,
    required this.bookId,
    required this.chapter,
    required this.verse,
    required this.translationCode,
    required this.createdAt,
    this.note = '',
    this.tag = '',
  });

  final int id;
  final int bookId;
  final int chapter;
  final int verse;
  final String translationCode;
  final DateTime createdAt;
  final String note;
  final String tag;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is VerseBookmark && id == other.id;

  @override
  int get hashCode => id.hashCode;
}

/// 사용 가능한 형광펜 색상.
final class HighlightColor {
  const HighlightColor({
    required this.code,
    required this.label,
    required this.hexValue,
  });

  final String code;
  final String label;
  final String hexValue;

  static const List<HighlightColor> presets = [
    HighlightColor(code: 'yellow', label: '노랑', hexValue: '#FFEB3B'),
    HighlightColor(code: 'green', label: '초록', hexValue: '#A5D6A7'),
    HighlightColor(code: 'blue', label: '파랑', hexValue: '#90CAF9'),
    HighlightColor(code: 'pink', label: '분홍', hexValue: '#F48FB1'),
    HighlightColor(code: 'orange', label: '주황', hexValue: '#FFCC80'),
    HighlightColor(code: 'purple', label: '보라', hexValue: '#CE93D8'),
  ];

  static HighlightColor? fromCode(String code) {
    try {
      return presets.firstWhere((c) => c.code == code);
    } catch (_) {
      return null;
    }
  }
}
