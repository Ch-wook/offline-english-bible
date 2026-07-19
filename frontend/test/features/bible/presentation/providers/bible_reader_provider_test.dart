// test/features/bible/presentation/providers/bible_reader_provider_test.dart
// [NEW] BibleReaderProvider 유닛 테스트

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:offline_english_bible/features/bible/domain/entities/verse.dart';
import 'package:offline_english_bible/features/bible/presentation/providers/bible_providers.dart';
import 'package:offline_english_bible/features/bible/presentation/providers/bible_reader_provider.dart';

import '../../../../helpers/provider_container_helper.dart';

void main() {
  ProviderContainer createContainer() => createTestContainer();

  group('BibleReaderState', () {
    test('default state is Genesis 1 KJV', () async {
      final container = createContainer();
      addTearDown(container.dispose);

      final state = container.read(bibleReaderProvider);
      expect(state.bookId, 1);
      expect(state.chapter, 1);
      expect(state.translationCode, 'KJV');
      expect(state.isParallelView, isFalse);
      expect(state.autoScrollEnabled, isFalse);
    });

    test('toChapterParams returns correct params', () {
      const state = BibleReaderState(bookId: 43, chapter: 3);
      final params = state.toChapterParams();
      expect(params.bookId, 43);
      expect(params.chapter, 3);
      expect(params.translationCode, 'KJV');
      expect(params.parallelTranslationCode, isNull);
    });

    test('toChapterParams includes parallel when isParallelView', () {
      const state = BibleReaderState(isParallelView: true);
      final params = state.toChapterParams();
      expect(params.parallelTranslationCode, 'KOREAN_RV');
    });

    test('equality', () {
      const a = BibleReaderState();
      const b = BibleReaderState();
      const c = BibleReaderState(chapter: 2);
      expect(a, equals(b));
      expect(a, isNot(equals(c)));
    });
  });

  group('BibleReaderNotifier', () {
    test('navigateTo updates bookId and chapter', () async {
      final container = createContainer();
      addTearDown(container.dispose);

      container
          .read(bibleReaderProvider.notifier)
          .navigateTo(bookId: 43, chapter: 3);

      final state = container.read(bibleReaderProvider);
      expect(state.bookId, 43);
      expect(state.chapter, 3);
    });

    test('navigateTo syncs currentChapterParamsProvider', () async {
      final container = createContainer();
      addTearDown(container.dispose);

      container
          .read(bibleReaderProvider.notifier)
          .navigateTo(bookId: 19, chapter: 23);

      final params = container.read(currentChapterParamsProvider);
      expect(params.bookId, 19);
      expect(params.chapter, 23);
    });

    test('goToNextChapter increments chapter', () {
      final container = createContainer();
      addTearDown(container.dispose);

      container
          .read(bibleReaderProvider.notifier)
          .navigateTo(bookId: 1, chapter: 1);
      container.read(bibleReaderProvider.notifier).goToNextChapter(50);

      expect(container.read(bibleReaderProvider).chapter, 2);
    });

    test('goToNextChapter does not exceed maxChapter', () {
      final container = createContainer();
      addTearDown(container.dispose);

      container
          .read(bibleReaderProvider.notifier)
          .navigateTo(bookId: 1, chapter: 50);
      container.read(bibleReaderProvider.notifier).goToNextChapter(50);

      expect(container.read(bibleReaderProvider).chapter, 50);
    });

    test('goToPreviousChapter decrements chapter', () {
      final container = createContainer();
      addTearDown(container.dispose);

      container
          .read(bibleReaderProvider.notifier)
          .navigateTo(bookId: 1, chapter: 5);
      container.read(bibleReaderProvider.notifier).goToPreviousChapter();

      expect(container.read(bibleReaderProvider).chapter, 4);
    });

    test('goToPreviousChapter stays at 1', () {
      final container = createContainer();
      addTearDown(container.dispose);

      container
          .read(bibleReaderProvider.notifier)
          .navigateTo(bookId: 1, chapter: 1);
      container.read(bibleReaderProvider.notifier).goToPreviousChapter();

      expect(container.read(bibleReaderProvider).chapter, 1);
    });

    test('toggleParallelView flips isParallelView', () {
      final container = createContainer();
      addTearDown(container.dispose);

      final notifier = container.read(bibleReaderProvider.notifier);
      expect(container.read(bibleReaderProvider).isParallelView, isFalse);

      notifier.toggleParallelView();
      expect(container.read(bibleReaderProvider).isParallelView, isTrue);

      notifier.toggleParallelView();
      expect(container.read(bibleReaderProvider).isParallelView, isFalse);
    });

    test('onWordTap sets tappedWord after cleaning', () {
      final container = createContainer();
      addTearDown(container.dispose);

      container.read(bibleReaderProvider.notifier).onWordTap('Grace,');
      // 구두점 제거 후 소문자화
      expect(container.read(bibleReaderProvider).tappedWord, 'grace');
    });

    test('onWordTap ignores empty words', () {
      final container = createContainer();
      addTearDown(container.dispose);

      container.read(bibleReaderProvider.notifier).onWordTap('   ');
      expect(container.read(bibleReaderProvider).tappedWord, isNull);
    });

    test('onWordTap preserves the tapped verse source', () {
      final container = createContainer();
      addTearDown(container.dispose);

      container
          .read(bibleReaderProvider.notifier)
          .onWordTap(
            'Grace,',
            source: const Verse(
              bookId: 43,
              chapter: 1,
              verseNumber: 14,
              text: 'full of grace and truth',
            ),
          );

      final state = container.read(bibleReaderProvider);
      expect(state.tappedBookId, 43);
      expect(state.tappedChapter, 1);
      expect(state.tappedVerse, 14);
      expect(state.tappedTranslationCode, 'KJV');
    });

    test('clearWordTap resets tappedWord to null', () {
      final container = createContainer();
      addTearDown(container.dispose);

      final notifier = container.read(bibleReaderProvider.notifier);
      notifier.onWordTap('grace');
      expect(container.read(bibleReaderProvider).tappedWord, 'grace');

      notifier.clearWordTap();
      expect(container.read(bibleReaderProvider).tappedWord, isNull);
    });

    test('selectVerse starts a multi-verse selection', () {
      final container = createContainer();
      addTearDown(container.dispose);

      container.read(bibleReaderProvider.notifier).selectVerse(16);
      expect(container.read(bibleReaderProvider).selectedVerseNumbers, {16});
    });

    test('toggleVerseSelection adds and removes verses', () {
      final container = createContainer();
      addTearDown(container.dispose);

      final notifier = container.read(bibleReaderProvider.notifier);
      notifier.selectVerse(5);
      notifier.toggleVerseSelection(7);
      expect(container.read(bibleReaderProvider).selectedVerseNumbers, {5, 7});
      notifier.toggleVerseSelection(5);
      expect(container.read(bibleReaderProvider).selectedVerseNumbers, {7});
    });

    test('clearVerseSelection resets to an empty set', () {
      final container = createContainer();
      addTearDown(container.dispose);

      final notifier = container.read(bibleReaderProvider.notifier);
      notifier.selectVerse(5);
      notifier.clearVerseSelection();
      expect(container.read(bibleReaderProvider).selectedVerseNumbers, isEmpty);
    });

    test('toggleAutoScroll flips autoScrollEnabled', () {
      final container = createContainer();
      addTearDown(container.dispose);

      final notifier = container.read(bibleReaderProvider.notifier);
      expect(container.read(bibleReaderProvider).autoScrollEnabled, isFalse);

      notifier.toggleAutoScroll();
      expect(container.read(bibleReaderProvider).autoScrollEnabled, isTrue);

      notifier.toggleAutoScroll();
      expect(container.read(bibleReaderProvider).autoScrollEnabled, isFalse);
    });

    test('navigateTo clears selection, tapped word, and reading position', () {
      final container = createContainer();
      addTearDown(container.dispose);

      final notifier = container.read(bibleReaderProvider.notifier);
      notifier.selectVerse(3);
      notifier.onWordTap('light');
      notifier.updateReadingPosition(verse: 12, fraction: 0.4, offset: 500);

      notifier.navigateTo(bookId: 2, chapter: 1);

      final state = container.read(bibleReaderProvider);
      expect(state.selectedVerseNumbers, isEmpty);
      expect(state.tappedWord, isNull);
      expect(state.scrollVerse, 1);
      expect(state.scrollFraction, 0);
      expect(state.scrollOffset, 0);
    });

    test('parallel view keeps the current reading position', () {
      final container = createContainer();
      addTearDown(container.dispose);

      final notifier = container.read(bibleReaderProvider.notifier);
      notifier.updateReadingPosition(verse: 18, fraction: 0.35, offset: 860);
      notifier.toggleParallelView();

      final state = container.read(bibleReaderProvider);
      expect(state.scrollVerse, 18);
      expect(state.scrollFraction, 0.35);
      expect(state.scrollOffset, 860);
    });
  });
}
