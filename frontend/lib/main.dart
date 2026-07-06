// lib/main.dart
// [MODIFY] 앱 진입점 — AppInitializationService 통합

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'app.dart';
import 'core/database/app_database.dart';
import 'core/di/providers.dart';
import 'core/services/app_initialization_service.dart';
import 'features/settings/presentation/providers/settings_provider.dart';
import 'theme/app_colors.dart';
import 'theme/app_spacing.dart';
import 'theme/app_typography.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // ── 시스템 UI ──────────────────────────────────────────────────────
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
  );
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // ── Hive 초기화 ───────────────────────────────────────────────────
  await Hive.initFlutter();
  final settingsBox = await Hive.openBox<dynamic>('app_settings');
  final initFlagBox = await Hive.openBox<dynamic>('init_flags');

  // ── Drift DB ──────────────────────────────────────────────────────
  final db = AppDatabase(createDatabaseConnection('offline_bible.db'));

  // ── 초기화 서비스 ─────────────────────────────────────────────────
  final initService = AppInitializationService(
    db: db,
    flagBox: initFlagBox,
  );

  runApp(
    ProviderScope(
      overrides: [
        appDatabaseOverride(db),
        settingsBoxProvider.overrideWithValue(settingsBox),
        initFlagBoxProvider.overrideWithValue(initFlagBox),
      ],
      child: _AppWrapper(initService: initService),
    ),
  );
}

/// 초기화 완료 전까지 임포트 화면을 표시하는 래퍼.
class _AppWrapper extends StatefulWidget {
  const _AppWrapper({required this.initService});

  final AppInitializationService initService;

  @override
  State<_AppWrapper> createState() => _AppWrapperState();
}

class _AppWrapperState extends State<_AppWrapper> {
  late final StreamSubscription<AppInitState> _sub;
  AppInitState _state = const AppInitState.checking();

  @override
  void initState() {
    super.initState();
    _sub = widget.initService.stateStream.listen((s) {
      if (mounted) setState(() => _state = s);
    });
    // 초기화 시작
    widget.initService.initialize();
  }

  @override
  void dispose() {
    _sub.cancel();
    widget.initService.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_state.isReady) {
      return const App();
    }
    return _InitScreen(state: _state);
  }
}

// ── Init Screen ───────────────────────────────────────────────────────

class _InitScreen extends StatelessWidget {
  const _InitScreen({required this.state});

  final AppInitState state;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: const ColorScheme.dark(
          primary: AppColors.darkPrimary,
          surface: AppColors.darkBackground,
        ),
        scaffoldBackgroundColor: AppColors.darkBackground,
      ),
      home: Scaffold(
        backgroundColor: AppColors.darkBackground,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.xxxl,
              vertical: AppSpacing.xxxxl,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // 로고
                const Icon(
                  Icons.menu_book_rounded,
                  size: 72,
                  color: AppColors.darkPrimary,
                ),
                const SizedBox(height: AppSpacing.xxl),

                // 앱 이름
                Text(
                  'Offline English Bible',
                  style: AppTypography.headlineMedium.copyWith(
                    color: AppColors.darkOnBackground,
                  ),
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: AppSpacing.sm),
                Text(
                  'KJV · 개역한글',
                  style: AppTypography.bodyMedium.copyWith(
                    color: AppColors.darkOnSurfaceVariant,
                  ),
                ),

                const SizedBox(height: AppSpacing.xxxxl),

                if (state.hasError)
                  _ErrorContent(state: state)
                else
                  _LoadingContent(state: state),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _LoadingContent extends StatelessWidget {
  const _LoadingContent({required this.state});

  final AppInitState state;

  @override
  Widget build(BuildContext context) {
    final progress = state.importProgressValue;
    final message = state.importMessage.isNotEmpty
        ? state.importMessage
        : '데이터베이스를 초기화합니다…';

    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
          child: LinearProgressIndicator(
            value: progress > 0 ? progress : null,
            minHeight: 6,
            backgroundColor: AppColors.darkSurfaceVariant,
            color: AppColors.darkPrimary,
          ),
        ),
        const SizedBox(height: AppSpacing.lg),
        Text(
          message,
          style: AppTypography.bodyMedium.copyWith(
            color: AppColors.darkOnSurfaceVariant,
          ),
          textAlign: TextAlign.center,
        ),
        if (state.importProgress?.currentBook.isNotEmpty == true) ...[
          const SizedBox(height: AppSpacing.xs),
          Text(
            state.importProgress!.currentBook,
            style: AppTypography.labelSmall.copyWith(
              color: AppColors.darkOnSurfaceVariant,
            ),
          ),
        ],
        if (progress > 0) ...[
          const SizedBox(height: AppSpacing.sm),
          Text(
            '${(progress * 100).toInt()}%',
            style: AppTypography.labelMedium.copyWith(
              color: AppColors.darkPrimary,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ],
    );
  }
}

class _ErrorContent extends StatelessWidget {
  const _ErrorContent({required this.state});

  final AppInitState state;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Icon(
          Icons.error_outline_rounded,
          size: 48,
          color: AppColors.darkError,
        ),
        const SizedBox(height: AppSpacing.lg),
        Text(
          '초기화 실패',
          style: AppTypography.titleMedium.copyWith(
            color: AppColors.darkOnBackground,
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        Text(
          state.importProgress?.message ?? '알 수 없는 오류:\n${state.error}',
          style: AppTypography.bodySmall.copyWith(
            color: AppColors.darkOnSurfaceVariant,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
