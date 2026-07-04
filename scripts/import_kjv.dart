#!/usr/bin/env dart
// scripts/import_kjv.dart
// ═══════════════════════════════════════════════════════════════
// KJV 성경 JSON → SQLite 임포트 스크립트 (개발자용)
// ═══════════════════════════════════════════════════════════════
//
// 사용법:
//   dart run scripts/import_kjv.dart <input.json> [output_dir]
//
// <input.json> 포맷 (두 가지 모두 지원):
//   포맷 A: [{"b":1,"c":1,"v":1,"t":"In the beginning..."}]
//   포맷 B: [{"book":1,"chapter":1,"verse":1,"text":"..."}]
//
// 공개 도메인 KJV JSON 출처:
//   https://github.com/aruljohn/Bible-kjv
//   https://github.com/scrollmapper/bible_databases
//   https://github.com/openbibleinfo/Bible-Passage-Reference-Parser
//
// 출력:
//   assets/data/kjv_full.json (정규화된 형태로 복사)
//   → 이 파일이 앱 assets 에 번들되어 최초 실행 시 SQLite 로 임포트됨.

import 'dart:convert';
import 'dart:io';

Future<void> main(List<String> args) async {
  if (args.isEmpty) {
    _usage();
    exit(1);
  }

  final inputPath = args[0];
  final outputDir =
      args.length > 1 ? args[1] : 'frontend/assets/data';

  final inputFile = File(inputPath);
  if (!inputFile.existsSync()) {
    stderr.writeln('❌ 파일을 찾을 수 없습니다: $inputPath');
    exit(1);
  }

  stdout.writeln('📖 KJV JSON 임포트 시작…');
  stdout.writeln('   입력: $inputPath');
  stdout.writeln('   출력: $outputDir/kjv_full.json');

  // 로드
  final raw = inputFile.readAsStringSync();
  final List<dynamic> verses;
  try {
    final decoded = jsonDecode(raw);
    if (decoded is List) {
      verses = decoded;
    } else {
      stderr.writeln('❌ 지원하지 않는 JSON 포맷. 배열 형식이어야 합니다.');
      exit(1);
    }
  } catch (e) {
    stderr.writeln('❌ JSON 파싱 오류: $e');
    exit(1);
  }

  stdout.writeln('   총 절 수: ${verses.length}');

  // 정규화 (포맷 A / B 통합 → 포맷 A)
  final normalized = <Map<String, dynamic>>[];
  var errors = 0;

  for (final item in verses) {
    try {
      final map = item as Map<String, dynamic>;
      final b = (map['b'] ?? map['book']) as int?;
      final c = (map['c'] ?? map['chapter']) as int?;
      final v = (map['v'] ?? map['verse']) as int?;
      final t = (map['t'] ?? map['text']) as String?;

      if (b == null || c == null || v == null || t == null) {
        errors++;
        continue;
      }
      if (b < 1 || b > 66 || c < 1 || v < 1) {
        errors++;
        continue;
      }

      normalized.add({'b': b, 'c': c, 'v': v, 't': t.trim()});
    } catch (_) {
      errors++;
    }
  }

  // 정렬 (book → chapter → verse)
  normalized.sort((a, b) {
    final bookCmp = (a['b'] as int).compareTo(b['b'] as int);
    if (bookCmp != 0) return bookCmp;
    final chCmp = (a['c'] as int).compareTo(b['c'] as int);
    if (chCmp != 0) return chCmp;
    return (a['v'] as int).compareTo(b['v'] as int);
  });

  // 출력
  final outputFile =
      File('$outputDir/kjv_full.json');
  await outputFile.parent.create(recursive: true);
  await outputFile.writeAsString(
    jsonEncode(normalized),
    encoding: utf8,
  );

  stdout.writeln('');
  stdout.writeln('✅ 완료!');
  stdout.writeln('   정규화된 절 수: ${normalized.length}');
  if (errors > 0) stdout.writeln('   ⚠️  스킵된 항목: $errors');
  stdout.writeln('   저장 위치: ${outputFile.path}');
  stdout.writeln('');
  stdout.writeln('🔜 다음 단계:');
  stdout.writeln('   1. assets/data/kjv_full.json 을 앱에 포함');
  stdout.writeln('   2. BibleImportService._kjvAssetPath 를 kjv_full.json 으로 변경');
  stdout.writeln('   3. flutter pub run build_runner build');
  stdout.writeln('   4. 앱 실행 → 자동 임포트');
}

void _usage() {
  stdout.writeln('''
KJV Bible JSON Import Script
Usage: dart run scripts/import_kjv.dart <input.json> [output_dir]

Examples:
  dart run scripts/import_kjv.dart ~/Downloads/kjv.json
  dart run scripts/import_kjv.dart ~/Downloads/kjv.json frontend/assets/data

Supported JSON formats:
  Format A: [{"b":1,"c":1,"v":1,"t":"In the beginning..."}]
  Format B: [{"book":1,"chapter":1,"verse":1,"text":"..."}]

Public domain KJV sources:
  - https://github.com/aruljohn/Bible-kjv
  - https://github.com/scrollmapper/bible_databases (kjv.json)
''');
}
