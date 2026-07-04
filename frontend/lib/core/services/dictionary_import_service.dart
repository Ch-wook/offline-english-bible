// lib/core/services/dictionary_import_service.dart
// [NEW] 사전 데이터 임포트 서비스 (JSON → SQLite)
//
// 지원 포맷:
// [{"word":"grace","ipa_us":"/ɡreɪs/","senses":[{"pos":"noun",...}],...}]

import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:flutter/services.dart';

import '../database/app_database.dart';

final class DictionaryImportService {
  const DictionaryImportService(this._db);

  final AppDatabase _db;

  static const _sampleAssetPath = 'assets/data/dictionary_sample.json';

  /// 샘플 사전 데이터 임포트.
  /// Stream<(progress, message)> 반환.
  Stream<(double, String)> importSampleDictionary() async* {
    yield (0.05, '사전 파일을 로드합니다…');

    late final String jsonStr;
    try {
      jsonStr = await rootBundle.loadString(_sampleAssetPath);
    } catch (_) {
      yield (1.0, '사전 샘플 파일 없음 — 스킵');
      return;
    }

    yield (0.1, '사전 데이터를 파싱합니다…');

    final List<dynamic> raw = jsonDecode(jsonStr) as List<dynamic>;

    yield (0.15, '사전 데이터를 삽입합니다…');

    var entryId = 1;
    var senseId = 1;
    var exampleId = 1;
    var relationId = 1;
    var inflectionId = 1;

    final entries = <DictionaryEntriesCompanion>[];
    final senses = <SensesCompanion>[];
    final examples = <ExamplesCompanion>[];
    final relations = <WordNetRelationsCompanion>[];
    final inflections = <InflectionsCompanion>[];

    for (final item in raw) {
      final map = item as Map<String, dynamic>;
      final word = map['word'] as String;
      final currentEntryId = entryId++;

      entries.add(
        DictionaryEntriesCompanion(
          id: Value(currentEntryId),
          word: Value(word),
          wordNormalized: Value(word.toLowerCase()),
          ipaUs: Value(map['ipa_us'] as String?),
          ipaUk: Value(map['ipa_uk'] as String?),
          frequencyRank: Value(map['frequency_rank'] as int?),
          bibleFrequency: Value(map['bible_frequency'] as int?),
          etymology: Value(map['etymology'] as String?),
        ),
      );

      // Senses
      final senseList = map['senses'] as List<dynamic>? ?? [];
      for (final s in senseList) {
        final sm = s as Map<String, dynamic>;
        final currentSenseId = senseId++;

        senses.add(
          SensesCompanion(
            id: Value(currentSenseId),
            entryId: Value(currentEntryId),
            partOfSpeech: Value(sm['pos'] as String),
            senseOrder: Value(sm['order'] as int),
            definition: Value(sm['definition'] as String),
            bibleDefinition: Value(sm['bible_definition'] as String?),
            isArchaic: Value(sm['is_archaic'] as bool? ?? false),
            register: const Value(null),
          ),
        );

        // Examples
        final exList = sm['examples'] as List<dynamic>? ?? [];
        for (final ex in exList) {
          final em = ex as Map<String, dynamic>;
          examples.add(
            ExamplesCompanion(
              id: Value(exampleId++),
              senseId: Value(currentSenseId),
              text: Value(em['text'] as String),
              type: Value(em['type'] as String),
              sourceReference: Value(em['ref'] as String?),
            ),
          );
        }
      }

      // WordNet Relations
      final syns = (map['synonyms'] as List<dynamic>? ?? [])
          .cast<String>();
      for (final w in syns) {
        relations.add(
          WordNetRelationsCompanion(
            id: Value(relationId++),
            entryId: Value(currentEntryId),
            relationType: const Value('synonym'),
            relatedWord: Value(w),
          ),
        );
      }
      final ants = (map['antonyms'] as List<dynamic>? ?? [])
          .cast<String>();
      for (final w in ants) {
        relations.add(
          WordNetRelationsCompanion(
            id: Value(relationId++),
            entryId: Value(currentEntryId),
            relationType: const Value('antonym'),
            relatedWord: Value(w),
          ),
        );
      }
      final related = (map['related'] as List<dynamic>? ?? [])
          .cast<String>();
      for (final w in related) {
        relations.add(
          WordNetRelationsCompanion(
            id: Value(relationId++),
            entryId: Value(currentEntryId),
            relationType: const Value('related'),
            relatedWord: Value(w),
          ),
        );
      }

      // Inflections
      final inflList = map['inflections'] as List<dynamic>? ?? [];
      for (final inf in inflList) {
        final im = inf as Map<String, dynamic>;
        inflections.add(
          InflectionsCompanion(
            id: Value(inflectionId++),
            entryId: Value(currentEntryId),
            formType: Value(im['type'] as String),
            form: Value(im['form'] as String),
          ),
        );
      }
    }

    // 배치 삽입
    await _db.batch(
      (b) => b.insertAllOnConflictUpdate(_db.dictionaryEntries, entries),
    );
    yield (0.5, '단어 항목 삽입 완료 (${entries.length}개)');

    await _db.batch(
      (b) => b.insertAllOnConflictUpdate(_db.senses, senses),
    );
    yield (0.65, '의미 삽입 완료 (${senses.length}개)');

    await _db.batch(
      (b) => b.insertAllOnConflictUpdate(_db.examples, examples),
    );
    await _db.batch(
      (b) => b.insertAllOnConflictUpdate(_db.wordNetRelations, relations),
    );
    await _db.batch(
      (b) => b.insertAllOnConflictUpdate(_db.inflections, inflections),
    );

    yield (1.0, '사전 임포트 완료');
  }
}
