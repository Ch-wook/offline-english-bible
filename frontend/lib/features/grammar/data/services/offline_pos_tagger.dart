// lib/features/grammar/data/services/offline_pos_tagger.dart
// [NEW] 오프라인 POS 태거 — 규칙 기반 + 룩업 테이블
//
// AI API 없이 동작하는 오프라인 품사 분석 엔진.
// 접근 방식:
//   1. 룩업 테이블 (KJV 핵심 단어 ~500개 하드코딩)
//   2. 형태소 규칙 (suffix matching)
//   3. 문맥 규칙 (다음/이전 토큰 기반)
//   4. Closed-class word 사전 (관사, 전치사, 접속사 등)

import '../../domain/entities/grammar_analysis.dart';

final class OfflinePosTagger {
  const OfflinePosTagger();

  /// 문장(절) 전체 POS 분석.
  GrammarAnalysis analyze(String text) {
    final rawTokens = _tokenize(text);
    final tagged = _tagTokens(rawTokens);
    return GrammarAnalysis(originalText: text, tokens: tagged);
  }

  // ── Tokenizer ─────────────────────────────────────────────────────

  List<String> _tokenize(String text) {
    final tokens = <String>[];
    // 구두점을 별도 토큰으로 분리
    final regex = RegExp(r"[\w']+|[^\w'\s]|\s+");
    for (final match in regex.allMatches(text)) {
      final t = match.group(0)!;
      if (t.trim().isEmpty) continue; // 공백 스킵
      tokens.add(t);
    }
    return tokens;
  }

  // ── Tagger ────────────────────────────────────────────────────────

  List<TokenAnalysis> _tagTokens(List<String> tokens) {
    final result = <TokenAnalysis>[];

    for (var i = 0; i < tokens.length; i++) {
      final token = tokens[i];
      final lower = token.toLowerCase();
      final prev = i > 0 ? tokens[i - 1].toLowerCase() : '';
      final next = i < tokens.length - 1 ? tokens[i + 1].toLowerCase() : '';

      // 1. 구두점
      if (_punctuation.contains(token)) {
        result.add(TokenAnalysis(token: token, pos: token, lemma: token));
        continue;
      }

      // 2. 숫자
      if (RegExp(r'^\d+$').hasMatch(token)) {
        result.add(TokenAnalysis(token: token, pos: 'CD', lemma: token));
        continue;
      }

      // 3. 고유명사 (대문자 시작 + 위치 확인)
      if (_isProperNoun(token, i)) {
        result.add(
          TokenAnalysis(
            token: token,
            pos: 'NNP',
            lemma: token,
            dependencyRole: 'nsubj',
          ),
        );
        continue;
      }

      // 4. 룩업 테이블
      final lookupPos = _lexicon[lower];
      if (lookupPos != null) {
        final contextPos = _applyContextRules(lower, lookupPos, prev, next);
        result.add(
          TokenAnalysis(
            token: token,
            pos: contextPos,
            lemma: _lemmatize(lower, contextPos),
            dependencyRole: _inferDependency(contextPos, i, result),
          ),
        );
        continue;
      }

      // 5. 형태소 규칙
      final morphPos = _morphologyTag(lower, prev, next);
      result.add(
        TokenAnalysis(
          token: token,
          pos: morphPos,
          lemma: _lemmatize(lower, morphPos),
          dependencyRole: _inferDependency(morphPos, i, result),
        ),
      );
    }

    return result;
  }

  // ── Context Rules ─────────────────────────────────────────────────

  String _applyContextRules(
    String word,
    String basePos,
    String prev,
    String next,
  ) {
    // "the/a/an" 다음 단어: 명사 쪽으로 바이어스
    if (_articles.contains(prev) && basePos.startsWith('VB')) {
      return 'NN'; // "the light" → light=NN
    }
    // 조동사 다음 동사: VB (원형)
    if (_modals.contains(prev) && basePos.startsWith('VB')) {
      return 'VB';
    }
    return basePos;
  }

  // ── Morphology Tagger ─────────────────────────────────────────────

  String _morphologyTag(String word, String prev, String next) {
    // 관사/한정사 다음에 오면 명사
    if (_articles.contains(prev)) {
      if (word.endsWith('ing')) return 'NN'; // "the beginning"
      if (word.endsWith('ness')) return 'NN';
      if (word.endsWith('tion') || word.endsWith('sion')) return 'NN';
      if (word.endsWith('ment')) return 'NN';
      if (word.endsWith('ness') || word.endsWith('hood')) return 'NN';
      return 'NN'; // 기본: 명사
    }

    // 접미사 기반 품사 추정
    if (word.endsWith('ly')) return 'RB'; // quickly, greatly
    if (word.endsWith('ness') ||
        word.endsWith('ment') ||
        word.endsWith('tion') ||
        word.endsWith('sion') ||
        word.endsWith('ance') ||
        word.endsWith('ence') ||
        word.endsWith('ity')) {
      return 'NN';
    }
    if (word.endsWith('ed') && !_articles.contains(prev)) return 'VBD';
    if (word.endsWith('ing')) return 'VBG';
    if (word.endsWith('er') && prev.isNotEmpty) return 'JJR'; // comparative
    if (word.endsWith('est')) return 'JJS'; // superlative
    if (word.endsWith('ful') ||
        word.endsWith('less') ||
        word.endsWith('ous') ||
        word.endsWith('al') ||
        word.endsWith('ive')) {
      return 'JJ';
    }

    // KJV 고어 접미사
    if (word.endsWith('eth') || word.endsWith('est')) return 'VBZ'; // cometh
    if (word.endsWith('th')) return 'VBZ'; // "he goeth"

    // 복수형
    if (word.endsWith('s') && word.length > 3) return 'NNS';

    return 'NN'; // 기본값: 명사
  }

  // ── Lemmatizer ────────────────────────────────────────────────────

  String _lemmatize(String word, String pos) {
    if (pos.startsWith('VB')) {
      // KJV 고어 활용형 제거
      if (word.endsWith('eth')) {
        return _knownVerbStem(word.substring(0, word.length - 3));
      }
      if (word.endsWith('est')) {
        return _knownVerbStem(word.substring(0, word.length - 3));
      }
      if (word.endsWith('th') && word.length > 4) {
        return word.substring(0, word.length - 2);
      }
      // 일반 활용형
      if (word.endsWith('ied')) {
        return '${word.substring(0, word.length - 3)}y';
      }
      if (word.endsWith('ed') && word.length > 4) {
        return _knownVerbStem(word.substring(0, word.length - 2));
      }
      if (word.endsWith('ing') && word.length > 5) {
        return _knownVerbStem(word.substring(0, word.length - 3));
      }
      if (word.endsWith('s') && !word.endsWith('ss')) {
        return word.substring(0, word.length - 1);
      }
    }
    if (pos == 'NNS') {
      if (word.endsWith('ies') && word.length > 4) {
        return '${word.substring(0, word.length - 3)}y';
      }
      if (word.endsWith('es') && word.length > 3) {
        return word.substring(0, word.length - 2);
      }
      if (word.endsWith('s') && word.length > 3) {
        return word.substring(0, word.length - 1);
      }
    }
    return word;
  }

  String _knownVerbStem(String stem) {
    final withSilentE = '${stem}e';
    if ((_lexicon[withSilentE] ?? '').startsWith('VB')) return withSilentE;
    if (stem.length > 2 && stem[stem.length - 1] == stem[stem.length - 2]) {
      final withoutDouble = stem.substring(0, stem.length - 1);
      if ((_lexicon[withoutDouble] ?? '').startsWith('VB')) {
        return withoutDouble;
      }
    }
    return stem;
  }

  // ── Dependency ────────────────────────────────────────────────────

  String _inferDependency(String pos, int index, List<TokenAnalysis> prev) {
    if (index == 0 && pos.startsWith('NN')) return 'nsubj';
    if (pos.startsWith('VB') || pos == 'MD') return 'root';
    if (pos == 'IN') return 'prep';
    if (pos == 'DT') return 'det';
    if (pos.startsWith('JJ')) return 'amod';
    if (pos.startsWith('RB')) return 'advmod';
    return '';
  }

  // ── Proper Noun Detection ─────────────────────────────────────────

  bool _isProperNoun(String token, int index) {
    if (index == 0) return false; // 문장 첫 단어는 대문자지만 고유명사 아닐 수 있음
    if (!RegExp(r'^[A-Z]').hasMatch(token)) return false;
    if (_closedClassWords.contains(token.toLowerCase())) return false;
    return true;
  }

  // ── Closed-Class Word Sets ─────────────────────────────────────────

  static const _punctuation = {
    '.',
    ',',
    ';',
    ':',
    '!',
    '?',
    '"',
    "'",
    '—',
    '-',
  };
  static const _articles = {'a', 'an', 'the'};
  static const _modals = {
    'shall',
    'will',
    'would',
    'should',
    'can',
    'could',
    'may',
    'might',
    'must',
  };
  static const _closedClassWords = {
    'i',
    'me',
    'my',
    'we',
    'our',
    'you',
    'your',
    'he',
    'him',
    'his',
    'she',
    'her',
    'they',
    'them',
    'their',
    'it',
    'its',
    'and',
    'but',
    'or',
    'for',
    'nor',
    'so',
    'yet',
    'the',
    'a',
    'an',
    'this',
    'that',
    'these',
    'those',
    'in',
    'on',
    'at',
    'by',
    'to',
    'of',
    'from',
    'with',
    'into',
    'through',
    'is',
    'are',
    'was',
    'were',
    'be',
    'been',
    'being',
    'am',
    'do',
    'does',
    'did',
    'have',
    'has',
    'had',
  };

  // ── Core Lexicon (KJV 핵심 단어) ─────────────────────────────────────
  // 형식: word → Penn Treebank POS tag

  static const _lexicon = <String, String>{
    // Articles / Determiners
    'the': 'DT', 'a': 'DT', 'an': 'DT',
    'this': 'DT', 'these': 'DT', 'those': 'DT',
    'every': 'DT', 'each': 'DT', 'all': 'DT', 'both': 'DT',

    // Pronouns
    'i': 'PRP', 'me': 'PRP', 'my': 'PRP\$', 'mine': 'PRP\$',
    'we': 'PRP', 'our': 'PRP\$', 'us': 'PRP', 'ours': 'PRP\$',
    'you': 'PRP', 'your': 'PRP\$', 'ye': 'PRP', // KJV archaic
    'he': 'PRP', 'him': 'PRP', 'his': 'PRP\$',
    'she': 'PRP', 'her': 'PRP', 'hers': 'PRP\$',
    'it': 'PRP', 'its': 'PRP\$',
    'they': 'PRP', 'them': 'PRP', 'their': 'PRP\$', 'theirs': 'PRP\$',
    'who': 'WP', 'whom': 'WP', 'whose': 'WP\$', 'which': 'WDT', 'that': 'WDT',
    'thee': 'PRP', 'thou': 'PRP', 'thy': 'PRP\$', 'thine': 'PRP\$', // KJV
    'thyself': 'PRP', 'himself': 'PRP', 'herself': 'PRP', 'itself': 'PRP',

    // Prepositions
    'in': 'IN', 'on': 'IN', 'at': 'IN', 'by': 'IN', 'to': 'TO',
    'of': 'IN', 'from': 'IN', 'with': 'IN', 'into': 'IN', 'through': 'IN',
    'for': 'IN', 'upon': 'IN', 'unto': 'IN', 'over': 'IN', 'under': 'IN',
    'before': 'IN', 'after': 'IN', 'above': 'IN', 'below': 'IN',
    'between': 'IN', 'among': 'IN', 'against': 'IN', 'without': 'IN',
    'within': 'IN', 'throughout': 'IN', 'according': 'IN',

    // Conjunctions
    'and': 'CC', 'but': 'CC', 'or': 'CC', 'nor': 'CC',
    'yet': 'CC', 'so': 'CC',
    'if': 'IN', 'when': 'WRB', 'where': 'WRB',
    'because': 'IN', 'though': 'IN', 'although': 'IN', 'lest': 'IN',

    // Modals
    'shall': 'MD', 'will': 'MD', 'would': 'MD', 'should': 'MD',
    'can': 'MD', 'could': 'MD', 'may': 'MD', 'might': 'MD', 'must': 'MD',

    // Auxiliary Verbs (to be)
    'am': 'VBP', 'is': 'VBZ', 'are': 'VBP', 'was': 'VBD', 'were': 'VBD',
    'be': 'VB', 'been': 'VBN', 'being': 'VBG',
    'art': 'VBP', // KJV "thou art"
    // Auxiliary Verbs (to have)
    'have': 'VBP', 'has': 'VBZ', 'had': 'VBD', 'having': 'VBG',
    'hath': 'VBZ', 'hast': 'VBP', // KJV
    // Auxiliary Verbs (to do)
    'do': 'VBP', 'does': 'VBZ', 'did': 'VBD', 'doing': 'VBG', 'done': 'VBN',
    'doth': 'VBZ', 'doest': 'VBP', // KJV
    // Core KJV Verbs
    'create': 'VB', 'created': 'VBD', 'creating': 'VBG',
    'say': 'VB', 'said': 'VBD', 'saith': 'VBZ', 'sayeth': 'VBZ',
    'go': 'VB', 'went': 'VBD', 'gone': 'VBN', 'goeth': 'VBZ',
    'come': 'VB', 'came': 'VBD', 'cometh': 'VBZ',
    'see': 'VB', 'saw': 'VBD', 'seen': 'VBN', 'seeth': 'VBZ',
    'know': 'VB', 'knew': 'VBD', 'known': 'VBN', 'knoweth': 'VBZ',
    'give': 'VB', 'gave': 'VBD', 'given': 'VBN', 'giveth': 'VBZ',
    'take': 'VB', 'took': 'VBD', 'taken': 'VBN', 'taketh': 'VBZ',
    'make': 'VB', 'made': 'VBD', 'maketh': 'VBZ',
    'speak': 'VB', 'spoke': 'VBD', 'spoken': 'VBN', 'speaketh': 'VBZ',
    'hear': 'VB', 'heard': 'VBD', 'heareth': 'VBZ',
    'call': 'VB', 'called': 'VBD', 'calleth': 'VBZ',
    'behold': 'VB', 'beheld': 'VBD',
    'keep': 'VB', 'kept': 'VBD', 'keepeth': 'VBZ',
    'love': 'VB', 'loved': 'VBD', 'loveth': 'VBZ',
    'fear': 'VB', 'feared': 'VBD', 'feareth': 'VBZ',
    'walk': 'VB', 'walked': 'VBD', 'walketh': 'VBZ',
    'dwell': 'VB', 'dwelt': 'VBD', 'dwelleth': 'VBZ',
    'answer': 'VB', 'answered': 'VBD',
    'arise': 'VB', 'arose': 'VBD', 'arisen': 'VBN',
    'seek': 'VB', 'sought': 'VBD', 'seeketh': 'VBZ',
    'put': 'VB', 'set': 'VB', 'let': 'VB',
    'bring': 'VB', 'brought': 'VBD',
    'send': 'VB', 'sent': 'VBD',
    'find': 'VB', 'found': 'VBD',
    'turn': 'VB', 'turned': 'VBD',
    'pass': 'VB', 'passed': 'VBD',
    'stand': 'VB', 'stood': 'VBD',
    'sit': 'VB', 'sat': 'VBD',
    'die': 'VB', 'died': 'VBD',
    'live': 'VB', 'lived': 'VBD',
    'reign': 'VB', 'reigned': 'VBD',
    'serve': 'VB', 'served': 'VBD',
    'receive': 'VB', 'received': 'VBD',

    // Core KJV Nouns
    'god': 'NNP', 'lord': 'NNP', 'jesus': 'NNP', 'christ': 'NNP',
    'israel': 'NNP', 'jerusalem': 'NNP', 'moses': 'NNP', 'david': 'NNP',
    'heaven': 'NN', 'earth': 'NN', 'water': 'NN', 'light': 'NN',
    'darkness': 'NN', 'fire': 'NN', 'wind': 'NN', 'spirit': 'NN',
    'soul': 'NN', 'heart': 'NN', 'hand': 'NN', 'eye': 'NN',
    'day': 'NN', 'night': 'NN', 'year': 'NN', 'time': 'NN',
    'word': 'NN', 'name': 'NN', 'law': 'NN', 'way': 'NN',
    'life': 'NN', 'death': 'NN', 'truth': 'NN', 'grace': 'NN',
    'faith': 'NN', 'hope': 'NN', 'peace': 'NN',
    'glory': 'NN', 'power': 'NN', 'king': 'NN', 'kingdom': 'NN',
    'son': 'NN', 'father': 'NN', 'mother': 'NN', 'man': 'NN',
    'woman': 'NN', 'people': 'NNS', 'nation': 'NN', 'land': 'NN',
    'house': 'NN', 'city': 'NN', 'temple': 'NN', 'tabernacle': 'NN',
    'covenant': 'NN', 'commandment': 'NN', 'prayer': 'NN',
    'servant': 'NN', 'prophet': 'NN', 'priest': 'NN',
    'salvation': 'NN', 'righteousness': 'NN', 'sin': 'NN',
    'blood': 'NN', 'bread': 'NN', 'stone': 'NN', 'seed': 'NN',
    'beginning': 'NN', 'end': 'NN', 'voice': 'NN',

    // Core Adjectives
    'great': 'JJ', 'good': 'JJ', 'holy': 'JJ', 'righteous': 'JJ',
    'mighty': 'JJ', 'everlasting': 'JJ', 'eternal': 'JJ',
    'faithful': 'JJ', 'true': 'JJ', 'new': 'JJ', 'old': 'JJ',
    'first': 'JJ', 'last': 'JJ', 'blessed': 'JJ', 'living': 'JJ',
    'strong': 'JJ', 'whole': 'JJ', 'perfect': 'JJ',

    // Adverbs
    'not': 'RB', 'now': 'RB', 'also': 'RB', 'then': 'RB', 'therefore': 'RB',
    'again': 'RB', 'even': 'RB', 'only': 'RB', 'truly': 'RB', 'verily': 'RB',
    'thus': 'RB', 'herein': 'RB', 'therein': 'RB', 'thereof': 'RB',
    'wherefore': 'WRB', 'nevertheless': 'RB', 'furthermore': 'RB',

    // Existential
    'there': 'EX',

    // Numbers
    'one': 'CD', 'two': 'CD', 'three': 'CD', 'four': 'CD',
    'five': 'CD', 'six': 'CD', 'seven': 'CD', 'twelve': 'CD',
    'forty': 'CD', 'hundred': 'CD', 'thousand': 'CD',
  };
}
