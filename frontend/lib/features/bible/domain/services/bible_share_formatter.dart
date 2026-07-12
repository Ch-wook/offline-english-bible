import '../entities/chapter_content.dart';
import '../entities/verse.dart';

abstract final class BibleShareFormatter {
  static String chapter(ChapterContent content) {
    final reference = '${content.book.nameKorean} ${content.chapterNumber}장';
    final verses = content.verses
        .map((verse) => '${verse.verseNumber} ${verse.text}')
        .join('\n');
    return '$reference (${content.translationCode})\n\n$verses';
  }

  static String verse({required String bookName, required Verse verse}) {
    return '$bookName ${verse.chapter}:${verse.verseNumber} '
        '(${verse.translationCode})\n\n${verse.text}';
  }
}
