#!/usr/bin/env dart
// scripts/import_korean_rv.dart
// ═══════════════════════════════════════════════════════════════
// 개역한글 JSON → 정규화 스크립트 (개발자용)
// ═══════════════════════════════════════════════════════════════
//
// 사용법:
//   dart run scripts/import_korean_rv.dart <input.json> [output_dir]
//
// 개역한글 공개 도메인 소스:
//   https://github.com/MongooseOrion/kor-bible
//   https://github.com/luwrain/bible  (SWORD Korean RV)
//
// 포맷: [{"b":1,"c":1,"v":1,"t":"태초에 하나님이..."}]

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

  stdout.writeln('📖 개역한글 JSON 임포트 시작…');

  final raw = inputFile.readAsStringSync();
  final List<dynamic> verses;
  try {
    final decoded = jsonDecode(raw);
    verses = decoded is List ? decoded : [];
  } catch (e) {
    stderr.writeln('❌ JSON 파싱 오류: $e');
    exit(1);
  }

  stdout.writeln('   총 절 수: ${verses.length}');

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

  normalized.sort((a, b) {
    final bc = (a['b'] as int).compareTo(b['b'] as int);
    if (bc != 0) return bc;
    final cc = (a['c'] as int).compareTo(b['c'] as int);
    if (cc != 0) return cc;
    return (a['v'] as int).compareTo(b['v'] as int);
  });

  final outputFile = File('$outputDir/korean_rv_full.json');
  await outputFile.parent.create(recursive: true);
  await outputFile.writeAsString(jsonEncode(normalized), encoding: utf8);

  stdout.writeln('✅ 완료! ${normalized.length}절 저장됨');
  if (errors > 0) stdout.writeln('   ⚠️  스킵: $errors');
}

void _usage() {
  stdout.writeln('''
개역한글 Bible JSON Import Script
Usage: dart run scripts/import_korean_rv.dart <input.json> [output_dir]

Public domain Korean Bible sources:
  - https://github.com/MongooseOrion/kor-bible
''');
}
