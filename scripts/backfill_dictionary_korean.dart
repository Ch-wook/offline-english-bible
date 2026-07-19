import 'dart:convert';
import 'dart:io';

import 'src/bible_korean_supplement.dart';
import 'src/dictionary_korean_backfill.dart';
import 'src/parallel_bible_korean_enricher.dart';
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
  removeGeneratedKoreanClassifications(entries);
  final inheritedReport = backfillKoreanMeanings(
    entries,
    curatedMeanings: curated,
    classifyMissing: false,
  );
  final parallelReport = enrichFromParallelBible(
    entries: entries,
    kjvPath: 'frontend/assets/data/kjv_full.json',
    koreanPath: 'frontend/assets/data/korean_rv_full.json',
  );
  final report = backfillKoreanMeanings(entries, curatedMeanings: curated);
  dictionaryFile.writeAsStringSync(jsonEncode(entries), encoding: utf8);
  stdout.writeln(
    '한국어 뜻 보강 '
    '${inheritedReport.inherited + parallelReport.total + report.total}개 '
    '(사전·원형 ${inheritedReport.inherited}, '
    '성경 이름 ${parallelReport.properNames}, '
    '병렬 문맥 ${parallelReport.contextMeanings}, '
    '최종 분류 ${report.classified})',
  );
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
