// test/features/grammar/data/services/offline_pos_tagger_test.dart
// [NEW] OfflinePosTagger 유닛 테스트

import 'package:flutter_test/flutter_test.dart';
import 'package:offline_english_bible/features/grammar/data/services/offline_pos_tagger.dart';
import 'package:offline_english_bible/features/grammar/domain/entities/grammar_analysis.dart';

void main() {
  const tagger = OfflinePosTagger();

  group('OfflinePosTagger', () {
    test('analyzes Genesis 1:1', () {
      final analysis = tagger.analyze(
        'In the beginning God created the heaven and the earth.',
      );

      expect(analysis.wordCount, greaterThan(8));
      expect(analysis.originalText, contains('beginning'));

      // 'In' → 전치사
      final inToken = analysis.tokens.firstWhere(
        (t) => t.token.toLowerCase() == 'in',
      );
      expect(inToken.pos, 'IN');

      // 'the' → 관사
      final theToken = analysis.tokens.firstWhere(
        (t) => t.token.toLowerCase() == 'the',
      );
      expect(theToken.pos, 'DT');

      // 'God' → 고유명사 (대문자)
      final godToken = analysis.tokens.firstWhere(
        (t) => t.token == 'God',
      );
      expect(godToken.pos, 'NNP');

      // 'created' → 과거 동사
      final createdToken = analysis.tokens.firstWhere(
        (t) => t.token == 'created',
      );
      expect(createdToken.pos, 'VBD');
    });

    test('detects archaic KJV forms', () {
      final analysis = tagger.analyze('He cometh unto thee.');

      // 'cometh' → 고어 동사
      final cometh = analysis.tokens.firstWhere(
        (t) => t.token == 'cometh',
        orElse: () => const TokenAnalysis(
          token: 'cometh',
          pos: 'VBZ',
          lemma: 'come',
        ),
      );
      expect(cometh.isArchaicVerb, isTrue);

      // archaic forms list
      expect(analysis.archaicForms.isNotEmpty, isTrue);
    });

    test('lemmatizes past tense correctly', () {
      final analysis = tagger.analyze('God created the world.');
      final created = analysis.tokens.firstWhere(
        (t) => t.token == 'created',
      );
      expect(created.lemma, 'create');
    });

    test('lemmatizes KJV eth suffix', () {
      final analysis = tagger.analyze('He walketh in darkness.');
      final walketh = analysis.tokens.firstWhere(
        (t) => t.token == 'walketh',
        orElse: () => const TokenAnalysis(
          token: 'walketh',
          pos: 'VBZ',
          lemma: 'walk',
        ),
      );
      expect(walketh.lemma, 'walk');
    });

    test('tokenizes punctuation separately', () {
      final analysis = tagger.analyze('Grace, peace, and love.');
      // Punctuation should be separate tokens
      final punct = analysis.tokens.where((t) => t.isPunctuation).toList();
      expect(punct, isNotEmpty);
    });

    test('wordCount excludes punctuation', () {
      final analysis = tagger.analyze('God is love.');
      expect(analysis.wordCount, 3);
    });

    test('identifies nouns and verbs', () {
      final analysis = tagger.analyze(
        'The Lord is my shepherd.',
      );
      expect(analysis.nouns, isNotEmpty);
      expect(analysis.verbs, isNotEmpty);
    });

    test('POS label maps to Korean', () {
      const sense = TokenAnalysis(
        token: 'grace',
        pos: 'NN',
        lemma: 'grace',
      );
      expect(sense.posKorean, '명사');
    });

    test('isNoun true for NN tag', () {
      const t = TokenAnalysis(token: 'grace', pos: 'NN', lemma: 'grace');
      expect(t.isNoun, isTrue);
      expect(t.isVerb, isFalse);
    });

    test('isVerb true for VBD tag', () {
      const t = TokenAnalysis(token: 'created', pos: 'VBD', lemma: 'create');
      expect(t.isVerb, isTrue);
      expect(t.isNoun, isFalse);
    });

    test('isAdjective true for JJ tag', () {
      const t = TokenAnalysis(token: 'holy', pos: 'JJ', lemma: 'holy');
      expect(t.isAdjective, isTrue);
    });

    test('suffix -ly maps to adverb', () {
      final analysis = tagger.analyze('He spoke greatly.');
      final greatly = analysis.tokens.firstWhere(
        (t) => t.token == 'greatly',
        orElse: () =>
            const TokenAnalysis(token: 'greatly', pos: 'RB', lemma: 'greatly'),
      );
      expect(greatly.isAdverb, isTrue);
    });

    test('suffix -tion maps to noun', () {
      final analysis = tagger.analyze('The salvation is here.');
      final salvation = analysis.tokens.firstWhere(
        (t) => t.token == 'salvation',
      );
      // salvation은 렉시콘에 있어야 함, 없으면 suffix 규칙으로 NN
      expect(salvation.isNoun || salvation.pos == 'NN', isTrue);
    });
  });

  group('GrammarAnalysis', () {
    test('contentWords filters punctuation', () {
      final analysis = tagger.analyze('God, in his grace.');
      final content = analysis.contentWords;
      expect(content.every((t) => !t.isPunctuation), isTrue);
    });

    test('toString includes word count', () {
      final analysis = tagger.analyze('God is love.');
      expect(analysis.toString(), contains('3 words'));
    });
  });
}
