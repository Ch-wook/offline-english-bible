// lib/core/database/tables/dictionary_tables.dart
// [NEW] Drift 테이블 정의 - 사전 데이터
// 소스: Wiktionary (IPA, 뜻, 활용형) + WordNet (동의어, 반의어, 관련어) + Strong's Concordance

import 'package:drift/drift.dart';

// ── Wiktionary Data ───────────────────────────────────────────────────

/// 영어 단어 기본 항목 (Wiktionary 기반).
/// word_normalized = 소문자 + 원형 (검색 최적화)
@DataClassName('DictionaryEntryData')
class DictionaryEntries extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get word => text().withLength(min: 1, max: 100)();
  TextColumn get wordNormalized =>
      text().withLength(min: 1, max: 100)(); // 인덱스 대상

  // IPA (/ / 로 감싸진 형태)
  TextColumn get ipaUs => text().withDefault(const Constant(''))(); // 미국
  TextColumn get ipaUk => text().withDefault(const Constant(''))(); // 영국

  // 빈도 정보
  IntColumn get frequencyRank =>
      integer().withDefault(const Constant(999999))(); // 낮을수록 흔한 단어
  IntColumn get bibleFrequency =>
      integer().withDefault(const Constant(0))(); // KJV 출현 횟수

  // 어원 (Optional)
  TextColumn get etymology => text().withDefault(const Constant(''))();

  // 앱에서 바로 표시할 수 있는 오프라인 번역/관계 데이터.
  TextColumn get koreanMeaning => text().withDefault(const Constant(''))();
  TextColumn get synonymsJson => text().withDefault(const Constant('[]'))();
  TextColumn get antonymsJson => text().withDefault(const Constant('[]'))();
  TextColumn get relatedWordsJson => text().withDefault(const Constant('[]'))();

  @override
  List<Set<Column>> get uniqueKeys => [
    {wordNormalized},
  ];
}

/// 품사별 뜻 항목 (한 단어에 여러 품사/뜻 가능).
/// pos: 'noun' | 'verb' | 'adjective' | 'adverb' | 'preposition' | 'conjunction' | 'pronoun' | 'interjection'
@DataClassName('WordSenseData')
class WordSenses extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get entryId => integer().references(DictionaryEntries, #id)();
  TextColumn get partOfSpeech => text().withLength(min: 1, max: 30)();
  IntColumn get senseOrder => integer()(); // 같은 품사 내 순서
  TextColumn get definition => text()(); // 일반 뜻
  TextColumn get definitionKo =>
      text().withDefault(const Constant(''))(); // 한국어 뜻
  TextColumn get bibleDefinition =>
      text().withDefault(const Constant(''))(); // 성경에서의 의미
  TextColumn get register =>
      text().withDefault(const Constant(''))(); // 'archaic', 'formal', etc.
  BoolColumn get isArchaic =>
      boolean().withDefault(const Constant(false))(); // KJV 고어 표현
}

/// 예문 (일반 + 성경).
/// exampleType: 'general' | 'bible'
@DataClassName('WordExampleData')
class WordExamples extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get senseId => integer().references(WordSenses, #id)();
  TextColumn get exampleType =>
      text().withLength(min: 1, max: 10)(); // 'general' | 'bible'
  TextColumn get textContent => text().named('text')(); // 예문
  TextColumn get sourceReference =>
      text().withDefault(const Constant(''))(); // e.g., 'John 3:16'
  IntColumn get bookId => integer().nullable()();
  IntColumn get chapter => integer().nullable()();
  IntColumn get verse => integer().nullable()();
}

/// 단어 활용형 (Wiktionary 기반).
/// formType: 'plural' | 'past_tense' | 'past_participle' | 'present_participle' | 'third_person_singular' | 'comparative' | 'superlative'
@DataClassName('WordFormData')
class WordForms extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get entryId => integer().references(DictionaryEntries, #id)();
  TextColumn get formType => text().withLength(min: 1, max: 40)();
  TextColumn get form => text().withLength(min: 1, max: 100)();
}

// ── WordNet Data ──────────────────────────────────────────────────────

/// WordNet Synset (동의어 집합).
/// posCode: 'n' (명사) | 'v' (동사) | 'a' (형용사) | 'r' (부사)
@DataClassName('WordnetSynsetData')
class WordnetSynsets extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get synsetId =>
      text().withLength(min: 1, max: 20)(); // e.g., '00001740-n'
  TextColumn get posCode => text().withLength(min: 1, max: 1)();
  TextColumn get definition => text()();
  TextColumn get examples =>
      text().withDefault(const Constant(''))(); // JSON 배열

  @override
  List<Set<Column>> get uniqueKeys => [
    {synsetId},
  ];
}

/// 단어 ↔ Synset 매핑 (다대다).
@DataClassName('WordnetLemmaData')
class WordnetLemmas extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get entryId => integer().references(DictionaryEntries, #id)();
  IntColumn get synsetId => integer().references(WordnetSynsets, #id)();
  IntColumn get lemmaOrder => integer().withDefault(const Constant(0))();
}

/// Synset 간 의미 관계.
/// relationType: 'hypernym' | 'hyponym' | 'antonym' | 'similar' | 'also' | 'attribute' | 'holonym' | 'meronym'
@DataClassName('WordnetRelationData')
class WordnetRelations extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get fromSynsetId => integer().references(WordnetSynsets, #id)();
  IntColumn get toSynsetId => integer().references(WordnetSynsets, #id)();
  TextColumn get relationType => text().withLength(min: 1, max: 30)();
}

// ── Strong's Concordance ──────────────────────────────────────────────

/// Strong's Concordance 원어 항목.
/// strongNumber: 'H001' ~ 'H8674' (히브리어) | 'G0001' ~ 'G5624' (헬라어)
class StrongEntries extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get strongNumber =>
      text().withLength(min: 2, max: 10)(); // 'H001', 'G001'
  TextColumn get testament =>
      text().withLength(min: 2, max: 2)(); // 'OT' | 'NT'
  TextColumn get originalWord => text()(); // 히브리어/헬라어 원문
  TextColumn get transliteration => text().withDefault(const Constant(''))();
  TextColumn get pronunciation => text().withDefault(const Constant(''))();
  TextColumn get partOfSpeech => text().withDefault(const Constant(''))();
  TextColumn get shortDefinition => text()();
  TextColumn get fullDefinition => text()();
  TextColumn get derivation => text().withDefault(const Constant(''))();
  IntColumn get kjvFrequency => integer().withDefault(const Constant(0))();

  @override
  List<Set<Column>> get uniqueKeys => [
    {strongNumber},
  ];
}

/// KJV 단어 ↔ Strong 번호 매핑.
class VerseStrongMappings extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get bookId => integer()();
  IntColumn get chapter => integer()();
  IntColumn get verse => integer()();
  IntColumn get wordPosition => integer()(); // 절 내 단어 위치
  TextColumn get kjvWord => text().withLength(min: 1, max: 100)();
  TextColumn get strongNumber =>
      text().withLength(min: 2, max: 10)(); // FK to StrongEntries.strongNumber
}

// ── Grammar Rules ─────────────────────────────────────────────────────

/// 문법 규칙 (Grammar Engine용).
/// ruleType: 'pos_pattern' | 'phrase_pattern' | 'clause_pattern'
class GrammarRules extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get ruleType => text().withLength(min: 1, max: 30)();
  TextColumn get pattern => text()(); // 패턴 (정규식 또는 POS 시퀀스)
  TextColumn get label =>
      text().withLength(min: 1, max: 50)(); // 'NP', 'VP', 'S', ...
  TextColumn get description => text().withDefault(const Constant(''))();
  IntColumn get priority => integer().withDefault(const Constant(0))();
}

/// POS 태깅 사전 (단어 → 품사 매핑, 문법 분석 최적화).
class PosLookup extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get word => text().withLength(min: 1, max: 100)();
  TextColumn get wordNormalized => text().withLength(min: 1, max: 100)();
  TextColumn get primaryPos => text().withLength(min: 1, max: 30)();
  TextColumn get allPos =>
      text().withDefault(const Constant(''))(); // JSON 배열 (중의적 단어)

  @override
  List<Set<Column>> get uniqueKeys => [
    {wordNormalized},
  ];
}
