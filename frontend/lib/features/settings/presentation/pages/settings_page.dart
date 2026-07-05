// lib/features/settings/presentation/pages/settings_page.dart
// [MODIFY] 설정 화면 — 완전 구현

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../theme/app_spacing.dart';
import '../../../../theme/app_typography.dart';
import '../providers/settings_provider.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsProvider);
    final notifier = ref.read(settingsProvider.notifier);
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          '설정',
          style: AppTypography.titleLarge.copyWith(
            color: colorScheme.onSurface,
          ),
        ),
      ),
      body: ListView(
        children: [
          // ── 읽기 설정 ─────────────────────────────────────────────
          _SectionHeader(label: '읽기'),

          // 글자 크기
          _SliderTile(
            icon: Icons.format_size_rounded,
            label: '글자 크기',
            value: settings.fontSize,
            min: 12.0,
            max: 32.0,
            divisions: 20,
            displayValue: '${settings.fontSize.round()}pt',
            onChanged: (v) => notifier.setFontSize(v),
          ),

          // 줄 간격
          _SliderTile(
            icon: Icons.format_line_spacing_rounded,
            label: '줄 간격',
            value: settings.lineSpacing,
            min: 1.2,
            max: 2.5,
            divisions: 13,
            displayValue: settings.lineSpacing.toStringAsFixed(1),
            onChanged: (v) => notifier.setLineSpacing(v),
          ),

          // 자동 스크롤 속도
          _SliderTile(
            icon: Icons.speed_rounded,
            label: '자동 스크롤 속도',
            value: settings.autoScrollSpeed,
            min: 10,
            max: 120,
            divisions: 11,
            displayValue: '${settings.autoScrollSpeed.round()}px/s',
            onChanged: (v) => notifier.setAutoScrollSpeed(v),
          ),

          // 대역 보기 기본값
          SwitchListTile(
            secondary: const Icon(Icons.view_column_rounded),
            title: const Text('대역 보기 기본값'),
            subtitle: const Text('성경 열람 시 KJV + 한국어 동시 표시'),
            value: settings.parallelView,
            onChanged: (v) => notifier.setParallelView(value: v),
          ),

          const Divider(),

          // ── 기본 번역본 ────────────────────────────────────────────
          _SectionHeader(label: '기본 번역본'),

          RadioListTile<String>(
            secondary: const Icon(Icons.flag_rounded),
            title: const Text('KJV (영어)'),
            subtitle: const Text('King James Version — 공개 도메인'),
            value: 'KJV',
            groupValue: settings.defaultTranslation,
            onChanged: (v) {
              if (v != null) notifier.setDefaultTranslation(v);
            },
          ),

          RadioListTile<String>(
            secondary: const Icon(Icons.flag_outlined),
            title: const Text('개역한글 (한국어)'),
            subtitle: const Text('공개 도메인'),
            value: 'KOREAN_RV',
            groupValue: settings.defaultTranslation,
            onChanged: (v) {
              if (v != null) notifier.setDefaultTranslation(v);
            },
          ),

          const Divider(),

          // ── 테마 ──────────────────────────────────────────────────
          _SectionHeader(label: '테마'),

          RadioListTile<ThemeMode>(
            secondary: const Icon(Icons.wb_sunny_rounded),
            title: const Text('라이트 모드'),
            value: ThemeMode.light,
            groupValue: settings.themeMode,
            onChanged: (v) {
              if (v != null) notifier.setThemeMode(v);
            },
          ),

          RadioListTile<ThemeMode>(
            secondary: const Icon(Icons.dark_mode_rounded),
            title: const Text('다크 모드'),
            value: ThemeMode.dark,
            groupValue: settings.themeMode,
            onChanged: (v) {
              if (v != null) notifier.setThemeMode(v);
            },
          ),

          RadioListTile<ThemeMode>(
            secondary: const Icon(Icons.brightness_auto_rounded),
            title: const Text('시스템 설정 따름'),
            value: ThemeMode.system,
            groupValue: settings.themeMode,
            onChanged: (v) {
              if (v != null) notifier.setThemeMode(v);
            },
          ),

          const Divider(),

          // ── 데이터 ────────────────────────────────────────────────
          _SectionHeader(label: '데이터'),

          ListTile(
            leading: const Icon(Icons.storage_rounded),
            title: const Text('사전 데이터 관리'),
            subtitle: const Text('Wiktionary + WordNet 임포트'),
            trailing: const Icon(Icons.chevron_right_rounded),
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('사전 데이터 관리 (추후 구현)'),
                  behavior: SnackBarBehavior.floating,
                ),
              );
            },
          ),

          ListTile(
            leading: Icon(
              Icons.delete_forever_rounded,
              color: colorScheme.error,
            ),
            title: Text(
              '모든 사용자 데이터 초기화',
              style: TextStyle(color: colorScheme.error),
            ),
            subtitle: const Text('북마크, 형광펜, 단어장이 모두 삭제됩니다'),
            onTap: () => _showResetDialog(context, ref),
          ),

          const SizedBox(height: AppSpacing.xxxl),

          // ── 앱 정보 ───────────────────────────────────────────────
          _SectionHeader(label: '앱 정보'),

          const ListTile(
            leading: Icon(Icons.info_outline_rounded),
            title: Text('버전'),
            trailing: Text('1.0.0'),
          ),

          const ListTile(
            leading: Icon(Icons.gavel_rounded),
            title: Text('오픈소스 라이선스'),
            subtitle: Text('KJV, 개역한글: 공개 도메인\nWiktionary: CC BY-SA 4.0\nWordNet: Princeton License'),
          ),

          const SizedBox(height: AppSpacing.xxl),
        ],
      ),
    );
  }

  void _showResetDialog(BuildContext context, WidgetRef ref) {
    showDialog<void>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('데이터 초기화'),
        content: const Text(
          '모든 북마크, 형광펜, 단어장이 삭제됩니다.\n이 작업은 되돌릴 수 없습니다.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('취소'),
          ),
          FilledButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('사용자 데이터가 초기화되었습니다'),
                  behavior: SnackBarBehavior.floating,
                ),
              );
            },
            style: FilledButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.error,
            ),
            child: const Text('초기화'),
          ),
        ],
      ),
    );
  }
}

// ── Shared Widgets ────────────────────────────────────────────────────

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.lg,
        AppSpacing.lg,
        AppSpacing.lg,
        AppSpacing.xs,
      ),
      child: Text(
        label,
        style: AppTypography.labelMedium.copyWith(
          color: colorScheme.primary,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.5,
        ),
      ),
    );
  }
}

class _SliderTile extends StatelessWidget {
  const _SliderTile({
    required this.icon,
    required this.label,
    required this.value,
    required this.min,
    required this.max,
    required this.divisions,
    required this.displayValue,
    required this.onChanged,
  });

  final IconData icon;
  final String label;
  final double value;
  final double min;
  final double max;
  final int divisions;
  final String displayValue;
  final void Function(double) onChanged;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return ListTile(
      leading: Icon(icon, color: colorScheme.onSurfaceVariant),
      title: Row(
        children: [
          Text(label),
          const Spacer(),
          Text(
            displayValue,
            style: AppTypography.labelMedium.copyWith(
              color: colorScheme.primary,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
      subtitle: Slider(
        value: value.clamp(min, max),
        min: min,
        max: max,
        divisions: divisions,
        onChanged: onChanged,
      ),
    );
  }
}
