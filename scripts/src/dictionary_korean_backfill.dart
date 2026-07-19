import 'bible_korean_supplement.dart';

typedef DictionaryJson = Map<String, dynamic>;

void removeGeneratedKoreanClassifications(List<DictionaryJson> entries) {
  const generated = {
    '성경의 책 이름',
    '성경에 등장하는 인명 또는 지명',
    '킹제임스 성경에 등장하는 인명 또는 지명',
    '킹제임스 성경에서 사용된 고어 또는 고유 표현',
    '킹제임스 성경에서 사용되는 고어 또는 특수 표현',
    '성경 문맥에서 사용되는 동사',
    '성경 문맥에서 사용되는 형용사',
    '성경 문맥에서 사용되는 부사',
    '성경 문맥에서 사용되는 명사',
    '킹제임스 성경에서 사용되는 영어 표현',
  };
  for (final entry in entries) {
    final current = entry['korean_meaning']?.toString() ?? '';
    final isGenerated =
        generated.contains(current) ||
        current.startsWith('개역한글 문맥:') ||
        current.endsWith('(개역한글 문맥)');
    if (!isGenerated) continue;
    entry['korean_meaning'] = '';
    for (final rawSense in entry['senses'] as List<dynamic>? ?? const []) {
      final sense = rawSense as Map<String, dynamic>;
      if (sense['definition_ko'] == current) sense['definition_ko'] = '';
    }
  }
}

final class KoreanBackfillReport {
  const KoreanBackfillReport({
    required this.inherited,
    required this.classified,
  });

  final int inherited;
  final int classified;
  int get total => inherited + classified;
}

void correctGeneratedDictionaryRoots(List<DictionaryJson> entries) {
  final byWord = <String, DictionaryJson>{
    for (final entry in entries) _normalize(entry['word']): entry,
  };
  final removed = <DictionaryJson>{};

  for (final correction in generatedRootCorrections.entries) {
    final source = byWord[correction.key];
    if (source == null) continue;
    final target = byWord[correction.value];
    if (target == null) {
      source['word'] = correction.value;
      byWord[correction.value] = source;
      continue;
    }

    target['bible_frequency'] =
        _integer(target['bible_frequency']) +
        _integer(source['bible_frequency']);
    target['frequency_rank'] = [
      _integer(target['frequency_rank'], fallback: 999999),
      _integer(source['frequency_rank'], fallback: 999999),
    ].reduce((left, right) => left < right ? left : right);
    _mergeInflections(target, source);
    removed.add(source);
  }

  entries.removeWhere(removed.contains);
}

void applyBibleKoreanSupplements(List<DictionaryJson> entries) {
  for (final entry in entries) {
    final meaning = bibleKoreanSupplement[_normalize(entry['word'])];
    if (meaning == null) continue;
    entry['korean_meaning'] = meaning;
    final senses = entry['senses'] as List<dynamic>? ?? const [];
    if (senses.isNotEmpty) {
      (senses.first as Map<String, dynamic>)['definition_ko'] = meaning;
    }
  }
}

void _mergeInflections(DictionaryJson target, DictionaryJson source) {
  final targetForms = (target['inflections'] as List<dynamic>? ?? <dynamic>[])
      .cast<Map<String, dynamic>>();
  final known = <String>{
    for (final form in targetForms) _normalize(form['form']),
  };
  for (final rawForm in source['inflections'] as List<dynamic>? ?? const []) {
    final form = rawForm as Map<String, dynamic>;
    if (known.add(_normalize(form['form']))) targetForms.add(form);
  }
  target['inflections'] = targetForms;
}

int _integer(Object? value, {int fallback = 0}) =>
    value is int ? value : int.tryParse(value?.toString() ?? '') ?? fallback;

KoreanBackfillReport backfillKoreanMeanings(
  List<DictionaryJson> entries, {
  Map<String, String> curatedMeanings = const {},
  bool classifyMissing = true,
}) {
  final byWord = <String, DictionaryJson>{
    for (final entry in entries) _normalize(entry['word']): entry,
  };
  final formToRoot = <String, String>{};
  for (final entry in entries) {
    final root = _normalize(entry['word']);
    for (final rawForm in entry['inflections'] as List<dynamic>? ?? const []) {
      final form = _normalize((rawForm as Map<String, dynamic>)['form']);
      if (form.isNotEmpty) formToRoot.putIfAbsent(form, () => root);
    }
  }

  var inherited = 0;
  for (var pass = 0; pass < 4; pass++) {
    var changed = 0;
    for (final entry in entries) {
      if (_meaningOf(entry).isNotEmpty) continue;
      final word = _normalize(entry['word']);
      final resolved = _resolveInheritedMeaning(
        word,
        entry,
        byWord,
        formToRoot,
        curatedMeanings,
      );
      if (resolved == null) continue;
      _setMeaning(entry, resolved.$1, hint: _formHint(word, resolved.$2));
      inherited++;
      changed++;
    }
    if (changed == 0) break;
  }

  var classified = 0;
  if (!classifyMissing) {
    return KoreanBackfillReport(inherited: inherited, classified: 0);
  }
  for (final entry in entries) {
    if (_meaningOf(entry).isNotEmpty) continue;
    _setMeaning(entry, _koreanClassification(entry));
    classified++;
  }

  return KoreanBackfillReport(inherited: inherited, classified: classified);
}

(String, String)? _resolveInheritedMeaning(
  String word,
  DictionaryJson entry,
  Map<String, DictionaryJson> byWord,
  Map<String, String> formToRoot,
  Map<String, String> curated,
) {
  final directCurated = curated[word]?.trim() ?? '';
  if (directCurated.isNotEmpty) return (directCurated, word);

  final candidates = <String>{
    if (formToRoot[word] case final root?) root,
    ..._lemmaCandidates(word),
    ..._relatedWords(entry, 'synonyms'),
    ..._relatedWords(entry, 'related'),
  };
  for (final candidate in candidates) {
    final curatedMeaning = curated[candidate]?.trim() ?? '';
    if (curatedMeaning.isNotEmpty) return (curatedMeaning, candidate);
    final candidateEntry = byWord[candidate];
    if (candidateEntry == null) continue;
    final meaning = _meaningOf(candidateEntry);
    if (meaning.isNotEmpty) return (meaning, candidate);
  }
  return null;
}

Iterable<String> _relatedWords(DictionaryJson entry, String key) sync* {
  for (final value in entry[key] as List<dynamic>? ?? const []) {
    final normalized = _normalize(value);
    if (normalized.isNotEmpty && !normalized.contains(' ')) yield normalized;
  }
}

Iterable<String> _lemmaCandidates(String word) sync* {
  const irregular = <String, String>{
    'am': 'be',
    'are': 'be',
    'art': 'be',
    'been': 'be',
    'is': 'be',
    'was': 'be',
    'wast': 'be',
    'were': 'be',
    'wert': 'be',
    'had': 'have',
    'has': 'have',
    'hast': 'have',
    'hath': 'have',
    'did': 'do',
    'done': 'do',
    'does': 'do',
    'dost': 'do',
    'doth': 'do',
    'went': 'go',
    'gone': 'go',
    'said': 'say',
    'saidst': 'say',
    'saith': 'say',
    'shalt': 'shall',
    'wilt': 'will',
    'wrought': 'work',
  };
  final result = <String>{};
  void add(String value) {
    if (value.length > 1 && value != word) result.add(value);
  }

  final irregularRoot = irregular[word];
  if (irregularRoot != null) add(irregularRoot);
  if (word.endsWith('ies')) add('${word.substring(0, word.length - 3)}y');
  if (word.endsWith('edst') && word.length > 5) {
    add(word.substring(0, word.length - 4));
  }
  if (word.endsWith('ieth')) {
    add('${word.substring(0, word.length - 4)}y');
  }
  if (word.endsWith('ied')) add('${word.substring(0, word.length - 3)}y');
  if (word.endsWith('es')) {
    add(word.substring(0, word.length - 2));
    add(word.substring(0, word.length - 1));
  }
  if (word.endsWith('s')) add(word.substring(0, word.length - 1));
  if (word.endsWith('men') && word.length > 4) {
    add('${word.substring(0, word.length - 3)}man');
  }
  for (final suffix in const ['ed', 'eth', 'est']) {
    if (!word.endsWith(suffix) || word.length <= suffix.length + 1) continue;
    final stem = word.substring(0, word.length - suffix.length);
    add(stem);
    add('${stem}e');
    add(_withoutDoubledConsonant(stem));
  }
  if (word.endsWith('ing') && word.length > 5) {
    final stem = word.substring(0, word.length - 3);
    add(stem);
    add('${stem}e');
    add(_withoutDoubledConsonant(stem));
  }
  if (word.endsWith('ly') && word.length > 4) {
    final stem = word.substring(0, word.length - 2);
    add(stem);
    if (stem.endsWith('i')) add('${stem.substring(0, stem.length - 1)}y');
    add('${stem}le');
  }
  if (word.endsWith('er') && word.length > 4) {
    final stem = word.substring(0, word.length - 2);
    add(stem);
    add('${stem}e');
  }
  if (word.endsWith('or') && word.length > 4) {
    add(word.substring(0, word.length - 2));
  }
  for (final suffix in const ['ness', 'ship', 'ment']) {
    if (!word.endsWith(suffix) || word.length <= suffix.length + 1) continue;
    final stem = word.substring(0, word.length - suffix.length);
    add(stem);
    if (stem.endsWith('i')) add('${stem.substring(0, stem.length - 1)}y');
  }
  for (final suffix in const ['ful', 'less', 'ish']) {
    if (word.endsWith(suffix) && word.length > suffix.length + 1) {
      add(word.substring(0, word.length - suffix.length));
    }
  }
  if (word.contains('our')) {
    add(word.replaceFirst('our', 'or'));
  }
  const historicalSpellings = <String, String>{
    'baken': 'bake',
    'cloke': 'cloak',
    'compleat': 'complete',
    'ensample': 'example',
    'intreat': 'entreat',
    'morter': 'mortar',
    'plaister': 'plaster',
    'recompence': 'recompense',
    'shew': 'show',
    'stedfast': 'steadfast',
    'stablish': 'establish',
    'throughly': 'thoroughly',
    'withholden': 'withhold',
  };
  final modernSpelling = historicalSpellings[word];
  if (modernSpelling != null) add(modernSpelling);
  yield* result;
}

String _withoutDoubledConsonant(String value) {
  if (value.length < 2) return value;
  final last = value[value.length - 1];
  return value[value.length - 2] == last
      ? value.substring(0, value.length - 1)
      : value;
}

String _meaningOf(DictionaryJson entry) {
  final direct = entry['korean_meaning']?.toString().trim() ?? '';
  if (direct.isNotEmpty) return direct;
  for (final rawSense in entry['senses'] as List<dynamic>? ?? const []) {
    final sense = rawSense as Map<String, dynamic>;
    final meaning = sense['definition_ko']?.toString().trim() ?? '';
    if (meaning.isNotEmpty) return meaning;
  }
  return '';
}

void _setMeaning(DictionaryJson entry, String meaning, {String hint = ''}) {
  final display = hint.isEmpty ? meaning : '$meaning ($hint)';
  entry['korean_meaning'] = display;
  final senses = entry['senses'] as List<dynamic>? ?? const [];
  if (senses.isNotEmpty) {
    final first = senses.first as Map<String, dynamic>;
    if ((first['definition_ko']?.toString().trim() ?? '').isEmpty) {
      first['definition_ko'] = display;
    }
  }
}

String _formHint(String word, String root) {
  if (word == root) return '';
  if (word.endsWith('ing')) return '동명사·현재분사형';
  if (word.endsWith('ed') || word.endsWith('ied')) return '과거·과거분사형';
  if (word.endsWith('ly')) return '부사형';
  if (word.endsWith('s') || word.endsWith('eth')) return '활용형';
  return '관련 의미';
}

String _koreanClassification(DictionaryJson entry) {
  final senses = entry['senses'] as List<dynamic>? ?? const [];
  final definitions = senses
      .map(
        (raw) => (raw as Map<String, dynamic>)['definition']?.toString() ?? '',
      )
      .join(' ')
      .toLowerCase();
  final positions = senses
      .map((raw) => (raw as Map<String, dynamic>)['pos']?.toString() ?? '')
      .toSet();
  final isArchaic = senses.any(
    (raw) => (raw as Map<String, dynamic>)['is_archaic'] == true,
  );

  if (definitions.contains('new testament book') ||
      definitions.contains('old testament book')) {
    return '성경의 책 이름';
  }
  if (positions.contains('proper_noun') ||
      definitions.contains('old testament') ||
      definitions.contains('new testament') ||
      definitions.contains('biblical')) {
    return '성경에 등장하는 인명 또는 지명';
  }
  if (isArchaic || definitions.contains('archaic')) {
    return '킹제임스 성경에서 사용되는 고어 또는 특수 표현';
  }
  if (positions.contains('verb')) return '성경 문맥에서 사용되는 동사';
  if (positions.contains('adjective')) return '성경 문맥에서 사용되는 형용사';
  if (positions.contains('adverb')) return '성경 문맥에서 사용되는 부사';
  if (positions.contains('noun')) return '성경 문맥에서 사용되는 명사';
  return '킹제임스 성경에서 사용되는 영어 표현';
}

String _normalize(Object? value) =>
    value?.toString().trim().toLowerCase().replaceAll('’', "'") ?? '';
