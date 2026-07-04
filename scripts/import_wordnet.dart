#!/usr/bin/env dart
// scripts/import_wordnet.dart
// ═══════════════════════════════════════════════════════════════
// WordNet → 동의어/반의어/관련단어 병합 스크립트 (개발자용)
// ═══════════════════════════════════════════════════════════════
//
// WordNet 3.1 (Princeton) — 공개 도메인 라이선스
//   https://wordnet.princeton.edu/download/current-version
//   또는 JSON 형태:
//   https://github.com/fluhus/wordnet-to-json
//
// 사용법:
//   dart run scripts/import_wordnet.dart <wordnet.json> [base_dict.json] [output_dir]
//
// <wordnet.json> 포맷:
//   {"words":{"grace":{"synonyms":["favor","mercy"],"antonyms":["disgrace"]},...}}
//
// 출처:
//   WordNet 3.1: https://wordnet.princeton.edu/
//   License: WordNet License (free for any use)

import 'dart:convert';
import 'dart:io';

Future<void> main(List<String> args) async {
  if (args.isEmpty) {
    _usage();
    exit(1);
  }

  final wordnetPath = args[0];
  final baseDictPath =
      args.length > 1 ? args[1] : 'frontend/assets/data/dictionary_wiktionary.json';
  final outputDir =
      args.length > 2 ? args[2] : 'frontend/assets/data';

  stdout.writeln('📚 WordNet 동의어/반의어 병합 시작…');

  // WordNet 로드
  final wordnetFile = File(wordnetPath);
  if (!wordnetFile.existsSync()) {
    stderr.writeln('❌ WordNet 파일 없음: $wordnetPath');
    exit(1);
  }

  Map<String, dynamic> wordnetMap;
  try {
    final raw = jsonDecode(wordnetFile.readAsStringSync())
        as Map<String, dynamic>;
    wordnetMap = (raw['words'] as Map<String, dynamic>?) ?? {};
  } catch (e) {
    stderr.writeln('❌ WordNet 파싱 오류: $e');
    exit(1);
  }

  stdout.writeln('   WordNet 단어 수: ${wordnetMap.length}');

  // 기존 사전 로드
  final baseFile = File(baseDictPath);
  List<dynamic> baseDictList;
  if (baseFile.existsSync()) {
    baseDictList = jsonDecode(baseFile.readAsStringSync()) as List<dynamic>;
  } else {
    // Wiktionary 없으면 빈 배열에 WordNet 만 추가
    baseDictList = [];
    for (final entry in wordnetMap.entries) {
      baseDictList.add({
        'word': entry.key,
        'ipa_us': '',
        'ipa_uk': '',
        'frequency_rank': 999999,
        'bible_frequency': 0,
        'etymology': '',
        'senses': [],
        'synonyms': [],
        'antonyms': [],
        'related': [],
        'inflections': [],
      });
    }
  }

  // 병합
  var merged = 0;
  for (final item in baseDictList) {
    final map = item as Map<String, dynamic>;
    final word = map['word'] as String;
    final wn = wordnetMap[word] as Map<String, dynamic>?;
    if (wn == null) continue;

    final syns = (wn['synonyms'] as List<dynamic>? ?? []).cast<String>();
    final ants = (wn['antonyms'] as List<dynamic>? ?? []).cast<String>();
    final related =
        (wn['related'] as List<dynamic>? ?? []).cast<String>();

    // 중복 없이 병합
    final existingSyns =
        (map['synonyms'] as List<dynamic>).cast<String>();
    final existingAnts =
        (map['antonyms'] as List<dynamic>).cast<String>();
    final existingRelated =
        (map['related'] as List<dynamic>).cast<String>();

    map['synonyms'] = [
      ...existingSyns,
      ...syns.where((s) => !existingSyns.contains(s)),
    ].take(8).toList();

    map['antonyms'] = [
      ...existingAnts,
      ...ants.where((a) => !existingAnts.contains(a)),
    ].take(4).toList();

    map['related'] = [
      ...existingRelated,
      ...related.where((r) => !existingRelated.contains(r)),
    ].take(8).toList();

    merged++;
  }

  // 출력
  final outFile =
      File('$outputDir/dictionary_full.json');
  await outFile.parent.create(recursive: true);
  await outFile.writeAsString(jsonEncode(baseDictList), encoding: utf8);

  stdout.writeln('✅ 병합 완료!');
  stdout.writeln('   병합된 단어: $merged');
  stdout.writeln('   총 단어 수: ${baseDictList.length}');
  stdout.writeln('   출력: ${outFile.path}');
}

void _usage() {
  stdout.writeln('''
WordNet Import & Merge Script
Usage: dart run scripts/import_wordnet.dart <wordnet.json> [base_dict.json] [output_dir]

Data sources:
  WordNet 3.1: https://wordnet.princeton.edu/ (free license)
  JSON format: https://github.com/fluhus/wordnet-to-json

Output: assets/data/dictionary_full.json (merged Wiktionary + WordNet)
''');
}
