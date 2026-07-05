// lib/features/highlights/presentation/widgets/highlight_color_picker.dart
// [NEW] 형광펜 색상 선택 바텀시트

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../theme/app_spacing.dart';
import '../../../../theme/app_typography.dart';
import '../../domain/entities/highlight.dart';
import '../providers/highlights_providers.dart';

/// 형광펜 색상 선택 바텀시트.
class HighlightColorPicker extends ConsumerWidget {
  const HighlightColorPicker({
    required this.bookId,
    required this.chapter,
    required this.verse,
    required this.translationCode,
    required this.verseText,
    super.key,
  });

  final int bookId;
  final int chapter;
  final int verse;
  final String translationCode;
  final String verseText;

  static Future<void> show(
    BuildContext context, {
    required int bookId,
    required int chapter,
    required int verse,
    required String translationCode,
    required String verseText,
  }) {
    return showModalBottomSheet<void>(
      context: context,
      builder: (_) => HighlightColorPicker(
        bookId: bookId,
        chapter: chapter,
        verse: verse,
        translationCode: translationCode,
        verseText: verseText,
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    final notifier = ref.read(highlightActionProvider.notifier);

    return Padding(
      padding: const EdgeInsets.all(AppSpacing.xl),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 절 미리보기
          Text(
            verseText,
            style: AppTypography.bodySmall.copyWith(
              color: colorScheme.onSurfaceVariant,
              fontFamily: 'NotoSerif',
              fontStyle: FontStyle.italic,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: AppSpacing.lg),

          Text(
            '형광펜 색상 선택',
            style: AppTypography.labelMedium.copyWith(
              color: colorScheme.onSurface,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: AppSpacing.md),

          // 색상 팔레트
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: HighlightColor.presets.map((hc) {
              final hex = hc.hexValue;
              final color = _hexToColor(hex);

              return GestureDetector(
                onTap: () async {
                  Navigator.pop(context);
                  await notifier.addHighlight(
                    bookId: bookId,
                    chapter: chapter,
                    verse: verse,
                    translationCode: translationCode,
                    color: hc.code,
                  );
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content:
                            Text('${hc.label} 형광펜이 적용되었습니다'),
                        duration: const Duration(seconds: 2),
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                  }
                },
                child: Column(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: color,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: colorScheme.outlineVariant,
                          width: 1.5,
                        ),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      hc.label,
                      style: AppTypography.labelSmall.copyWith(
                        fontSize: 10,
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),

          const SizedBox(height: AppSpacing.lg),

          // 북마크 추가 버튼
          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: () async {
                Navigator.pop(context);
                await ref.read(highlightActionProvider.notifier).addBookmark(
                      bookId: bookId,
                      chapter: chapter,
                      verse: verse,
                      translationCode: translationCode,
                    );
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('북마크가 추가되었습니다'),
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                }
              },
              icon: const Icon(Icons.bookmark_add_rounded, size: 18),
              label: const Text('북마크 추가'),
            ),
          ),
        ],
      ),
    );
  }

  Color _hexToColor(String hex) {
    final h = hex.replaceFirst('#', '');
    return Color(int.parse('FF$h', radix: 16));
  }
}
