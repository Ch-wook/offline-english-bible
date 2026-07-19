import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:offline_english_bible/core/utils/result.dart';
import 'package:offline_english_bible/features/bible/domain/entities/verse.dart';
import 'package:offline_english_bible/features/bible/domain/repositories/bible_repository.dart';
import 'package:offline_english_bible/features/search/presentation/providers/search_providers.dart';

class _MockBibleRepository extends Mock implements BibleRepository {}

void main() {
  late _MockBibleRepository repository;
  late SearchNotifier notifier;

  setUp(() {
    repository = _MockBibleRepository();
    notifier = SearchNotifier(repository);
  });

  tearDown(() => notifier.dispose());

  test('SearchState copyWith preserves and explicitly clears filters', () {
    const state = SearchState(bookId: 43, testament: 'NT');

    expect(state.copyWith(query: 'grace').bookId, 43);
    expect(state.copyWith(query: 'grace').testament, 'NT');
    expect(state.copyWith(bookId: null).bookId, isNull);
    expect(state.copyWith(testament: null).testament, isNull);
  });

  test('an older async response cannot overwrite the latest search', () async {
    final older = Completer<BibleResult<List<Verse>>>();
    final latest = Completer<BibleResult<List<Verse>>>();
    when(
      () => repository.searchVerses(
        query: 'co',
        translationCode: 'KJV',
        bookId: any(named: 'bookId'),
        testament: any(named: 'testament'),
        limit: any(named: 'limit'),
      ),
    ).thenAnswer((_) => older.future);
    when(
      () => repository.searchVerses(
        query: 'covenantbreakers',
        translationCode: 'KJV',
        bookId: any(named: 'bookId'),
        testament: any(named: 'testament'),
        limit: any(named: 'limit'),
      ),
    ).thenAnswer((_) => latest.future);

    final olderSearch = notifier.search('co');
    final latestSearch = notifier.search('covenantbreakers');
    latest.complete(
      const Success([
        Verse(
          bookId: 45,
          chapter: 1,
          verseNumber: 31,
          text: 'Without understanding, covenantbreakers.',
        ),
      ]),
    );
    await latestSearch;

    older.complete(const Success([]));
    await olderSearch;

    expect(notifier.state.query, 'covenantbreakers');
    expect(notifier.state.results, hasLength(1));
    expect(
      notifier.state.results.single.highlightedText,
      contains('**covenantbreakers**'),
    );
  });

  test('testament selection reaches the repository and toggles off', () async {
    when(
      () => repository.searchVerses(
        query: 'grace',
        translationCode: 'KJV',
        bookId: any(named: 'bookId'),
        testament: 'NT',
        limit: any(named: 'limit'),
      ),
    ).thenAnswer((_) async => const Success([]));

    notifier.setTestamentFilter('NT');
    expect(notifier.state.testament, 'NT');
    await notifier.search('grace');

    verify(
      () => repository.searchVerses(
        query: 'grace',
        translationCode: 'KJV',
        bookId: any(named: 'bookId'),
        testament: 'NT',
        limit: any(named: 'limit'),
      ),
    ).called(1);

    notifier.clear();
    notifier.setTestamentFilter('NT');
    expect(notifier.state.testament, isNull);
  });

  test('clearing invalidates an in-flight result', () async {
    final pending = Completer<BibleResult<List<Verse>>>();
    when(
      () => repository.searchVerses(
        query: 'beginning',
        translationCode: 'KJV',
        bookId: any(named: 'bookId'),
        testament: any(named: 'testament'),
        limit: any(named: 'limit'),
      ),
    ).thenAnswer((_) => pending.future);

    final search = notifier.search('beginning');
    notifier.clear();
    pending.complete(
      const Success([
        Verse(bookId: 1, chapter: 1, verseNumber: 1, text: 'In the beginning.'),
      ]),
    );
    await search;

    expect(notifier.state.query, isEmpty);
    expect(notifier.state.results, isEmpty);
    expect(notifier.state.hasSearched, isFalse);
  });
}
