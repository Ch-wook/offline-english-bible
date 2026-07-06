// lib/features/bible/data/mappers/bible_mapper.dart
// [NEW] Drift 데이터 클래스 ↔ 도메인 엔티티 변환 매퍼

import '../../../../core/database/app_database.dart';
import '../../domain/entities/book.dart';
import '../../domain/entities/verse.dart';

/// [BibleBook] (Drift 생성 클래스) → [Book] (도메인 엔티티)
extension BibleBookMapper on BibleBook {
  Book toDomain() => Book(
        id: id,
        name: name,
        nameKorean: nameKorean,
        abbreviation: abbreviation,
        abbreviationKorean: abbreviationKorean,
        testament: testament,
        orderIndex: orderIndex,
        chapterCount: chapterCount,
      );
}

/// [VerseTranslation] (Drift 생성 클래스) → [Verse] (도메인 엔티티)
extension VerseTranslationMapper on VerseTranslation {
  Verse toDomain() => Verse(
        bookId: bookId,
        chapter: chapter,
        verseNumber: verse,
        text: textContent,
        translationCode: translationCode,
        strongRefs: Verse.parseStrongRefs(strongRefs),
      );
}

/// 리스트 변환 확장.
extension BibleBookListMapper on List<BibleBook> {
  List<Book> toDomain() => map((b) => b.toDomain()).toList();
}

extension VerseTranslationListMapper on List<VerseTranslation> {
  List<Verse> toDomain() => map((v) => v.toDomain()).toList();
}
