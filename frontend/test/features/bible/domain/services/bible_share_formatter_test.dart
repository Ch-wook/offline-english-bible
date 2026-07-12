import 'package:flutter_test/flutter_test.dart';
import 'package:offline_english_bible/features/bible/domain/entities/book.dart';
import 'package:offline_english_bible/features/bible/domain/entities/chapter_content.dart';
import 'package:offline_english_bible/features/bible/domain/entities/verse.dart';
import 'package:offline_english_bible/features/bible/domain/services/bible_share_formatter.dart';

void main() {
  const book = Book(
    id: 1,
    name: 'Genesis',
    nameKorean: '창세기',
    abbreviation: 'Gen',
    abbreviationKorean: '창',
    testament: 'OT',
    orderIndex: 1,
    chapterCount: 50,
  );
  const verse = Verse(
    bookId: 1,
    chapter: 1,
    verseNumber: 1,
    text: 'In the beginning God created the heaven and the earth.',
  );

  test('formats a selected verse with reference and translation', () {
    expect(
      BibleShareFormatter.verse(bookName: book.nameKorean, verse: verse),
      '창세기 1:1 (KJV)\n\n'
      'In the beginning God created the heaven and the earth.',
    );
  });

  test('formats a chapter with numbered verses', () {
    const content = ChapterContent(
      book: book,
      chapterNumber: 1,
      verses: [
        verse,
        Verse(
          bookId: 1,
          chapter: 1,
          verseNumber: 2,
          text: 'And the earth was without form, and void.',
        ),
      ],
      translationCode: 'KJV',
    );

    final text = BibleShareFormatter.chapter(content);
    expect(text, startsWith('창세기 1장 (KJV)'));
    expect(text, contains('1 In the beginning'));
    expect(text, contains('2 And the earth'));
  });
}
