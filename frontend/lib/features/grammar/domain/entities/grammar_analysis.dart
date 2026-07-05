// lib/features/grammar/domain/entities/grammar_analysis.dart
// [NEW] 문법 분석 엔티티 — 오프라인 POS 태깅 기반

/// 단어 단위 POS(품사) 태그 결과.
final class TokenAnalysis {
  const TokenAnalysis({
    required this.token,
    required this.pos,
    required this.lemma,
    this.dependencyRole = '',
    this.isChunkHead = false,
  });

  /// 원본 토큰 (공백/구두점 포함 원형).
  final String token;

  /// Penn Treebank POS 태그
  /// (NN, NNS, VB, VBD, VBZ, JJ, RB, IN, DT, CC, PRP, CD…).
  final String pos;

  /// 표제어 (lemma). 'created' → 'create'.
  final String lemma;

  /// 의존 파싱 역할 (nsubj, obj, root, mod 등) - 단순 휴리스틱.
  final String dependencyRole;

  /// 청크(구) 헤드 여부 (NP/VP 분석용).
  final bool isChunkHead;

  // ── POS 카테고리 편의 게터 ──────────────────────────────────────────

  bool get isNoun =>
      pos.startsWith('NN') || pos == 'NP' || pos == 'NPS';

  bool get isVerb =>
      pos.startsWith('VB') || pos == 'MD';

  bool get isAdjective =>
      pos.startsWith('JJ');

  bool get isAdverb =>
      pos.startsWith('RB');

  bool get isDeterminer =>
      pos == 'DT';

  bool get isPreposition =>
      pos == 'IN';

  bool get isPronoun =>
      pos.startsWith('PRP');

  bool get isConjunction =>
      pos == 'CC';

  bool get isPunctuation =>
      pos == '.' || pos == ',' || pos == ':' || pos == 'SYM';

  bool get isArchaicVerb =>
      lemma.endsWith('th') || lemma.endsWith('st') ||
      token.endsWith('eth') || token.endsWith('est');

  String get posKorean => _posKo[pos] ?? pos;

  String get posShort => pos.length > 3 ? pos.substring(0, 3) : pos;

  static const _posKo = {
    'NN': '명사', 'NNS': '명사(복)', 'NNP': '고유명사', 'NNPS': '고유명사(복)',
    'VB': '동사', 'VBD': '동사(과)', 'VBG': '동사(ing)', 'VBN': '동사(분)',
    'VBP': '동사(현)', 'VBZ': '동사(3인)', 'MD': '조동사',
    'JJ': '형용사', 'JJR': '형용사(비)', 'JJS': '형용사(최)',
    'RB': '부사', 'RBR': '부사(비)', 'RBS': '부사(최)',
    'DT': '관사/관형', 'IN': '전치사', 'CC': '접속사',
    'PRP': '대명사', 'PRP\$': '소유대명사', 'WP': '의문대명사',
    'CD': '수사', 'EX': '존재사', 'POS': '소유격',
    '.': '구두점', ',': '쉼표', ':': '콜론',
  };

  @override
  String toString() => '$token/$pos';
}

/// 절 전체 문법 분석 결과.
final class GrammarAnalysis {
  const GrammarAnalysis({
    required this.originalText,
    required this.tokens,
  });

  final String originalText;
  final List<TokenAnalysis> tokens;

  List<TokenAnalysis> get contentWords =>
      tokens.where((t) => !t.isPunctuation).toList();

  List<TokenAnalysis> get nouns =>
      tokens.where((t) => t.isNoun).toList();

  List<TokenAnalysis> get verbs =>
      tokens.where((t) => t.isVerb).toList();

  List<TokenAnalysis> get archaicForms =>
      tokens.where((t) => t.isArchaicVerb).toList();

  int get wordCount =>
      tokens.where((t) => !t.isPunctuation).length;

  @override
  String toString() =>
      'GrammarAnalysis($wordCount words: ${tokens.join(' ')})';
}
