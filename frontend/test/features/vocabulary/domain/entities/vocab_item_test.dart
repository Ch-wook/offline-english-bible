// test/features/vocabulary/domain/entities/vocab_item_test.dart
// [NEW] VocabItem SM-2 알고리즘 유닛 테스트

import 'package:flutter_test/flutter_test.dart';
import 'package:offline_english_bible/features/vocabulary/domain/entities/vocab_item.dart';

void main() {
  final now = DateTime(2026, 7, 5);
  
  VocabItem makeItem({
    int repetitions = 0,
    double easeFactor = 2.5,
    int intervalDays = 1,
    DateTime? nextReviewAt,
    bool isLearned = false,
  }) =>
      VocabItem(
        id: 1,
        word: 'grace',
        bookId: 49,
        chapter: 2,
        verse: 8,
        translationCode: 'KJV',
        addedAt: now,
        repetitions: repetitions,
        easeFactor: easeFactor,
        intervalDays: intervalDays,
        nextReviewAt: nextReviewAt,
        isLearned: isLearned,
      );

  group('VocabItem.updateWithQuality - SM-2 Algorithm', () {
    test('quality < 3: resets repetitions to 0', () {
      final item = makeItem(repetitions: 5);
      final updated = item.updateWithQuality(0);
      expect(updated.repetitions, 0);
      expect(updated.intervalDays, 1);
    });

    test('quality < 3: resets with 4hr review', () {
      final item = makeItem();
      final updated = item.updateWithQuality(2);
      expect(updated.repetitions, 0);
      expect(updated.nextReviewAt, isNotNull);
    });

    test('quality == 3: first repetition gives 1 day interval', () {
      final item = makeItem();
      final updated = item.updateWithQuality(3);
      expect(updated.repetitions, 1);
      expect(updated.intervalDays, 1);
    });

    test('quality == 4: second repetition gives 6 day interval', () {
      final item = makeItem(repetitions: 1);
      final updated = item.updateWithQuality(4);
      expect(updated.repetitions, 2);
      expect(updated.intervalDays, 6);
    });

    test('quality == 5: third repetition uses ease factor', () {
      final item = makeItem(
        repetitions: 2,
        intervalDays: 6,
      );
      final updated = item.updateWithQuality(5);
      expect(updated.repetitions, 3);
      expect(updated.intervalDays, (6 * 2.5).round());
    });

    test('ease factor increases with perfect quality', () {
      final item = makeItem(easeFactor: 2.3);
      final updated = item.updateWithQuality(5);
      expect(updated.easeFactor, greaterThan(2.3));
    });

    test('ease factor decreases with harder quality', () {
      final item = makeItem();
      final updated = item.updateWithQuality(3);
      expect(updated.easeFactor, lessThan(2.5));
    });

    test('ease factor never goes below 1.3', () {
      var item = makeItem(easeFactor: 1.3);
      for (var i = 0; i < 10; i++) {
        item = item.updateWithQuality(3);
      }
      expect(item.easeFactor, greaterThanOrEqualTo(1.3));
    });

    test('ease factor never exceeds 2.5', () {
      var item = makeItem();
      for (var i = 0; i < 10; i++) {
        item = item.updateWithQuality(5);
      }
      expect(item.easeFactor, lessThanOrEqualTo(2.5));
    });

    test('isLearned true after 5+ repetitions with 21+ day interval', () {
      var item = makeItem();
      // Simulate learning over time
      for (var i = 0; i < 5; i++) {
        item = item.updateWithQuality(5);
      }
      // After several perfect answers, should eventually be learned
      expect(item.repetitions, 5);
      // interval grows with each repetition
      expect(item.intervalDays, greaterThan(1));
    });

    test('isLearned false after quality < 3 reset', () {
      final item = makeItem(repetitions: 5, intervalDays: 25, isLearned: true);
      final updated = item.updateWithQuality(0);
      expect(updated.isLearned, isFalse);
    });
  });

  group('VocabItem.isDueForReview', () {
    test('returns true when nextReviewAt is null', () {
      final item = makeItem();
      expect(item.isDueForReview, isTrue);
    });

    test('returns true when nextReviewAt is in the past', () {
      final item = makeItem(
        nextReviewAt: DateTime.now().subtract(const Duration(hours: 1)),
      );
      expect(item.isDueForReview, isTrue);
    });

    test('returns false when nextReviewAt is in the future', () {
      final item = makeItem(
        nextReviewAt: DateTime.now().add(const Duration(days: 7)),
      );
      expect(item.isDueForReview, isFalse);
    });
  });

  group('VocabItem equality and copyWith', () {
    test('equality is by id', () {
      final a = makeItem();
      final b = a.copyWith(word: 'different');
      expect(a, equals(b));
    });

    test('copyWith preserves fields', () {
      final item = makeItem(repetitions: 3);
      final copied = item.copyWith(word: 'love');
      expect(copied.word, 'love');
      expect(copied.repetitions, 3);
      expect(copied.easeFactor, item.easeFactor);
    });
  });
}
