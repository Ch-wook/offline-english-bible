// lib/features/dictionary/domain/entities/dictionary_entry.dart
// [NEW] 사전 엔티티 (Wiktionary 기반)

import '../services/dictionary_meaning_formatter.dart';

/// 단어 사전 항목 도메인 엔티티.
/// Wiktionary → 뜻, IPA, 품사, 활용형
/// WordNet → 동의어/반의어/관련 단어
final class DictionaryEntry {
  const DictionaryEntry({
    required this.id,
    required this.word,
    required this.wordNormalized,
    this.ipaUs = '',
    this.ipaUk = '',
    this.frequencyRank = 999999,
    this.bibleFrequency = 0,
    this.etymology = '',
    this.senses = const [],
    this.synonyms = const [],
    this.antonyms = const [],
    this.relatedWords = const [],
    this.inflectedForms = const [],
    this.koreanMeaning = '',
  });

  final int id;

  /// 원형 단어 (e.g., 'Grace').
  final String word;

  /// 소문자 정규화 형태 (인덱스용).
  final String wordNormalized;

  /// 미국 영어 IPA 발음 기호.
  final String ipaUs;

  /// 영국 영어 IPA 발음 기호.
  final String ipaUk;

  /// 영어 전체 어휘에서의 빈도 순위 (낮을수록 흔한 단어).
  final int frequencyRank;

  /// 성경 KJV 내 등장 횟수.
  final int bibleFrequency;

  /// 어원.
  final String etymology;

  /// 품사별 의미 목록 (WordSense).
  final List<WordSense> senses;

  /// WordNet 동의어 목록.
  final List<String> synonyms;

  /// WordNet 반의어 목록.
  final List<String> antonyms;

  /// WordNet 관련 단어 목록.
  final List<String> relatedWords;

  /// 활용형 (plural, past_tense, past_participle 등).
  final List<InflectedForm> inflectedForms;

  /// 내장 사전 한국어 뜻 (있을 경우)
  final String koreanMeaning;

  bool get hasIpa => ipaUs.isNotEmpty || ipaUk.isNotEmpty;
  String get displayIpa => ipaUs.isNotEmpty ? ipaUs : ipaUk;
  String get displayKoreanMeaning =>
      DictionaryMeaningFormatter.format(koreanMeaning);

  bool get hasSynonyms => synonyms.isNotEmpty;
  bool get hasAntonyms => antonyms.isNotEmpty;
  bool get isKjvWord => bibleFrequency > 0;

  /// 주요 품사 (첫 번째 sense의 품사).
  String get primaryPartOfSpeech =>
      senses.isNotEmpty ? senses.first.partOfSpeech : '';

  /// 첫 번째 정의.
  String get primaryDefinition =>
      senses.isNotEmpty ? senses.first.definition : '';

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is DictionaryEntry && id == other.id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() => 'DictionaryEntry($word, ${senses.length} senses)';
}

/// 품사별 의미.
final class WordSense {
  const WordSense({
    required this.id,
    required this.partOfSpeech,
    required this.senseOrder,
    required this.definition,
    this.definitionKo = '',
    this.bibleDefinition = '',
    this.register = '',
    this.isArchaic = false,
    this.examples = const [],
  });

  final int id;

  /// 품사 (noun, verb, adjective, adverb, preposition, conjunction, article, pronoun).
  final String partOfSpeech;

  /// 의미 순서 (같은 품사 내).
  final int senseOrder;

  /// 현대 영어 정의.
  final String definition;

  /// 한국어 뜻 (내장 사전 기반)
  final String definitionKo;

  /// 성경적 맥락 정의 (KJV 특화).
  final String bibleDefinition;

  /// 언어 레지스터 (archaic, formal, informal 등).
  final String register;

  /// 고어(archaic) 여부 — KJV 에서 많이 사용.
  final bool isArchaic;

  /// 예문 목록.
  final List<WordExample> examples;

  String get displayDefinitionKo =>
      DictionaryMeaningFormatter.format(definitionKo);

  String get displayBibleDefinition =>
      DictionaryMeaningFormatter.format(bibleDefinition);

  bool get hasKoreanDefinition => displayDefinitionKo.isNotEmpty;

  bool get hasKoreanBibleDefinition => displayBibleDefinition.isNotEmpty;

  String get posLabel => _posLabels[partOfSpeech] ?? '단어';

  static const _posLabels = {
    'abbrev': '약어',
    'abbreviation': '약어',
    'noun': '명사',
    'verb': '동사',
    'adjective': '형용사',
    'adverb': '부사',
    'preposition': '전치사',
    'conjunction': '접속사',
    'article': '관사',
    'pronoun': '대명사',
    'intj': '감탄사',
    'interjection': '감탄사',
    'proper_noun': '고유명사',
    'numeral': '수사',
    'determiner': '한정사',
    'particle': '불변화사',
    'unknown': '단어',
  };
}

/// 예문.
final class WordExample {
  const WordExample({
    required this.text,
    required this.type,
    this.sourceReference = '',
  });

  /// 예문 텍스트.
  final String text;

  /// 'general' (일반) | 'bible' (성경 구절).
  final String type;

  /// 성경 구절 참조 (e.g., 'John 3:16').
  final String sourceReference;

  bool get isBibleExample => type == 'bible';
}

/// 활용형.
final class InflectedForm {
  const InflectedForm({required this.formType, required this.form});

  /// 활용 유형 (past_tense, past_participle, present_participle, plural).
  final String formType;

  /// 활용 형태.
  final String form;

  String get formTypeLabel => _labels[formType] ?? '활용형';

  static const _labels = {
    'inflected_form': '활용형',
    'archaic_form': '고어 활용형',
    'plural_or_third_person': '복수형·3인칭 단수',
    'past_tense': '과거형',
    'past_participle': '과거분사',
    'past_tense_or_participle': '과거형·과거분사',
    'present_participle': '현재분사',
    'plural': '복수형',
    'third_person_singular': '3인칭 단수',
    'comparative': '비교급',
    'superlative': '최상급',
  };
}
