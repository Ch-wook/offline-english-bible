// lib/features/settings/presentation/pages/settings_page.dart
// [NEW] 설정 화면 (완전 구현 — Hive 기반)

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../theme/app_colors.dart';
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
          style: AppTypography.titleLarge
              .copyWith(color: colorScheme.onSurface),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.lg,
          vertical: AppSpacing.md,
        ),
        children: [
          // ── 테마 ────────────────────────────────────────────────
          _SectionHeader(label: '테마'),
          _SegmentedRow(
            label: '다크 모드',
            icon: Icons.brightness_6_rounded,
            segments: const [
              ButtonSegment(
                value: ThemeMode.light,
                icon: Icon(Icons.light_mode_rounded),
                label: Text('라이트'),
              ),
              ButtonSegment(
                value: ThemeMode.system,
                icon: Icon(Icons.brightness_auto_rounded),
                label: Text('시스템'),
              ),
              ButtonSegment(
                value: ThemeMode.dark,
                icon: Icon(Icons.dark_mode_rounded),
                label: Text('다크'),
              ),
            ],
            selected: {settings.themeMode},
            onSelectionChanged: (s) => notifier.setThemeMode(s.first),
          ),

          const SizedBox(height: AppSpacing.xxl),

          // ── 성경 읽기 ────────────────────────────────────────────
          _SectionHeader(label: '성경 읽기'),

          _SliderRow(
            label: '글자 크기',
            icon: Icons.format_size_rounded,
            value: settings.fontSize,
            min: 12,
            max: 28,
            divisions: 8,
            displayText: '${settings.fontSize.toInt()}pt',
            onChanged: notifier.setFontSize,
          ),

          _SliderRow(
            label: '줄 간격',
            icon: Icons.format_line_spacing_rounded,
            value: settings.lineSpacing,
            min: 1.4,
            max: 2.5,
            divisions: 11,
            displayText: settings.lineSpacing.toStringAsFixed(1),
            onChanged: notifier.setLineSpacing,
          ),

          _SwitchRow(
            label: '절 번호 표시',
            icon: Icons.tag_rounded,
            value: settings.showVerseNumbers,
            onChanged: (_) => notifier.toggleShowVerseNumbers(),
          ),

          _SwitchRow(
            label: 'Strong 번호 표시',
            icon: Icons.numbers_rounded,
            value: settings.showStrongNumbers,
            onChanged: (_) => notifier.toggleShowStrongNumbers(),
          ),

          _SwitchRow(
            label: '화면 켜기 유지',
            icon: Icons.screen_lock_portrait_rounded,
            value: settings.keepScreenOn,
            onChanged: (_) => notifier.toggleKeepScreenOn(),
          ),

          const SizedBox(height: AppSpacing.xxl),

          // ── 번역본 ───────────────────────────────────────────────
          _SectionHeader(label: '번역본'),

          _SelectRow(
            label: '영어 번역본',
            icon: Icons.translate_rounded,
            value: settings.defaultTranslation,
            options: const {
              'KJV': 'King James Version (공개 도메인)',
            },
            onChanged: notifier.setDefaultTranslation,
          ),

          _SelectRow(
            label: '한국어 번역본',
            icon: Icons.g_translate_rounded,
            value: settings.defaultKoreanTranslation,
            options: const {
              'KOREAN_RV': '개역한글 (공개 도메인)',
            },
            onChanged: notifier.setDefaultKoreanTranslation,
          ),

          const SizedBox(height: AppSpacing.xxl),

          // ── 대역 보기 ────────────────────────────────────────────
          _SectionHeader(label: '대역 보기'),

          _SwitchRow(
            label: '한영 대역 보기',
            icon: Icons.view_column_rounded,
            value: settings.parallelView,
            onChanged: (_) => notifier.toggleParallelView(),
          ),

          if (settings.parallelView)
            _SegmentedRow<String>(
              label: '왼쪽 언어',
              icon: Icons.swap_horiz_rounded,
              segments: const [
                ButtonSegment(value: 'ko', label: Text('한국어')),
                ButtonSegment(value: 'en', label: Text('영어')),
              ],
              selected: {settings.parallelLeftLanguage},
              onSelectionChanged: (s) =>
                  notifier.setParallelLeftLanguage(s.first),
            ),

          const SizedBox(height: AppSpacing.xxl),

          // ── 자동 스크롤 ──────────────────────────────────────────
          _SectionHeader(label: '자동 스크롤'),

          _SwitchRow(
            label: '자동 스크롤',
            icon: Icons.swap_vert_rounded,
            value: settings.autoScroll,
            onChanged: (_) => notifier.toggleAutoScroll(),
          ),

          if (settings.autoScroll)
            _SliderRow(
              label: '스크롤 속도',
              icon: Icons.speed_rounded,
              value: settings.autoScrollSpeed,
              min: 10,
              max: 200,
              divisions: 19,
              displayText: '${settings.autoScrollSpeed.toInt()}px/s',
              onChanged: notifier.setAutoScrollSpeed,
            ),

          const SizedBox(height: AppSpacing.xxl),

          // ── 초기화 ────────────────────────────────────────────────
          _SectionHeader(label: '기타'),

          ListTile(
            leading: const Icon(Icons.restore_rounded),
            title: Text('설정 초기화', style: AppTypography.bodyLarge),
            subtitle: Text(
              '모든 설정을 기본값으로 되돌립니다',
              style: AppTypography.bodySmall,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
            ),
            onTap: () => _confirmReset(context, notifier),
          ),

          const SizedBox(height: AppSpacing.xxl),

          // ── 앱 정보 ───────────────────────────────────────────────
          Center(
            child: Column(
              children: [
                Icon(
                  Icons.menu_book_rounded,
                  size: 32,
                  color: colorScheme.primary,
                ),
                const SizedBox(height: AppSpacing.sm),
                Text(
                  'Offline English Bible v1.0.0',
                  style: AppTypography.labelMedium.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
                Text(
                  'KJV & 개역한글 — Public Domain',
                  style: AppTypography.labelSmall.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.xxxxl),
        ],
      ),
    );
  }

  void _confirmReset(BuildContext context, SettingsNotifier notifier) {
    showDialog<void>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('설정 초기화'),
        content: const Text('모든 설정을 기본값으로 되돌리시겠습니까?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('취소'),
          ),
          FilledButton(
            onPressed: () {
              Navigator.pop(ctx);
              notifier.resetToDefaults();
            },
            child: const Text('초기화'),
          ),
        ],
      ),
    );
  }
}

// ── Section Widgets ───────────────────────────────────────────────────

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: AppSpacing.sm,
        bottom: AppSpacing.sm,
      ),
      child: Text(
        label,
        style: AppTypography.labelMedium.copyWith(
          color: Theme.of(context).colorScheme.primary,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.8,
        ),
      ),
    );
  }
}

class _SwitchRow extends StatelessWidget {
  const _SwitchRow({
    required this.label,
    required this.icon,
    required this.value,
    required this.onChanged,
  });

  final String label;
  final IconData icon;
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
      title: Text(label, style: AppTypography.bodyLarge),
      secondary: Icon(icon, size: AppSpacing.iconMd),
      value: value,
      onChanged: onChanged,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
      ),
    );
  }
}

class _SliderRow extends StatelessWidget {
  const _SliderRow({
    required this.label,
    required this.icon,
    required this.value,
    required this.min,
    required this.max,
    required this.divisions,
    required this.displayText,
    required this.onChanged,
  });

  final String label;
  final IconData icon;
  final double value;
  final double min;
  final double max;
  final int divisions;
  final String displayText;
  final ValueChanged<double> onChanged;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.lg,
        vertical: AppSpacing.sm,
      ),
      child: Column(
        children: [
          Row(
            children: [
              Icon(icon, size: AppSpacing.iconMd, color: colorScheme.onSurfaceVariant),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Text(label, style: AppTypography.bodyLarge),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.sm,
                  vertical: 2,
                ),
                decoration: BoxDecoration(
                  color: colorScheme.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(AppSpacing.radiusXs),
                ),
                child: Text(
                  displayText,
                  style: AppTypography.labelMedium.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
              ),
            ],
          ),
          Slider(
            value: value,
            min: min,
            max: max,
            divisions: divisions,
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}

class _SegmentedRow<T> extends StatelessWidget {
  const _SegmentedRow({
    required this.label,
    required this.icon,
    required this.segments,
    required this.selected,
    required this.onSelectionChanged,
  });

  final String label;
  final IconData icon;
  final List<ButtonSegment<T>> segments;
  final Set<T> selected;
  final ValueChanged<Set<T>> onSelectionChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.lg,
        vertical: AppSpacing.sm,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                icon,
                size: AppSpacing.iconMd,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
              const SizedBox(width: AppSpacing.md),
              Text(label, style: AppTypography.bodyLarge),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          SegmentedButton<T>(
            segments: segments,
            selected: selected,
            onSelectionChanged: onSelectionChanged,
            showSelectedIcon: false,
          ),
        ],
      ),
    );
  }
}

class _SelectRow extends StatelessWidget {
  const _SelectRow({
    required this.label,
    required this.icon,
    required this.value,
    required this.options,
    required this.onChanged,
  });

  final String label;
  final IconData icon;
  final String value;
  final Map<String, String> options;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, size: AppSpacing.iconMd),
      title: Text(label, style: AppTypography.bodyLarge),
      subtitle: Text(
        options[value] ?? value,
        style: AppTypography.bodySmall,
      ),
      trailing: options.length > 1
          ? const Icon(Icons.chevron_right_rounded)
          : null,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
      ),
      onTap: options.length > 1
          ? () => _showOptions(context)
          : null,
    );
  }

  void _showOptions(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      builder: (ctx) => Column(
        mainAxisSize: MainAxisSize.min,
        children: options.entries
            .map(
              (e) => RadioListTile<String>(
                title: Text(e.value),
                value: e.key,
                groupValue: value,
                onChanged: (v) {
                  if (v != null) onChanged(v);
                  Navigator.pop(ctx);
                },
              ),
            )
            .toList(),
      ),
    );
  }
}
