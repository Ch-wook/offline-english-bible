import 'dart:convert';
import 'dart:io';
import 'dart:math' as math;

import 'dictionary_korean_backfill.dart';

final class ParallelBibleMeaningReport {
  const ParallelBibleMeaningReport({
    required this.properNames,
    required this.contextMeanings,
    required this.unresolved,
  });

  final int properNames;
  final int contextMeanings;
  final int unresolved;
  int get total => properNames + contextMeanings;
}

/// Fills dictionary gaps from the bundled KJV/Korean parallel corpus.
///
/// Proper names are matched to their Korean spelling by verse co-occurrence,
/// corpus rarity, and Hangul romanization similarity. General vocabulary is
/// never inferred from verse-level alignment because that cannot establish a
/// reliable word-level translation.
ParallelBibleMeaningReport enrichFromParallelBible({
  required List<DictionaryJson> entries,
  required String kjvPath,
  required String koreanPath,
}) {
  final kjvFile = File(kjvPath);
  final koreanFile = File(koreanPath);
  if (!kjvFile.existsSync() || !koreanFile.existsSync()) {
    return const ParallelBibleMeaningReport(
      properNames: 0,
      contextMeanings: 0,
      unresolved: 0,
    );
  }

  final koreanByKey = <String, String>{
    for (final row in _readVerses(koreanFile))
      _verseKey(row): row['t']?.toString() ?? '',
  };
  final indexedVerses = <_ParallelVerse>[];
  final koreanDocumentFrequency = <String, int>{};

  for (final row in _readVerses(kjvFile)) {
    final korean = koreanByKey[_verseKey(row)] ?? '';
    if (korean.isEmpty) continue;
    final koreanTokens = _koreanTokens(korean).toSet();
    for (final token in koreanTokens) {
      koreanDocumentFrequency.update(
        token,
        (count) => count + 1,
        ifAbsent: () => 1,
      );
    }
    indexedVerses.add(
      _ParallelVerse(
        englishTokens: _englishTokens(row['t']?.toString() ?? '').toSet(),
        koreanText: korean,
        koreanTokens: koreanTokens,
      ),
    );
  }

  final versesByEnglishToken = <String, List<_ParallelVerse>>{};
  for (final verse in indexedVerses) {
    for (final token in verse.englishTokens) {
      (versesByEnglishToken[token] ??= []).add(verse);
    }
  }

  var properNames = 0;
  var contextMeanings = 0;
  var unresolved = 0;
  for (final entry in entries) {
    if (_meaning(entry).isNotEmpty) continue;
    final word = _normalize(entry['word']);
    final forms = <String>{
      word,
      for (final raw in entry['inflections'] as List<dynamic>? ?? const [])
        _normalize((raw as Map<String, dynamic>)['form']),
    }..remove('');
    final matchingVerses = <_ParallelVerse>{
      for (final form in forms) ...?versesByEnglishToken[form],
    }.toList();
    if (matchingVerses.isEmpty) {
      unresolved++;
      continue;
    }

    final proper = _isProperName(entry);
    final candidate = _bestKoreanCandidate(
      word: word,
      verses: matchingVerses,
      documentFrequency: koreanDocumentFrequency,
      documentCount: indexedVerses.length,
      requireRomanization: proper,
    );
    final firstVerse = matchingVerses.first.koreanText;

    if (proper && candidate != null) {
      _setMeaning(entry, '$candidate(성경 인명·지명)', firstVerse);
      properNames++;
      continue;
    }

    unresolved++;
  }

  return ParallelBibleMeaningReport(
    properNames: properNames,
    contextMeanings: contextMeanings,
    unresolved: unresolved,
  );
}

List<Map<String, dynamic>> _readVerses(File file) =>
    (jsonDecode(file.readAsStringSync()) as List<dynamic>)
        .cast<Map<String, dynamic>>();

String _verseKey(Map<String, dynamic> row) =>
    '${row['b']}:${row['c']}:${row['v']}';

Iterable<String> _englishTokens(String text) sync* {
  for (final match in RegExp(r"[A-Za-z]+(?:'[A-Za-z]+)?").allMatches(text)) {
    yield match.group(0)!.toLowerCase();
  }
}

Iterable<String> _koreanTokens(String text) sync* {
  for (final match in RegExp(r'[가-힣]+').allMatches(text)) {
    final raw = match.group(0)!;
    final token = _stripKoreanParticle(raw);
    if (token.length >= 2) yield token;
    for (final suffix in const [
      '이었더라',
      '이더라',
      '이라도',
      '이라면',
      '이라고',
      '이라',
      '이니',
      '이며',
      '이요',
      '로',
    ]) {
      if (token.endsWith(suffix) && token.length - suffix.length >= 2) {
        yield token.substring(0, token.length - suffix.length);
      }
    }
    if (token.endsWith('야') && token.length >= 4) {
      yield token.substring(0, token.length - 1);
    }
    if ((token.endsWith('요') || token.endsWith('라') || token.endsWith('니')) &&
        token.length >= 4) {
      yield token.substring(0, token.length - 1);
    }
  }
}

String _stripKoreanParticle(String value) {
  const particles = [
    '으로부터',
    '에게서는',
    '에게서',
    '한테서',
    '께서는',
    '에서는',
    '으로써',
    '으로서',
    '에게는',
    '까지',
    '부터',
    '에게',
    '한테',
    '께서',
    '에서',
    '으로',
    '로써',
    '로서',
    '보다',
    '처럼',
    '하고',
    '와',
    '과',
    '의',
    '은',
    '는',
    '이',
    '가',
    '을',
    '를',
    '에',
    '께',
    '도',
    '만',
  ];
  for (final particle in particles) {
    if (value.endsWith(particle) && value.length - particle.length >= 2) {
      return value.substring(0, value.length - particle.length);
    }
  }
  return value;
}

String? _bestKoreanCandidate({
  required String word,
  required List<_ParallelVerse> verses,
  required Map<String, int> documentFrequency,
  required int documentCount,
  required bool requireRomanization,
}) {
  final counts = <String, int>{};
  for (final verse in verses) {
    for (final token in verse.koreanTokens) {
      counts.update(token, (count) => count + 1, ifAbsent: () => 1);
    }
  }
  if (counts.isEmpty) return null;

  String? best;
  var bestScore = double.negativeInfinity;
  var bestRomanization = 0.0;
  for (final candidate in counts.keys) {
    final romanization = _similarity(
      _normalizeRomanized(word),
      _normalizeRomanized(_romanizeHangul(candidate)),
    );
    final coverage = counts[candidate]! / verses.length;
    final idf = math.log(
      (documentCount + 1) / ((documentFrequency[candidate] ?? 0) + 1),
    );
    final score = requireRomanization
        ? coverage * 3 + idf * 0.3 + romanization * 10
        : coverage * 8 + idf * 0.45;
    if (score > bestScore) {
      best = candidate;
      bestScore = score;
      bestRomanization = romanization;
    }
  }
  if (requireRomanization && bestRomanization < 0.34) return null;
  if (!requireRomanization && verses.length > 1) {
    final coverage = counts[best]! / verses.length;
    if (counts[best]! < 2 || coverage < 0.45) return null;
  }
  return best;
}

bool _isProperName(DictionaryJson entry) {
  for (final raw in entry['senses'] as List<dynamic>? ?? const []) {
    final sense = raw as Map<String, dynamic>;
    final pos = sense['pos']?.toString() ?? '';
    final definition = sense['definition']?.toString().toLowerCase() ?? '';
    if (pos == 'proper_noun' ||
        definition.contains('proper name') ||
        definition.contains('old testament') ||
        definition.contains('new testament')) {
      return true;
    }
  }
  return false;
}

String _meaning(DictionaryJson entry) =>
    entry['korean_meaning']?.toString().trim() ?? '';

void _setMeaning(DictionaryJson entry, String meaning, String koreanVerse) {
  entry['korean_meaning'] = meaning;
  final senses = entry['senses'] as List<dynamic>? ?? const [];
  if (senses.isEmpty) return;
  final first = senses.first as Map<String, dynamic>;
  first['definition_ko'] = meaning;
  first['bible_definition'] = '개역한글 문맥: $koreanVerse';
}

String _normalize(Object? value) =>
    value?.toString().trim().toLowerCase().replaceAll('’', "'") ?? '';

String _normalizeRomanized(String value) => value
    .toLowerCase()
    .replaceAll(RegExp('[^a-z]'), '')
    .replaceAll('ph', 'f')
    .replaceAll('ck', 'k')
    .replaceAll('th', 't')
    .replaceAll('sh', 's')
    .replaceAll('ch', 'j')
    .replaceAll('ee', 'i')
    .replaceAll('oo', 'u');

String _romanizeHangul(String value) {
  const initials = [
    'g',
    'kk',
    'n',
    'd',
    'tt',
    'r',
    'm',
    'b',
    'pp',
    's',
    'ss',
    '',
    'j',
    'jj',
    'ch',
    'k',
    't',
    'p',
    'h',
  ];
  const vowels = [
    'a',
    'ae',
    'ya',
    'yae',
    'eo',
    'e',
    'yeo',
    'ye',
    'o',
    'wa',
    'wae',
    'oe',
    'yo',
    'u',
    'wo',
    'we',
    'wi',
    'yu',
    'eu',
    'ui',
    'i',
  ];
  const finals = [
    '',
    'k',
    'k',
    'ks',
    'n',
    'nj',
    'nh',
    't',
    'l',
    'lk',
    'lm',
    'lp',
    'ls',
    'lt',
    'lp',
    'lh',
    'm',
    'p',
    'ps',
    't',
    't',
    'ng',
    't',
    't',
    'k',
    't',
    'p',
    'h',
  ];
  final output = StringBuffer();
  for (final rune in value.runes) {
    final syllable = rune - 0xAC00;
    if (syllable < 0 || syllable >= 11172) continue;
    output
      ..write(initials[syllable ~/ 588])
      ..write(vowels[(syllable % 588) ~/ 28])
      ..write(finals[syllable % 28]);
  }
  return output.toString();
}

double _similarity(String left, String right) {
  if (left.isEmpty || right.isEmpty) return 0;
  final previous = List<int>.generate(right.length + 1, (index) => index);
  for (var i = 1; i <= left.length; i++) {
    var diagonal = previous[0];
    previous[0] = i;
    for (var j = 1; j <= right.length; j++) {
      final above = previous[j];
      previous[j] = math.min(
        math.min(previous[j] + 1, previous[j - 1] + 1),
        diagonal + (left.codeUnitAt(i - 1) == right.codeUnitAt(j - 1) ? 0 : 1),
      );
      diagonal = above;
    }
  }
  return 1 - previous.last / math.max(left.length, right.length);
}

final class _ParallelVerse {
  const _ParallelVerse({
    required this.englishTokens,
    required this.koreanText,
    required this.koreanTokens,
  });

  final Set<String> englishTokens;
  final String koreanText;
  final Set<String> koreanTokens;
}
