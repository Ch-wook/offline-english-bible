// lib/core/database/tables/bible_tables.dart
// [NEW] Drift 테이블 정의 - 성경 데이터 (KJV + 개역한글)

import 'package:drift/drift.dart';

/// 성경 66권 목록.
/// testament: 'OT' (구약) | 'NT' (신약)
class BibleBooks extends Table {
  IntColumn get id => integer()();
  TextColumn get name => text().withLength(min: 1, max: 80)();
  TextColumn get nameKorean => text().withLength(min: 1, max: 40)();
  TextColumn get abbreviation => text().withLength(min: 1, max: 10)();
  TextColumn get abbreviationKorean =>
      text().withLength(min: 1, max: 10)();
  TextColumn get testament =>
      text().withLength(min: 2, max: 2)(); // 'OT' or 'NT'
  IntColumn get orderIndex => integer()();
  IntColumn get chapterCount => integer()();

  @override
  Set<Column> get primaryKey => {id};
}

/// 번역본 메타데이터.
/// code: 'KJV' | 'KOREAN_RV' (개역한글)
class BibleTranslations extends Table {
  TextColumn get code =>
      text().withLength(min: 1, max: 20)(); // 'KJV', 'KOREAN_RV'
  TextColumn get name => text().withLength(min: 1, max: 100)();
  TextColumn get language =>
      text().withLength(min: 2, max: 5)(); // 'en' | 'ko'
  TextColumn get copyright => text().withLength(min: 1, max: 200)();
  IntColumn get totalVerses => integer().withDefault(const Constant(0))();

  @override
  Set<Column> get primaryKey => {code};
}

/// 절별 번역 텍스트.
/// 단일 테이블에 모든 번역 저장 — translation_code + book_id + chapter + verse 로 복합 인덱스.
class VerseTranslations extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get translationCode => text().withLength(min: 1, max: 20)();
  IntColumn get bookId => integer()();
  IntColumn get chapter => integer()();
  IntColumn get verse => integer()();
  TextColumn get text => text()();
  // 원어 Strong 번호 참조 (JSON 배열 형태: "[H430,H3068]")
  TextColumn get strongRefs => text().nullable()();

  @override
  Set<Column>? get primaryKey => null; // autoIncrement handles PK

  @override
  List<Set<Column>> get uniqueKeys => [
        {translationCode, bookId, chapter, verse},
      ];
}

/// Cross Reference 데이터 (성경 교차 참조).
class CrossReferences extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get fromBookId => integer()();
  IntColumn get fromChapter => integer()();
  IntColumn get fromVerse => integer()();
  IntColumn get toBookId => integer()();
  IntColumn get toChapter => integer()();
  IntColumn get toVerse => integer()();
  IntColumn get toVerseEnd => integer().nullable()(); // 범위 참조 지원
  RealColumn get rank => real().withDefault(const Constant(0.0))(); // 관련성 순위
}
