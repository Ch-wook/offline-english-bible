// lib/shared/widgets/app_scaffold.dart
// [NEW] 앱 쉘 — GoRouter StatefulShellRoute 기반 하단 네비게이션

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';


/// 앱 전체 쉘 위젯.
/// GoRouter [StatefulShellRoute.indexedStack] 의 builder 로 사용된다.
class AppShell extends StatelessWidget {
  const AppShell({required this.navigationShell, super.key});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: _AppNavigationBar(
        currentIndex: navigationShell.currentIndex,
        onDestinationSelected: _onDestinationSelected,
      ),
    );
  }

  void _onDestinationSelected(int index) {
    navigationShell.goBranch(
      index,
      // 같은 탭을 다시 탭하면 해당 탭의 루트로 이동
      initialLocation: index == navigationShell.currentIndex,
    );
  }
}

class _AppNavigationBar extends StatelessWidget {
  const _AppNavigationBar({
    required this.currentIndex,
    required this.onDestinationSelected,
  });

  final int currentIndex;
  final ValueChanged<int> onDestinationSelected;

  static const _destinations = [
    _NavDestination(
      icon: Icons.menu_book_outlined,
      selectedIcon: Icons.menu_book_rounded,
      label: '성경',
      tooltip: '성경 읽기',
    ),
    _NavDestination(
      icon: Icons.auto_stories_outlined,
      selectedIcon: Icons.auto_stories_rounded,
      label: '단어장',
      tooltip: '단어장',
    ),
    _NavDestination(
      icon: Icons.search_rounded,
      selectedIcon: Icons.search_rounded,
      label: '검색',
      tooltip: '성경 검색',
    ),
    _NavDestination(
      icon: Icons.settings_outlined,
      selectedIcon: Icons.settings_rounded,
      label: '설정',
      tooltip: '앱 설정',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      selectedIndex: currentIndex,
      onDestinationSelected: onDestinationSelected,
      destinations: _destinations
          .map(
            (d) => NavigationDestination(
              icon: Icon(d.icon),
              selectedIcon: Icon(d.selectedIcon),
              label: d.label,
              tooltip: d.tooltip,
            ),
          )
          .toList(),
      animationDuration: const Duration(milliseconds: 300),
      labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
    );
  }
}

class _NavDestination {
  const _NavDestination({
    required this.icon,
    required this.selectedIcon,
    required this.label,
    required this.tooltip,
  });

  final IconData icon;
  final IconData selectedIcon;
  final String label;
  final String tooltip;
}
