// lib/core/database/tables/user_tables.dart
// [NEW] Drift 테이블 정의 - 사용자 데이터 (북마크, 메모, 형광펜, 단어장, 읽기 기록)

import 'package:drift/drift.dart';

/// 북마크.
class Bookmarks extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get translationCode => text().withLength(min: 1, max: 20)();
  IntColumn get bookId => integer()();
  IntColumn get chapter => integer()();
  IntColumn get verse => integer()();
  TextColumn get note => text().withDefault(const Constant(''))();
  DateTimeColumn get createdAt => dateTime()();
  // 서버 동기화 지원
  TextColumn get serverId => text().nullable()();
  BoolColumn get syncPending => boolean().withDefault(const Constant(true))();

  @override
  List<Set<Column>> get uniqueKeys => [
    {translationCode, bookId, chapter, verse},
  ];
}

/// 메모 (절 단위).
class Memos extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get bookId => integer()();
  IntColumn get chapter => integer()();
  IntColumn get verse => integer()();
  TextColumn get content => text()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
  TextColumn get serverId => text().nullable()();
  BoolColumn get syncPending => boolean().withDefault(const Constant(true))();
}

/// 형광펜 (단어/구 단위).
/// color: 'yellow' | 'green' | 'blue' | 'pink' | 'orange'
class Highlights extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get bookId => integer()();
  IntColumn get chapter => integer()();
  IntColumn get verse => integer()();
  TextColumn get translationCode => text().withLength(min: 1, max: 20)();
  IntColumn get wordStart => integer()(); // 단어 시작 인덱스
  IntColumn get wordEnd => integer()(); // 단어 끝 인덱스 (inclusive)
  TextColumn get color =>
      text().withLength(min: 1, max: 10)(); // 'yellow', 'green', ...
  DateTimeColumn get createdAt => dateTime()();
}

/// 단어장 항목.
/// masteryLevel: 0 (새 단어) ~ 5 (완전 암기)
class VocabularyItems extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get word => text().withLength(min: 1, max: 100)();
  TextColumn get wordNormalized =>
      text().withLength(min: 1, max: 100)(); // 소문자, 원형
  TextColumn get partOfSpeech => text().withLength(min: 1, max: 30)();
  TextColumn get definition => text()(); // 기본 뜻
  TextColumn get bibleDefinition => text().withDefault(const Constant(''))();
  TextColumn get ipa => text().withDefault(const Constant(''))();
  // 단어를 발견한 절 정보
  IntColumn get bookId => integer().withDefault(const Constant(0))();
  IntColumn get chapter => integer().withDefault(const Constant(0))();
  IntColumn get verse => integer().withDefault(const Constant(0))();
  TextColumn get translationCode =>
      text().withLength(min: 1, max: 20).withDefault(const Constant(''))();
  TextColumn get note => text().withDefault(const Constant(''))();

  // 학습 상태 (SuperMemo-2 기반)
  IntColumn get masteryLevel =>
      integer().withDefault(const Constant(0))(); // 0~5
  IntColumn get reviewCount => integer().withDefault(const Constant(0))();
  IntColumn get correctCount => integer().withDefault(const Constant(0))();
  IntColumn get repetitions => integer().withDefault(const Constant(0))();
  RealColumn get easeFactor => real().withDefault(const Constant(2.5))();
  IntColumn get intervalDays => integer().withDefault(const Constant(1))();

  DateTimeColumn get addedAt => dateTime()();
  DateTimeColumn get nextReviewAt => dateTime().nullable()();
  DateTimeColumn get lastReviewedAt => dateTime().nullable()();
  BoolColumn get isLearned => boolean().withDefault(const Constant(false))();
  BoolColumn get isFavorite => boolean().withDefault(const Constant(false))();

  @override
  List<Set<Column>> get uniqueKeys => [
    {word, partOfSpeech},
  ];
}

/// 복습 세션 기록.
class ReviewSessions extends Table {
  IntColumn get id => integer().autoIncrement()();
  DateTimeColumn get startedAt => dateTime()();
  DateTimeColumn get completedAt => dateTime().nullable()();
  IntColumn get totalCount => integer()();
  IntColumn get correctCount => integer().withDefault(const Constant(0))();
  TextColumn get sessionType =>
      text().withLength(
        min: 1,
        max: 20,
      )(); // 'multiple_choice' | 'spelling' | 'flashcard'
}

/// 복습 세션 개별 답변.
class ReviewAnswers extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get sessionId => integer().references(ReviewSessions, #id)();
  IntColumn get vocabularyId => integer().references(VocabularyItems, #id)();
  BoolColumn get isCorrect => boolean()();
  IntColumn get responseTimeMs => integer()(); // 응답 시간 (밀리초)
  DateTimeColumn get answeredAt => dateTime()();
}

/// 읽기 기록.
class ReadingHistory extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get bookId => integer()();
  IntColumn get chapter => integer()();
  TextColumn get translationCode => text().withLength(min: 1, max: 20)();
  DateTimeColumn get accessedAt => dateTime()();
  IntColumn get durationSeconds => integer().withDefault(const Constant(0))();
  IntColumn get lastVerseRead => integer().withDefault(const Constant(1))();
}

/// 여러 성경 읽기 위치를 독립적으로 보존하는 탭.
@DataClassName('ReadingTabData')
class ReadingTabs extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get bookId => integer().withDefault(const Constant(1))();
  IntColumn get chapter => integer().withDefault(const Constant(1))();
  TextColumn get translationCode => text().withDefault(const Constant('KJV'))();
  BoolColumn get isParallelView =>
      boolean().withDefault(const Constant(false))();
  TextColumn get parallelTranslationCode =>
      text().withDefault(const Constant('KOREAN_RV'))();
  IntColumn get scrollVerse => integer().withDefault(const Constant(1))();
  RealColumn get scrollFraction => real().withDefault(const Constant(0))();
  RealColumn get scrollOffset => real().withDefault(const Constant(0))();
  IntColumn get sortOrder => integer().withDefault(const Constant(0))();
  BoolColumn get isActive => boolean().withDefault(const Constant(false))();
  DateTimeColumn get updatedAt => dateTime()();
}

/// 읽기 탭 안에서 장마다 마지막으로 읽던 세부 위치.
@DataClassName('ChapterReadingPositionData')
class ChapterReadingPositions extends Table {
  IntColumn get readingTabId =>
      integer().references(ReadingTabs, #id, onDelete: KeyAction.cascade)();
  IntColumn get bookId => integer()();
  IntColumn get chapter => integer()();
  IntColumn get scrollVerse => integer().withDefault(const Constant(1))();
  RealColumn get scrollFraction => real().withDefault(const Constant(0))();
  RealColumn get scrollOffset => real().withDefault(const Constant(0))();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column<Object>> get primaryKey => {readingTabId, bookId, chapter};
}

/// 읽기 계획 (사용자 정의).
class ReadingPlans extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().withLength(min: 1, max: 100)();
  TextColumn get description => text().withDefault(const Constant(''))();
  DateTimeColumn get startDate => dateTime()();
  DateTimeColumn get targetEndDate => dateTime()();
  BoolColumn get isActive => boolean().withDefault(const Constant(true))();
  IntColumn get totalDays => integer()();
  IntColumn get completedDays => integer().withDefault(const Constant(0))();
}
