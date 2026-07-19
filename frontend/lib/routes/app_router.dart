// lib/routes/app_router.dart
// [NEW] GoRouter 전체 라우트 정의

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../features/bible/presentation/pages/bible_reader_page.dart';
import '../features/search/presentation/pages/search_page.dart';
import '../features/settings/presentation/pages/settings_page.dart';
import '../features/vocabulary/presentation/pages/vocabulary_page.dart';
import 'route_names.dart';

// ── Navigator Keys ────────────────────────────────────────────────────

final _rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');

// ── Router Provider ───────────────────────────────────────────────────

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: RoutePaths.bible,
    routes: [
      GoRoute(
        path: RoutePaths.bible,
        name: RouteNames.bible,
        pageBuilder:
            (context, state) =>
                const NoTransitionPage(child: BibleReaderPage()),
      ),
      GoRoute(
        path: RoutePaths.vocabulary,
        name: RouteNames.vocabulary,
        builder: (context, state) => const VocabularyPage(),
      ),
      GoRoute(
        path: RoutePaths.search,
        name: RouteNames.search,
        builder: (context, state) => const SearchPage(),
      ),
      GoRoute(
        path: RoutePaths.settings,
        name: RouteNames.settings,
        builder: (context, state) => const SettingsPage(),
      ),
    ],

    // ── Error Page ────────────────────────────────────────────────
    errorPageBuilder:
        (context, state) => MaterialPage(
          child: Scaffold(
            appBar: AppBar(title: const Text('페이지를 찾을 수 없습니다')),
            body: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.broken_image_rounded, size: 64),
                  const SizedBox(height: 16),
                  Text('경로: ${state.uri}'),
                  const SizedBox(height: 16),
                  FilledButton(
                    onPressed: () => context.go(RoutePaths.bible),
                    child: const Text('홈으로'),
                  ),
                ],
              ),
            ),
          ),
        ),
  );
});
