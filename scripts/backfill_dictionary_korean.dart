import 'dart:convert';
import 'dart:io';

import 'src/bible_korean_supplement.dart';
import 'src/dictionary_korean_backfill.dart';
import 'src/stardict_reader.dart';

void main(List<String> args) {
  final dictionaryPath = args.isNotEmpty
      ? args.first
      : 'frontend/assets/data/dictionary_full.json';
  final curatedPath = args.length > 1
      ? args[1]
      : 'frontend/lib/core/data/bible_word_korean_dict.dart';
  final dictionaryFile = File(dictionaryPath);
  final entries = (jsonDecode(dictionaryFile.readAsStringSync()) as List)
      .cast<DictionaryJson>();
  final curated = <String, String>{};
  if (args.length > 2) {
    final starDict = readStarDict(args[2]);
    curated.addAll(starDict);
    stdout.writeln('StarDict 한국어 뜻 ${starDict.length}개 로드');
  }
  curated
    ..addAll(_readCuratedMeanings(File(curatedPath)))
    ..addAll(bibleKoreanSupplement);
  correctGeneratedDictionaryRoots(entries);
  applyBibleKoreanSupplements(entries);
  _removeGeneratedClassifications(entries);
  final report = backfillKoreanMeanings(entries, curatedMeanings: curated);
  dictionaryFile.writeAsStringSync(jsonEncode(entries), encoding: utf8);
  stdout.writeln(
    '한국어 뜻 보강 ${report.total}개 '
    '(뜻 승계 ${report.inherited}, 문맥 분류 ${report.classified})',
  );
}

void _removeGeneratedClassifications(List<DictionaryJson> entries) {
  const generated = {
    '성경의 책 이름',
    '성경에 등장하는 인명 또는 지명',
    '킹제임스 성경에서 사용되는 고어 또는 특수 표현',
    '성경 문맥에서 사용되는 동사',
    '성경 문맥에서 사용되는 형용사',
    '성경 문맥에서 사용되는 부사',
    '성경 문맥에서 사용되는 명사',
    '킹제임스 성경에서 사용되는 영어 표현',
  };
  for (final entry in entries) {
    final current = entry['korean_meaning']?.toString() ?? '';
    if (!generated.contains(current)) continue;
    entry['korean_meaning'] = '';
    for (final rawSense in entry['senses'] as List<dynamic>? ?? const []) {
      final sense = rawSense as Map<String, dynamic>;
      if (sense['definition_ko'] == current) sense['definition_ko'] = '';
    }
  }
}

Map<String, String> _readCuratedMeanings(File file) {
  final result = <String, String>{};
  final pattern = RegExp(
    r"^\s*'((?:\\'|[^'])+)'\s*:\s*'((?:\\'|[^'])*)',?\s*$",
  );
  for (final line in file.readAsLinesSync()) {
    final match = pattern.firstMatch(line);
    if (match == null) continue;
    result[match.group(1)!.replaceAll(r"\'", "'")] = match
        .group(2)!
        .replaceAll(r"\'", "'");
  }
  return result;
}
