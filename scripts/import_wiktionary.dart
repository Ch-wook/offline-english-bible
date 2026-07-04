#!/usr/bin/env dart
// scripts/import_wiktionary.dart
// ═══════════════════════════════════════════════════════════════
// Wiktionary → 사전 JSON 변환 스크립트 (개발자용)
// ═══════════════════════════════════════════════════════════════
//
// Wiktionary 오픈 소스 데이터 (CC BY-SA 4.0):
//   https://kaikki.org/dictionary/English/
//   → kaikki.org-dictionary-English.jsonl (English Wiktionary dump)
//
// 사용법:
//   dart run scripts/import_wiktionary.dart <kaikki_dump.jsonl> [output_dir]
//
// 출력: assets/data/dictionary_wiktionary.json
// 형식: [{"word":"...","ipa_us":"...","senses":[...],...}]
//
// 주의: 전체 덤프는 ~900MB. 처리에 수분 소요.

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

  stdout.writeln('📚 Wiktionary 덤프 처리 시작…');
  stdout.writeln('   입력: $inputPath');
  stdout.writeln('   ⚠️  주의: 전체 덤프 처리는 수분이 소요됩니다.');

  final output = <Map<String, dynamic>>[];
  var processed = 0;
  var skipped = 0;

  await for (final line in inputFile
      .openRead()
      .transform(utf8.decoder)
      .transform(const LineSplitter())) {
    if (line.trim().isEmpty) continue;

    try {
      final map = jsonDecode(line) as Map<String, dynamic>;

      // 영어 항목만 처리
      final lang = map['lang'] as String? ?? '';
      if (lang != 'English') {
        skipped++;
        continue;
      }

      final word = map['word'] as String? ?? '';
      if (word.isEmpty || word.contains(' ')) {
        skipped++;
        continue;
      }

      // IPA 추출
      String ipaUs = '';
      String ipaUk = '';
      final sounds = map['sounds'] as List<dynamic>? ?? [];
      for (final s in sounds) {
        final sm = s as Map<String, dynamic>;
        final ipa = sm['ipa'] as String? ?? '';
        if (ipa.isEmpty) continue;
        final tags =
            (sm['tags'] as List<dynamic>? ?? []).cast<String>();
        if (tags.contains('US') || tags.contains('General American')) {
          ipaUs = ipa;
        } else if (tags.contains('UK') ||
            tags.contains('Received Pronunciation')) {
          ipaUk = ipa;
        } else if (ipaUs.isEmpty) {
          ipaUs = ipa;
        }
      }

      // Senses
      final rawSenses = map['senses'] as List<dynamic>? ?? [];
      final senses = <Map<String, dynamic>>[];
      var senseOrder = 1;

      for (final rs in rawSenses) {
        final rsm = rs as Map<String, dynamic>;
        final glosses = rsm['glosses'] as List<dynamic>? ?? [];
        if (glosses.isEmpty) continue;

        final def = glosses.last.toString();
        if (def.isEmpty || def.length > 500) continue;

        senses.add({
          'pos': map['pos'] ?? 'unknown',
          'order': senseOrder++,
          'definition': def,
          'bible_definition': '',
          'is_archaic':
              ((rsm['tags'] as List<dynamic>? ?? [])
                  .contains('archaic')),
          'examples': [],
        });

        if (senses.length >= 3) break; // 최대 3개 의미만 포함
      }

      if (senses.isEmpty) {
        skipped++;
        continue;
      }

      // Etymology
      final etymology =
          (map['etymology_text'] as String? ?? '').take(300);

      // 활용형
      final forms = map['forms'] as List<dynamic>? ?? [];
      final inflections = <Map<String, dynamic>>[];
      for (final f in forms) {
        final fm = f as Map<String, dynamic>;
        final form = fm['form'] as String? ?? '';
        final tags =
            (fm['tags'] as List<dynamic>? ?? []).cast<String>();
        if (form.isEmpty) continue;

        String? type;
        if (tags.contains('past')) type = 'past_tense';
        else if (tags.contains('past-participle')) type = 'past_participle';
        else if (tags.contains('present-participle')) type = 'present_participle';
        else if (tags.contains('plural')) type = 'plural';
        else if (tags.contains('comparative')) type = 'comparative';
        else if (tags.contains('superlative')) type = 'superlative';

        if (type != null) {
          inflections.add({'type': type, 'form': form});
        }
      }

      output.add({
        'word': word,
        'ipa_us': ipaUs,
        'ipa_uk': ipaUk,
        'frequency_rank': 999999,
        'bible_frequency': 0,
        'etymology': etymology,
        'senses': senses,
        'synonyms': [],
        'antonyms': [],
        'related': [],
        'inflections': inflections,
      });

      processed++;
      if (processed % 10000 == 0) {
        stdout.writeln('   처리됨: $processed 개…');
      }
    } catch (_) {
      skipped++;
    }
  }

  // 출력
  final outFile =
      File('$outputDir/dictionary_wiktionary.json');
  await outFile.parent.create(recursive: true);
  await outFile.writeAsString(jsonEncode(output), encoding: utf8);

  stdout.writeln('');
  stdout.writeln('✅ Wiktionary 처리 완료!');
  stdout.writeln('   처리된 단어: $processed');
  stdout.writeln('   스킵: $skipped');
  stdout.writeln('   출력: ${outFile.path}');
  stdout.writeln('');
  stdout.writeln('🔜 다음 단계:');
  stdout.writeln('   dart run scripts/import_wordnet.dart <wordnet.json>');
  stdout.writeln('   (WordNet 동의어/반의어 병합)');
}

void _usage() {
  stdout.writeln('''
Wiktionary Import Script
Usage: dart run scripts/import_wiktionary.dart <kaikki_dump.jsonl> [output_dir]

Data source (CC BY-SA 4.0):
  https://kaikki.org/dictionary/English/
  Download: kaikki.org-dictionary-English.jsonl (~900MB)

Output: assets/data/dictionary_wiktionary.json
''');
}

extension on String {
  String take(int n) => length > n ? substring(0, n) : this;
}
