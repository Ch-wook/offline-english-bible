// lib/core/services/app_initialization_service.dart
// [NEW] 앱 초기화 서비스 — 최초 실행 감지 + 데이터 임포트 조율

import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../database/app_database.dart';
import 'bible_import_service.dart';

// ── Hive Keys ─────────────────────────────────────────────────────────

const _boxName = 'init_flags';
const _kjvImportedKey = 'kjv_imported';
const _koreanImportedKey = 'korean_rv_imported';
const _booksSeededKey = 'books_seeded';

// ── Init State ────────────────────────────────────────────────────────

enum AppInitStatus {
  checkingDatabase,
  importRequired,
  importing,
  ready,
  error,
}

final class AppInitState {
  const AppInitState({
    required this.status,
    this.importProgress,
    this.error,
  });

  const AppInitState.checking()
      : status = AppInitStatus.checkingDatabase,
        importProgress = null,
        error = null;

  const AppInitState.ready()
      : status = AppInitStatus.ready,
        importProgress = null,
        error = null;

  final AppInitStatus status;
  final ImportProgress? importProgress;
  final Object? error;

  bool get isReady => status == AppInitStatus.ready;
  bool get isImporting => status == AppInitStatus.importing;
  bool get hasError => status == AppInitStatus.error;
  double get importProgressValue =>
      importProgress?.progress ?? 0.0;
  String get importMessage =>
      importProgress?.message ?? '';
}

// ── Service ───────────────────────────────────────────────────────────

/// 앱 시작 시 1회 실행되는 초기화 조율자.
///
/// 1. Hive 플래그 확인 → 이미 임포트된 경우 즉시 ready
/// 2. 미임포트 → BibleImportService 실행
/// 3. 완료 → Hive 플래그 저장 → ready
final class AppInitializationService {
  AppInitializationService({
    required AppDatabase db,
    required Box<dynamic> flagBox,
  })  : _db = db,
        _flagBox = flagBox,
        _importService = BibleImportService(db);

  final AppDatabase _db;
  final Box<dynamic> _flagBox;
  final BibleImportService _importService;

  final StreamController<AppInitState> _stateController =
      StreamController<AppInitState>.broadcast();

  Stream<AppInitState> get stateStream => _stateController.stream;

  Future<void> initialize() async {
    _emit(const AppInitState.checking());

    try {
      final isReady = _isAlreadyImported();
      if (isReady) {
        _emit(const AppInitState.ready());
        return;
      }

      // 임포트 필요
      _emit(
        const AppInitState(status: AppInitStatus.importRequired),
      );

      await for (final progress in _importService.runFullImport()) {
        if (progress.hasError) {
          _emit(
            AppInitState(
              status: AppInitStatus.error,
              importProgress: progress,
              error: progress.error,
            ),
          );
          return;
        }

        _emit(
          AppInitState(
            status: progress.isComplete
                ? AppInitStatus.ready
                : AppInitStatus.importing,
            importProgress: progress,
          ),
        );

        if (progress.isComplete) {
          await _markImported();
        }
      }
    } catch (e) {
      _emit(
        AppInitState(
          status: AppInitStatus.error,
          error: e,
        ),
      );
    }
  }

  bool _isAlreadyImported() {
    return (_flagBox.get(_kjvImportedKey) as bool? ?? false) &&
        (_flagBox.get(_booksSeededKey) as bool? ?? false);
  }

  Future<void> _markImported() async {
    await Future.wait([
      _flagBox.put(_kjvImportedKey, true),
      _flagBox.put(_koreanImportedKey, true),
      _flagBox.put(_booksSeededKey, true),
    ]);
  }

  void _emit(AppInitState state) {
    if (!_stateController.isClosed) {
      _stateController.add(state);
    }
  }

  /// 임포트 플래그 초기화 (개발/디버그용).
  Future<void> resetImportFlags() async {
    await Future.wait([
      _flagBox.delete(_kjvImportedKey),
      _flagBox.delete(_koreanImportedKey),
      _flagBox.delete(_booksSeededKey),
    ]);
  }

  Future<void> dispose() => _stateController.close();
}

// ── Provider ──────────────────────────────────────────────────────────

final initFlagBoxProvider = Provider<Box<dynamic>>((ref) {
  throw UnimplementedError(
    'initFlagBoxProvider must be overridden in main()',
  );
});
