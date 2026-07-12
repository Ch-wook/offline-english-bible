import 'package:flutter_test/flutter_test.dart';
import 'package:offline_english_bible/core/database/app_database.dart';
import 'package:offline_english_bible/features/vocabulary/data/datasources/vocabulary_local_datasource_impl.dart';
import 'package:offline_english_bible/features/vocabulary/data/repositories/vocabulary_repository_impl.dart';

import '../../../../helpers/test_database_helper.dart';

void main() {
  late AppDatabase db;
  late VocabularyRepositoryImpl repository;

  setUp(() {
    db = createTestDatabase();
    repository = VocabularyRepositoryImpl(VocabularyLocalDataSourceImpl(db));
  });

  tearDown(() => closeTestDatabase(db));

  test('saves complete dictionary metadata and source reference', () async {
    final result = await repository.addVocabItem(
      word: 'Grace',
      bookId: 43,
      chapter: 1,
      verse: 14,
      translationCode: 'KJV',
      definition: '은혜, 은총',
      partOfSpeech: 'noun',
      ipa: '/ɡreɪs/',
      bibleDefinition: 'God’s unmerited favor',
    );

    expect(result.valueOrNull, isNotNull);
    final row = await db.select(db.vocabularyItems).getSingle();
    expect(row.wordNormalized, 'grace');
    expect(row.partOfSpeech, 'noun');
    expect(row.definition, '은혜, 은총');
    expect(row.ipa, '/ɡreɪs/');
    expect(row.bookId, 43);
    expect(row.verse, 14);
  });

  test('saving the same word twice returns the existing item', () async {
    final first = await repository.addVocabItem(
      word: 'grace',
      bookId: 43,
      chapter: 1,
      verse: 14,
      translationCode: 'KJV',
    );
    final second = await repository.addVocabItem(
      word: 'Grace',
      bookId: 45,
      chapter: 3,
      verse: 24,
      translationCode: 'KJV',
    );

    expect(second.valueOrNull, first.valueOrNull);
    expect(await db.select(db.vocabularyItems).get(), hasLength(1));
  });
}
