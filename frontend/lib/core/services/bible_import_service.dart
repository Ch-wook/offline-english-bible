// lib/core/services/bible_import_service.dart
// [NEW] 성경 데이터 임포트 서비스 (최초 실행 시 JSON → SQLite)
//
// 지원 JSON 포맷 (공개 도메인 소스):
// [{"b":1,"c":1,"v":1,"t":"In the beginning..."}]
// b=book(1-66), c=chapter, v=verse, t=text

import 'dart:async';
import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:flutter/services.dart';

import '../database/app_database.dart';
import '../database/seed_data/bible_books_seed.dart';

// ── Import Progress ───────────────────────────────────────────────────

enum ImportStatus { idle, loadingJson, parsingJson, inserting, complete, error }

final class ImportProgress {
  const ImportProgress({
    required this.status,
    this.progress = 0.0,
    this.currentBook = '',
    this.message = '',
    this.error,
  });

  const ImportProgress.idle()
    : status = ImportStatus.idle,
      progress = 0.0,
      currentBook = '',
      message = '',
      error = null;

  const ImportProgress.complete()
    : status = ImportStatus.complete,
      progress = 1.0,
      currentBook = '',
      message = '임포트 완료',
      error = null;

  final ImportStatus status;

  /// 0.0 ~ 1.0
  final double progress;
  final String currentBook;
  final String message;
  final Object? error;

  bool get isComplete => status == ImportStatus.complete;
  bool get hasError => status == ImportStatus.error;
}

// ── Service ───────────────────────────────────────────────────────────

/// 앱 최초 실행 시 bundled JSON asset → SQLite 임포트를 담당한다.
///
/// 임포트 순서:
/// 1. 66권 메타데이터 삽입 (bible_books_seed)
/// 2. KJV JSON 로드 → 절 배치 삽입
/// 3. 개역한글 JSON 로드 → 절 배치 삽입
final class BibleImportService {
  BibleImportService(this._db);

  final AppDatabase _db;

  static const kjvDataVersion = 2;
  static const _kjvAssetPath = 'assets/data/kjv_full.json';
  static const _koreanAssetPath = 'assets/data/korean_rv_full.json';

  /// 임포트 실행. Stream<ImportProgress> 를 반환한다.
  Stream<ImportProgress> runFullImport() async* {
    yield const ImportProgress(
      status: ImportStatus.idle,
      message: '성경 데이터 임포트를 준비합니다…',
    );

    try {
      // ── Step 1: 66권 메타데이터 삽입 ─────────────────────────────
      yield const ImportProgress(
        status: ImportStatus.inserting,
        progress: 0.02,
        message: '성경 목록을 초기화합니다…',
      );
      await _db.batch(
        (b) => b.insertAllOnConflictUpdate(_db.bibleBooks, bibleBooksSeed()),
      );

      // ── Step 2: KJV 임포트 ────────────────────────────────────────
      yield* _importTranslation(
        assetPath: _kjvAssetPath,
        translationCode: 'KJV',
        progressStart: 0.05,
        progressEnd: 0.52,
      );

      // ── Step 3: 개역한글 임포트 ───────────────────────────────────
      yield* _importTranslation(
        assetPath: _koreanAssetPath,
        translationCode: 'KOREAN_RV',
        progressStart: 0.53,
        progressEnd: 1.0,
      );

      yield const ImportProgress.complete();
    } catch (e, stack) {
      yield ImportProgress(
        status: ImportStatus.error,
        message: '임포트 중 오류가 발생했습니다: $e',
        error: e,
      );
      // ignore: avoid_print
      print('BibleImportService error: $e\n$stack');
    }
  }

  Stream<ImportProgress> _importTranslation({
    required String assetPath,
    required String translationCode,
    required double progressStart,
    required double progressEnd,
  }) async* {
    final label = translationCode == 'KJV' ? 'KJV (영어)' : '개역한글';

    // JSON 로드
    yield ImportProgress(
      status: ImportStatus.loadingJson,
      progress: progressStart,
      message: '$label 파일을 로드합니다…',
    );

    late final String jsonStr;
    try {
      jsonStr = await rootBundle.loadString(assetPath);
    } catch (_) {
      // asset 파일이 없으면 스킵 (개발 단계에서 허용)
      yield ImportProgress(
        status: ImportStatus.inserting,
        progress: progressEnd,
        message: '$label asset 파일 없음 — 스킵',
      );
      return;
    }

    // 파싱
    yield ImportProgress(
      status: ImportStatus.parsingJson,
      progress: progressStart + (progressEnd - progressStart) * 0.1,
      message: '$label 데이터를 파싱합니다…',
    );

    final List<dynamic> raw = jsonDecode(jsonStr) as List<dynamic>;
    final companions =
        raw
            .map(
              (e) => _toCompanion(e as Map<String, dynamic>, translationCode),
            )
            .toList();

    // 배치 삽입
    final total = companions.length;
    final progressRange = progressEnd - progressStart - 0.1;
    const batchSize = 500;

    for (var i = 0; i < total; i += batchSize) {
      final end = (i + batchSize).clamp(0, total);
      final chunk = companions.sublist(i, end);

      await _db.batch(
        (b) => b.insertAll(
          _db.verseTranslations,
          chunk,
          mode: InsertMode.insertOrReplace,
        ),
      );

      final ratio = end / total;
      final currentBookId = chunk.last.bookId.value;
      final bookName = bookNameMap[currentBookId]?.en ?? '';

      yield ImportProgress(
        status: ImportStatus.inserting,
        progress: progressStart + 0.1 + progressRange * ratio,
        currentBook: bookName,
        message: '$label 삽입 중… ($end / $total)',
      );
    }

    // 번역본 총 절 수 업데이트
    await _db.customStatement(
      '''
      UPDATE bible_translations
      SET total_verses = (
        SELECT COUNT(*) FROM verse_translations
        WHERE translation_code = ?
      )
      WHERE code = ?
      ''',
      [translationCode, translationCode],
    );
  }

  VerseTranslationsCompanion _toCompanion(
    Map<String, dynamic> map,
    String translationCode,
  ) {
    // 지원 포맷:
    // {"b":1,"c":1,"v":1,"t":"..."}
    // {"book":1,"chapter":1,"verse":1,"text":"..."}
    final bookId = (map['b'] ?? map['book']) as int;
    final chapter = (map['c'] ?? map['chapter']) as int;
    final verse = (map['v'] ?? map['verse']) as int;
    final text = (map['t'] ?? map['text']) as String;

    return VerseTranslationsCompanion(
      translationCode: Value(translationCode),
      bookId: Value(bookId),
      chapter: Value(chapter),
      verse: Value(verse),
      textContent: Value(text),
    );
  }
}
