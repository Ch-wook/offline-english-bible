import 'package:flutter_test/flutter_test.dart';
import 'package:offline_english_bible/core/database/app_database.dart';
import 'package:offline_english_bible/features/bible/data/datasources/user_local_datasource_impl.dart';

import '../../../../helpers/test_database_helper.dart';

void main() {
  late AppDatabase db;
  late UserLocalDataSourceImpl dataSource;

  setUp(() {
    db = createTestDatabase();
    dataSource = UserLocalDataSourceImpl(db);
  });

  tearDown(() => closeTestDatabase(db));

  test('adding the same bookmark twice remains idempotent', () async {
    await dataSource.addBookmark(
      bookId: 1,
      chapter: 1,
      verse: 1,
      translationCode: 'KJV',
    );
    await dataSource.addBookmark(
      bookId: 1,
      chapter: 1,
      verse: 1,
      translationCode: 'KJV',
      note: 'created',
    );

    final bookmarks = await dataSource.getAllBookmarks();
    expect(bookmarks, hasLength(1));
    expect(bookmarks.single.note, 'created');
  });

  test('changing a verse highlight replaces the previous color', () async {
    await dataSource.addHighlight(
      bookId: 1,
      chapter: 1,
      verse: 1,
      translationCode: 'KJV',
      color: 'yellow',
    );
    await dataSource.addHighlight(
      bookId: 1,
      chapter: 1,
      verse: 1,
      translationCode: 'KJV',
      color: 'blue',
    );

    final highlights = await dataSource.getChapterHighlights(
      bookId: 1,
      chapter: 1,
      translationCode: 'KJV',
    );
    expect(highlights, hasLength(1));
    expect(highlights.single.color, 'blue');
  });
}
