#!/usr/bin/env dart

import 'dart:async';
import 'dart:convert';
import 'dart:io';

const _bookNames = <String>[
  'Genesis',
  'Exodus',
  'Leviticus',
  'Numbers',
  'Deuteronomy',
  'Joshua',
  'Judges',
  'Ruth',
  '1 Samuel',
  '2 Samuel',
  '1 Kings',
  '2 Kings',
  '1 Chronicles',
  '2 Chronicles',
  'Ezra',
  'Nehemiah',
  'Esther',
  'Job',
  'Psalms',
  'Proverbs',
  'Ecclesiastes',
  'Song of Solomon',
  'Isaiah',
  'Jeremiah',
  'Lamentations',
  'Ezekiel',
  'Daniel',
  'Hosea',
  'Joel',
  'Amos',
  'Obadiah',
  'Jonah',
  'Micah',
  'Nahum',
  'Habakkuk',
  'Zephaniah',
  'Haggai',
  'Zechariah',
  'Malachi',
  'Matthew',
  'Mark',
  'Luke',
  'John',
  'Acts',
  'Romans',
  '1 Corinthians',
  '2 Corinthians',
  'Galatians',
  'Ephesians',
  'Philippians',
  'Colossians',
  '1 Thessalonians',
  '2 Thessalonians',
  '1 Timothy',
  '2 Timothy',
  'Titus',
  'Philemon',
  'Hebrews',
  'James',
  '1 Peter',
  '2 Peter',
  '1 John',
  '2 John',
  '3 John',
  'Jude',
  'Revelation',
];

final _wordPattern = RegExp(r"[A-Za-z]+(?:['’][A-Za-z]+)*");
final _singleWordPattern = RegExp(r"^[A-Za-z]+(?:'[A-Za-z]+)*$");

Future<void> main(List<String> args) async {
  if (args.length < 4) {
    stderr.writeln('''
Usage: dart run scripts/build_offline_dictionary.dart \\
  <kjv_full.json> <ko-extract.jsonl[.gz]> <wordnet-dir> <cmudict> \\
  [output.json] [fallback-map.dart]
''');
    exitCode = 64;
    return;
  }

  final kjvPath = args[0];
  final koreanWiktionaryPath = args[1];
  final wordnetDir = args[2];
  final cmudictPath = args[3];
  final outputPath = args.length > 4
      ? args[4]
      : 'frontend/assets/data/dictionary_full.json';
  final fallbackPath = args.length > 5
      ? args[5]
      : 'frontend/lib/core/data/bible_word_korean_dict.dart';

  _requireFile(kjvPath);
  _requireFile(koreanWiktionaryPath);
  _requireFile(cmudictPath);
  _requireFile('$wordnetDir/index.noun');
  _requireFile(fallbackPath);

  stdout.writeln('1/6 KJV 어휘와 예문 분석');
  final corpus = _readKjvCorpus(kjvPath);
  stdout.writeln('    고유 단어 ${corpus.frequency.length}개');

  stdout.writeln('2/6 한국어 내장 뜻 로드');
  final curatedMeanings = _readCuratedMeanings(fallbackPath);

  stdout.writeln('3/6 WordNet 색인과 활용형 분석');
  final wordnet = _WordNetIndex.load(wordnetDir);
  final resolvedRoots = <String, String>{};
  for (final word in corpus.frequency.keys) {
    resolvedRoots[word] = wordnet.resolveLemma(word) ?? word;
  }
  final roots = resolvedRoots.values.toSet();
  final selectedRefs = <_SenseRef>{};
  for (final root in roots) {
    selectedRefs.addAll(wordnet.references[root] ?? const []);
  }
  final wordnetSenses = wordnet.loadSenses(selectedRefs);

  stdout.writeln('4/6 한국어 위키낱말사전 추출');
  final koreanEntries = await _readKoreanWiktionary(
    koreanWiktionaryPath,
    roots,
  );
  stdout.writeln('    한국어 뜻이 있는 표제어 ${koreanEntries.length}개');

  stdout.writeln('5/6 CMU 발음 사전 추출');
  final pronunciations = _readPronunciations(cmudictPath, roots);
  stdout.writeln('    발음이 있는 표제어 ${pronunciations.length}개');

  stdout.writeln('6/6 통합 사전 생성');
  final entries = _buildEntries(
    corpus: corpus,
    resolvedRoots: resolvedRoots,
    roots: roots,
    curatedMeanings: curatedMeanings,
    koreanEntries: koreanEntries,
    wordnetSenses: wordnetSenses,
    references: wordnet.references,
    pronunciations: pronunciations,
  );

  final output = File(outputPath);
  output.parent.createSync(recursive: true);
  output.writeAsStringSync(jsonEncode(entries), encoding: utf8);

  final resolvedWords = <String>{
    for (final entry in entries) entry['word']! as String,
    for (final entry in entries)
      for (final form in entry['inflections']! as List<dynamic>)
        (form as Map<String, dynamic>)['form']! as String,
  };
  final missing = corpus.frequency.keys
      .where((word) => !resolvedWords.contains(word))
      .toList(growable: false);
  if (missing.isNotEmpty) {
    stderr.writeln('조회 불가능 단어 ${missing.length}개: ${missing.take(30)}');
    exitCode = 1;
    return;
  }

  final koreanCount = entries
      .where((entry) => (entry['korean_meaning']! as String).isNotEmpty)
      .length;
  final definedCount = entries.where((entry) {
    final senses = entry['senses']! as List<dynamic>;
    return senses.any((sense) {
      final map = sense as Map<String, dynamic>;
      return (map['definition']! as String).isNotEmpty ||
          (map['definition_ko']! as String).isNotEmpty;
    });
  }).length;

  stdout.writeln('완료: ${entries.length}개 표제어, ${resolvedWords.length}개 KJV 단어');
  stdout.writeln('      한국어 뜻 $koreanCount개, 사전 정의 $definedCount개');
  stdout.writeln('      ${output.path} (${output.lengthSync()} bytes)');
}

void _requireFile(String path) {
  if (!File(path).existsSync()) {
    throw ArgumentError('필수 파일이 없습니다: $path');
  }
}

String _normalize(String value) {
  var word = value.toLowerCase().replaceAll('’', "'");
  if (word.endsWith("'s") && word.length > 2) {
    word = word.substring(0, word.length - 2);
  }
  return word;
}

_KjvCorpus _readKjvCorpus(String path) {
  final raw = jsonDecode(File(path).readAsStringSync()) as List<dynamic>;
  final frequency = <String, int>{};
  final capitalized = <String, int>{};
  final examples = <String, Map<String, dynamic>>{};

  for (final item in raw) {
    final verse = item as Map<String, dynamic>;
    final text = (verse['t'] ?? verse['text'])! as String;
    for (final match in _wordPattern.allMatches(text)) {
      final original = match.group(0)!;
      final word = _normalize(original);
      if (word.isEmpty) continue;
      frequency.update(word, (value) => value + 1, ifAbsent: () => 1);
      if (_isUppercase(original.codeUnitAt(0))) {
        capitalized.update(word, (value) => value + 1, ifAbsent: () => 1);
      }
      examples.putIfAbsent(word, () {
        final bookId = (verse['b'] ?? verse['book'])! as int;
        final chapter = (verse['c'] ?? verse['chapter'])! as int;
        final verseNumber = (verse['v'] ?? verse['verse'])! as int;
        return {
          'text': text,
          'type': 'bible',
          'ref': '${_bookNames[bookId - 1]} $chapter:$verseNumber',
        };
      });
    }
  }
  return _KjvCorpus(frequency, capitalized, examples);
}

bool _isUppercase(int codeUnit) => codeUnit >= 65 && codeUnit <= 90;

Map<String, String> _readCuratedMeanings(String path) {
  final source = File(path).readAsStringSync();
  final result = <String, String>{};
  final pattern = RegExp(r"'([^']+)':\s*'([^']*)'");
  for (final match in pattern.allMatches(source)) {
    result[_normalize(match.group(1)!)] = match.group(2)!;
  }
  return result;
}

Future<Map<String, _KoreanEntry>> _readKoreanWiktionary(
  String path,
  Set<String> targets,
) async {
  final result = <String, _KoreanEntry>{};
  final bytes = File(path).openRead();
  final decoded = path.endsWith('.gz') ? bytes.transform(gzip.decoder) : bytes;
  final lines = decoded.transform(utf8.decoder).transform(const LineSplitter());
  var scanned = 0;

  await for (final line in lines) {
    scanned++;
    if (scanned % 100000 == 0) stdout.write('.');
    if (!line.contains('"lang_code": "en"')) continue;
    try {
      final map = jsonDecode(line) as Map<String, dynamic>;
      if (map['lang_code'] != 'en') continue;
      final word = _normalize(map['word']?.toString() ?? '');
      if (!targets.contains(word) || !_singleWordPattern.hasMatch(word))
        continue;

      final entry = result.putIfAbsent(word, _KoreanEntry.new);
      entry.etymology = entry.etymology.isEmpty
          ? ((map['etymology_texts'] as List<dynamic>?)?.firstOrNull
                    ?.toString() ??
                '')
          : entry.etymology;
      entry.ipa = entry.ipa.isEmpty ? _extractIpa(map) : entry.ipa;

      final pos = _normalizePos(map['pos']?.toString() ?? 'unknown');
      for (final rawSense in map['senses'] as List<dynamic>? ?? const []) {
        if (entry.senses.length >= 5) break;
        final sense = rawSense as Map<String, dynamic>;
        final glosses = sense['glosses'] as List<dynamic>? ?? const [];
        if (glosses.isEmpty) continue;
        final definition = glosses.first.toString().trim();
        if (definition.isEmpty) continue;
        final examples = <Map<String, dynamic>>[];
        for (final rawExample
            in (sense['examples'] as List<dynamic>? ?? const []).take(2)) {
          final example = rawExample as Map<String, dynamic>;
          final text = example['text']?.toString().trim() ?? '';
          if (text.isNotEmpty) {
            examples.add({
              'text': text,
              'type': 'general',
              'ref': example['ref']?.toString() ?? '',
            });
          }
        }
        entry.senses.add(_KoreanSense(pos, definition, examples));
      }
      for (final rawSynonym in map['synonyms'] as List<dynamic>? ?? const []) {
        final synonym = rawSynonym as Map<String, dynamic>;
        final value = _normalize(synonym['word']?.toString() ?? '');
        if (_singleWordPattern.hasMatch(value) && value != word) {
          entry.synonyms.add(value);
        }
      }
    } catch (_) {
      // 일부 위키낱말사전 행이 손상되어도 나머지 데이터는 계속 처리한다.
    }
  }
  stdout.writeln();
  return result;
}

String _extractIpa(Map<String, dynamic> map) {
  for (final rawSound in map['sounds'] as List<dynamic>? ?? const []) {
    final sound = rawSound as Map<String, dynamic>;
    final ipa = sound['ipa']?.toString().trim() ?? '';
    if (ipa.isNotEmpty) return ipa.startsWith('/') ? ipa : '/$ipa/';
  }
  return '';
}

Map<String, String> _readPronunciations(String path, Set<String> targets) {
  final result = <String, String>{};
  for (final line in File(path).readAsLinesSync()) {
    final fields = line.trim().split(RegExp(r'\s+'));
    if (fields.length < 3) continue;
    final word = _normalize(fields[0]);
    if (!targets.contains(word) || result.containsKey(word)) continue;
    result[word] = _arpabetToIpa(fields.skip(2));
  }
  return result;
}

String _arpabetToIpa(Iterable<String> phones) {
  var primaryStressAdded = false;
  final output = StringBuffer('/');
  for (final raw in phones) {
    final stress = raw.endsWith('1');
    final phone = raw.replaceAll(RegExp(r'[012]$'), '');
    final symbol = _arpabet[phone];
    if (symbol == null) continue;
    if (stress && !primaryStressAdded) {
      output.write('ˈ');
      primaryStressAdded = true;
    }
    output.write(symbol);
  }
  output.write('/');
  return output.toString();
}

List<Map<String, dynamic>> _buildEntries({
  required _KjvCorpus corpus,
  required Map<String, String> resolvedRoots,
  required Set<String> roots,
  required Map<String, String> curatedMeanings,
  required Map<String, _KoreanEntry> koreanEntries,
  required Map<_SenseRef, _WordNetSense> wordnetSenses,
  required Map<String, List<_SenseRef>> references,
  required Map<String, String> pronunciations,
}) {
  final formsByRoot = <String, Set<String>>{};
  final frequencyByRoot = <String, int>{};
  final capitalizedByRoot = <String, int>{};
  final exampleByRoot = <String, Map<String, dynamic>>{};
  for (final item in resolvedRoots.entries) {
    final word = item.key;
    final root = item.value;
    if (root != word) formsByRoot.putIfAbsent(root, () => {}).add(word);
    frequencyByRoot.update(
      root,
      (value) => value + corpus.frequency[word]!,
      ifAbsent: () => corpus.frequency[word]!,
    );
    capitalizedByRoot.update(
      root,
      (value) => value + (corpus.capitalized[word] ?? 0),
      ifAbsent: () => corpus.capitalized[word] ?? 0,
    );
    exampleByRoot.putIfAbsent(root, () => corpus.examples[word]!);
  }

  final rankedRoots = roots.toList()
    ..sort((a, b) => frequencyByRoot[b]!.compareTo(frequencyByRoot[a]!));
  final rank = <String, int>{
    for (var i = 0; i < rankedRoots.length; i++) rankedRoots[i]: i + 1,
  };

  final entries = <Map<String, dynamic>>[];
  for (final root in roots.toList()..sort()) {
    final korean = koreanEntries[root];
    final wordnet = (references[root] ?? const [])
        .map((ref) => wordnetSenses[ref])
        .whereType<_WordNetSense>()
        .take(5)
        .toList();
    final curated = curatedMeanings[root] ?? '';
    final koreanDefinitions = <String>[
      if (curated.isNotEmpty) curated,
      ...?korean?.senses.map((sense) => sense.definition),
    ].toSet().toList();
    final totalFrequency = frequencyByRoot[root]!;
    final capitalized = capitalizedByRoot[root] ?? 0;
    final likelyProperName = capitalized / totalFrequency >= 0.7;

    final senses = <Map<String, dynamic>>[];
    if (curated.isNotEmpty) {
      senses.add(
        _senseJson(
          pos:
              wordnet.firstOrNull?.pos ??
              korean?.senses.firstOrNull?.pos ??
              'unknown',
          order: senses.length + 1,
          definition: wordnet.firstOrNull?.definition ?? '',
          definitionKo: curated,
          isArchaic: _isArchaic(root),
          examples: [exampleByRoot[root]!],
        ),
      );
    }
    for (final sense in korean?.senses ?? const <_KoreanSense>[]) {
      if (senses.length >= 5 || sense.definition == curated) continue;
      senses.add(
        _senseJson(
          pos: sense.pos,
          order: senses.length + 1,
          definition: '',
          definitionKo: sense.definition,
          isArchaic: _isArchaic(root),
          examples: sense.examples,
        ),
      );
    }
    for (final sense in wordnet) {
      if (senses.length >= 6) break;
      if (senses.any((item) => item['definition'] == sense.definition))
        continue;
      senses.add(
        _senseJson(
          pos: sense.pos,
          order: senses.length + 1,
          definition: sense.definition,
          definitionKo: '',
          isArchaic: _isArchaic(root),
          examples: sense.examples
              .map((text) => {'text': text, 'type': 'general', 'ref': ''})
              .toList(),
        ),
      );
    }
    if (senses.isEmpty) {
      senses.add(
        _senseJson(
          pos: likelyProperName ? 'proper_noun' : 'unknown',
          order: 1,
          definition: likelyProperName
              ? 'A proper name used in the King James Version.'
              : 'An archaic or specialized word form used in the King James Version.',
          definitionKo: likelyProperName
              ? '킹제임스 성경에 등장하는 인명 또는 지명'
              : '킹제임스 성경에서 사용된 고어 또는 고유 표현',
          isArchaic: !likelyProperName,
          examples: [exampleByRoot[root]!],
        ),
      );
      koreanDefinitions.add(senses.first['definition_ko']! as String);
    } else if (senses.every(
      (sense) => (sense['examples']! as List<dynamic>).isEmpty,
    )) {
      (senses.first['examples']! as List<dynamic>).add(exampleByRoot[root]!);
    }

    final synonyms =
        <String>{
            ...?korean?.synonyms,
            for (final sense in wordnet) ...sense.synonyms,
          }
          ..remove(root)
          ..removeWhere((word) => word.contains(' ') || word.contains('_'));

    entries.add({
      'word': root,
      'korean_meaning': koreanDefinitions.take(4).join('; '),
      'ipa_us': korean?.ipa.isNotEmpty == true
          ? korean!.ipa
          : pronunciations[root] ?? '',
      'ipa_uk': '',
      'frequency_rank': rank[root],
      'bible_frequency': totalFrequency,
      'etymology': korean?.etymology ?? '',
      'senses': senses,
      'synonyms': synonyms.take(12).toList(),
      'antonyms': const <String>[],
      'related': const <String>[],
      'inflections': [
        for (final form
            in (formsByRoot[root] ?? const <String>{}).toList()..sort())
          {'type': _formType(form, root), 'form': form},
      ],
    });
  }
  return entries;
}

Map<String, dynamic> _senseJson({
  required String pos,
  required int order,
  required String definition,
  required String definitionKo,
  required bool isArchaic,
  required List<Map<String, dynamic>> examples,
}) => {
  'pos': pos,
  'order': order,
  'definition': definition,
  'definition_ko': definitionKo,
  'bible_definition': '',
  'is_archaic': isArchaic,
  'register': isArchaic ? 'archaic' : '',
  'examples': <Map<String, dynamic>>[...examples],
};

bool _isArchaic(String word) =>
    word.endsWith('eth') || word.endsWith('est') || word == 'thou';

String _formType(String form, String root) {
  if (form.endsWith('ing')) return 'present_participle';
  if (form.endsWith('ed')) return 'past_tense';
  if (form.endsWith('eth') || form.endsWith('est')) return 'archaic_form';
  if (form.endsWith('s')) return 'plural_or_third_person';
  return 'inflected_form';
}

String _normalizePos(String pos) => switch (pos) {
  'n' || 'noun' => 'noun',
  'v' || 'verb' => 'verb',
  'a' || 's' || 'adj' => 'adjective',
  'r' || 'adv' => 'adverb',
  'pron' => 'pronoun',
  'prep' => 'preposition',
  'conj' => 'conjunction',
  'det' => 'article',
  'num' => 'numeral',
  'name' || 'proper_noun' => 'proper_noun',
  _ => pos.isEmpty ? 'unknown' : pos,
};

final class _WordNetIndex {
  _WordNetIndex(this.directory, this.references, this.exceptions);

  factory _WordNetIndex.load(String directory) {
    final references = <String, List<_SenseRef>>{};
    final exceptions = <String, String>{};
    for (final pos in const ['noun', 'verb', 'adj', 'adv']) {
      final posCode = switch (pos) {
        'noun' => 'n',
        'verb' => 'v',
        'adj' => 'a',
        _ => 'r',
      };
      for (final line in File('$directory/index.$pos').readAsLinesSync()) {
        if (line.isEmpty || line.startsWith(' ')) continue;
        final fields = line.trim().split(RegExp(r'\s+'));
        if (fields.length < 7) continue;
        final lemma = fields[0].replaceAll('_', ' ').toLowerCase();
        if (lemma.contains(' ')) continue;
        final synsetCount = int.tryParse(fields[2]) ?? 0;
        final pointerCount = int.tryParse(fields[3]) ?? 0;
        final offsetStart = 6 + pointerCount;
        if (offsetStart + synsetCount > fields.length) continue;
        final refs = references.putIfAbsent(lemma, () => []);
        for (var i = 0; i < synsetCount; i++) {
          refs.add(_SenseRef(posCode, fields[offsetStart + i]));
        }
      }
      for (final line in File('$directory/$pos.exc').readAsLinesSync()) {
        final fields = line.trim().split(RegExp(r'\s+'));
        if (fields.length >= 2) exceptions[fields[0]] = fields[1];
      }
    }
    return _WordNetIndex(directory, references, exceptions);
  }

  final String directory;
  final Map<String, List<_SenseRef>> references;
  final Map<String, String> exceptions;

  String? resolveLemma(String word) {
    if (references.containsKey(word)) return word;
    final exception = exceptions[word];
    if (exception != null && references.containsKey(exception))
      return exception;
    for (final candidate in _lemmaCandidates(word)) {
      if (references.containsKey(candidate)) return candidate;
    }
    return null;
  }

  Map<_SenseRef, _WordNetSense> loadSenses(Set<_SenseRef> selected) {
    final result = <_SenseRef, _WordNetSense>{};
    for (final item in const {
      'noun': 'n',
      'verb': 'v',
      'adj': 'a',
      'adv': 'r',
    }.entries) {
      for (final line in File(
        '$directory/data.${item.key}',
      ).readAsLinesSync()) {
        if (line.isEmpty ||
            line.codeUnitAt(0) < 48 ||
            line.codeUnitAt(0) > 57) {
          continue;
        }
        final separator = line.indexOf('|');
        if (separator < 0) continue;
        final fields = line
            .substring(0, separator)
            .trim()
            .split(RegExp(r'\s+'));
        if (fields.length < 5) continue;
        final ref = _SenseRef(item.value, fields[0]);
        if (!selected.contains(ref)) continue;
        final wordCount = int.parse(fields[3], radix: 16);
        final synonyms = <String>[];
        for (var i = 0; i < wordCount; i++) {
          synonyms.add(fields[4 + i * 2].replaceAll('_', ' '));
        }
        final gloss = line.substring(separator + 1).trim();
        final definition = gloss.split(';').first.trim();
        final examples = RegExp(
          r'"([^"]+)"',
        ).allMatches(gloss).map((match) => match.group(1)!).take(2).toList();
        result[ref] = _WordNetSense(
          _normalizePos(item.value),
          definition,
          synonyms,
          examples,
        );
      }
    }
    return result;
  }
}

Iterable<String> _lemmaCandidates(String word) sync* {
  final candidates = <String>{};
  void add(String value) {
    if (value.length > 1) candidates.add(value);
  }

  const irregularKjv = {
    'art': 'be',
    'hast': 'have',
    'hath': 'have',
    'dost': 'do',
    'doth': 'do',
    'shalt': 'shall',
    'wilt': 'will',
    'wast': 'be',
    'wert': 'be',
  };
  final irregular = irregularKjv[word];
  if (irregular != null) add(irregular);

  if (word.endsWith('ies')) add('${word.substring(0, word.length - 3)}y');
  if (word.endsWith('es')) {
    add(word.substring(0, word.length - 2));
    add(word.substring(0, word.length - 1));
  }
  if (word.endsWith('s')) add(word.substring(0, word.length - 1));
  if (word.endsWith('ed')) {
    final stem = word.substring(0, word.length - 2);
    add(stem);
    add('${stem}e');
    add(_withoutDoubledConsonant(stem));
  }
  if (word.endsWith('ing')) {
    final stem = word.substring(0, word.length - 3);
    add(stem);
    add('${stem}e');
    add(_withoutDoubledConsonant(stem));
  }
  if (word.endsWith('eth')) {
    final stem = word.substring(0, word.length - 3);
    add(stem);
    add('${stem}e');
    add(_withoutDoubledConsonant(stem));
  }
  if (word.endsWith('est')) {
    final stem = word.substring(0, word.length - 3);
    add(stem);
    add('${stem}e');
    add(_withoutDoubledConsonant(stem));
  }
  yield* candidates;
}

String _withoutDoubledConsonant(String value) {
  if (value.length < 2) return value;
  final last = value[value.length - 1];
  return value[value.length - 2] == last
      ? value.substring(0, value.length - 1)
      : value;
}

final class _KjvCorpus {
  const _KjvCorpus(this.frequency, this.capitalized, this.examples);
  final Map<String, int> frequency;
  final Map<String, int> capitalized;
  final Map<String, Map<String, dynamic>> examples;
}

final class _KoreanEntry {
  String ipa = '';
  String etymology = '';
  final senses = <_KoreanSense>[];
  final synonyms = <String>{};
}

final class _KoreanSense {
  const _KoreanSense(this.pos, this.definition, this.examples);
  final String pos;
  final String definition;
  final List<Map<String, dynamic>> examples;
}

final class _SenseRef {
  const _SenseRef(this.pos, this.offset);
  final String pos;
  final String offset;

  @override
  bool operator ==(Object other) =>
      other is _SenseRef && other.pos == pos && other.offset == offset;

  @override
  int get hashCode => Object.hash(pos, offset);
}

final class _WordNetSense {
  const _WordNetSense(this.pos, this.definition, this.synonyms, this.examples);
  final String pos;
  final String definition;
  final List<String> synonyms;
  final List<String> examples;
}

const _arpabet = <String, String>{
  'AA': 'ɑ',
  'AE': 'æ',
  'AH': 'ʌ',
  'AO': 'ɔ',
  'AW': 'aʊ',
  'AY': 'aɪ',
  'EH': 'ɛ',
  'ER': 'ɝ',
  'EY': 'eɪ',
  'IH': 'ɪ',
  'IY': 'i',
  'OW': 'oʊ',
  'OY': 'ɔɪ',
  'UH': 'ʊ',
  'UW': 'u',
  'B': 'b',
  'CH': 'tʃ',
  'D': 'd',
  'DH': 'ð',
  'F': 'f',
  'G': 'ɡ',
  'HH': 'h',
  'JH': 'dʒ',
  'K': 'k',
  'L': 'l',
  'M': 'm',
  'N': 'n',
  'NG': 'ŋ',
  'P': 'p',
  'R': 'ɹ',
  'S': 's',
  'SH': 'ʃ',
  'T': 't',
  'TH': 'θ',
  'V': 'v',
  'W': 'w',
  'Y': 'j',
  'Z': 'z',
  'ZH': 'ʒ',
};

extension<T> on List<T> {
  T? get firstOrNull => isEmpty ? null : first;
}
