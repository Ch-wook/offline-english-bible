// lib/main.dart
// [NEW] 앱 진입점 — 데이터베이스 + Hive + ProviderScope 초기화

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'app.dart';
import 'core/database/app_database.dart';
import 'core/di/providers.dart';
import 'features/settings/presentation/providers/settings_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // ── 시스템 UI 설정 ────────────────────────────────────────────────
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ),
  );
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // ── Hive 초기화 (설정 저장소) ────────────────────────────────────
  await Hive.initFlutter();
  final settingsBox = await Hive.openBox<dynamic>('app_settings');

  // ── Drift 데이터베이스 초기화 ─────────────────────────────────────
  final db = AppDatabase(createDatabaseConnection('offline_bible.db'));

  // ── 앱 실행 ───────────────────────────────────────────────────────
  runApp(
    ProviderScope(
      overrides: [
        // Database 주입
        appDatabaseOverride(db),
        // Settings Box 주입
        settingsBoxProvider.overrideWithValue(settingsBox),
      ],
      child: const App(),
    ),
  );
}
