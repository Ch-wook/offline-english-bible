// lib/core/di/providers.dart
// [NEW] 전역 Riverpod Provider 등록

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../database/app_database.dart';

// ── Database ──────────────────────────────────────────────────────────

/// 앱 전체 SQLite 데이터베이스.
/// main() 의 ProviderScope override 로 실제 인스턴스를 주입한다.
final appDatabaseProvider = Provider<AppDatabase>((ref) {
  throw UnimplementedError(
    'appDatabaseProvider must be overridden in main() with a real AppDatabase instance.',
  );
});

/// 데이터베이스 dispose 처리.
/// main() 에서 ProviderScope.overrides 로 사용.
ProviderOverride appDatabaseOverride(AppDatabase db) =>
    appDatabaseProvider.overrideWith((ref) {
      ref.onDispose(db.close);
      return db;
    });
