// lib/features/vocabulary/domain/entities/vocab_item.dart
// [NEW] 단어장 엔티티 (SRS 데이터 포함)

/// 사용자의 단어장 항목.
/// SM-2 알고리즘 기반 Spaced Repetition System (SRS) 데이터 포함.
final class VocabItem {
  const VocabItem({
    required this.id,
    required this.word,
    required this.bookId,
    required this.chapter,
    required this.verse,
    required this.translationCode,
    required this.addedAt,
    this.definition = '',
    this.note = '',
    this.repetitions = 0,
    this.easeFactor = 2.5,
    this.intervalDays = 1,
    this.nextReviewAt,
    this.lastReviewedAt,
    this.isLearned = false,
  });

  final int id;
  final String word;

  /// 단어를 추가한 절 위치.
  final int bookId;
  final int chapter;
  final int verse;
  final String translationCode;

  final DateTime addedAt;

  /// 사용자 메모 또는 정의 캐시.
  final String definition;
  final String note;

  // ── SM-2 SRS 필드 ─────────────────────────────────────────────

  /// 연속 정답 횟수.
  final int repetitions;

  /// 난이도 계수 (초기값 2.5, 범위: 1.3 ~ 2.5).
  final double easeFactor;

  /// 다음 복습까지의 간격(일).
  final int intervalDays;

  /// 다음 복습 예정 시간.
  final DateTime? nextReviewAt;

  /// 마지막 복습 시간.
  final DateTime? lastReviewedAt;

  /// 완전히 학습된 (5번 이상 정답, interval >= 21일).
  final bool isLearned;

  bool get isDueForReview {
    if (nextReviewAt == null) return true;
    return DateTime.now().isAfter(nextReviewAt!);
  }

  /// SM-2 알고리즘으로 다음 복습 간격 계산.
  /// [quality]: 0~5 (0=완전 망각, 5=완벽 정답)
  VocabItem updateWithQuality(int quality) {
    assert(quality >= 0 && quality <= 5);

    if (quality < 3) {
      // 틀린 경우 → 처음부터 다시
      return copyWith(
        repetitions: 0,
        intervalDays: 1,
        nextReviewAt: DateTime.now().add(const Duration(hours: 4)),
      );
    }

    // 정답인 경우
    final newRepetitions = repetitions + 1;
    final newEaseFactor = (easeFactor +
            0.1 -
            (5 - quality) * (0.08 + (5 - quality) * 0.02))
        .clamp(1.3, 2.5);

    final int newInterval;
    if (newRepetitions == 1) {
      newInterval = 1;
    } else if (newRepetitions == 2) {
      newInterval = 6;
    } else {
      newInterval = (intervalDays * newEaseFactor).round();
    }

    final isLearned = newRepetitions >= 5 && newInterval >= 21;

    return copyWith(
      repetitions: newRepetitions,
      easeFactor: newEaseFactor,
      intervalDays: newInterval,
      nextReviewAt:
          DateTime.now().add(Duration(days: newInterval)),
      lastReviewedAt: DateTime.now(),
      isLearned: isLearned,
    );
  }

  VocabItem copyWith({
    int? id,
    String? word,
    int? bookId,
    int? chapter,
    int? verse,
    String? translationCode,
    DateTime? addedAt,
    String? definition,
    String? note,
    int? repetitions,
    double? easeFactor,
    int? intervalDays,
    DateTime? nextReviewAt,
    DateTime? lastReviewedAt,
    bool? isLearned,
  }) =>
      VocabItem(
        id: id ?? this.id,
        word: word ?? this.word,
        bookId: bookId ?? this.bookId,
        chapter: chapter ?? this.chapter,
        verse: verse ?? this.verse,
        translationCode: translationCode ?? this.translationCode,
        addedAt: addedAt ?? this.addedAt,
        definition: definition ?? this.definition,
        note: note ?? this.note,
        repetitions: repetitions ?? this.repetitions,
        easeFactor: easeFactor ?? this.easeFactor,
        intervalDays: intervalDays ?? this.intervalDays,
        nextReviewAt: nextReviewAt ?? this.nextReviewAt,
        lastReviewedAt: lastReviewedAt ?? this.lastReviewedAt,
        isLearned: isLearned ?? this.isLearned,
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is VocabItem && id == other.id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() =>
      'VocabItem($word, rep=$repetitions, interval=${intervalDays}d)';
}
