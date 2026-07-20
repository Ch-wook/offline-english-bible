// lib/features/bible/presentation/widgets/verse_item.dart
// [NEW] 성경 절(Verse) 위젯 — 단어 탭 지원

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart' show RenderParagraph;
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../theme/app_colors.dart';
import '../../../../theme/app_spacing.dart';
import '../../../../theme/app_typography.dart';
import '../../../highlights/domain/entities/highlight.dart';
import '../../../settings/presentation/providers/settings_provider.dart';
import '../../domain/entities/verse.dart';
import '../providers/bible_reader_provider.dart';

/// 단일 절 위젯.
/// 영어 각 단어는 TapGestureRecognizer 로 탭 가능하다.
class VerseItem extends ConsumerWidget {
  const VerseItem({
    required this.verse,
    this.parallelVerse,
    this.isSelected = false,
    this.isSelectionMode = false,
    this.highlightColorCode,
    super.key,
  });

  final Verse verse;
  final Verse? parallelVerse;
  final bool isSelected;
  final bool isSelectionMode;
  final String? highlightColorCode;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final fontSize = ref.watch(bibleFontSizeProvider);
    final lineSpacing = ref.watch(bibleLineSpacingProvider);
    final showVerseNumbers = ref.watch(
      settingsProvider.select((settings) => settings.showVerseNumbers),
    );
    final readerNotifier = ref.read(bibleReaderProvider.notifier);

    final isPrimaryEnglish = verse.isEnglish;
    final isParallelEnglish = parallelVerse?.isEnglish ?? false;

    final selectedColor =
        isDark
            ? AppColors.darkPrimaryContainer.withAlpha(180)
            : AppColors.lightPrimaryContainer;
    final highlight = HighlightColor.fromCode(highlightColorCode ?? '');
    final highlightColor =
        highlight == null
            ? null
            : Color(
              int.parse(
                'FF${highlight.hexValue.replaceFirst('#', '')}',
                radix: 16,
              ),
            ).withAlpha(isDark ? 70 : 95);

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap:
          isSelectionMode
              ? () => readerNotifier.toggleVerseSelection(verse.verseNumber)
              : null,
      onLongPress:
          () =>
              isSelectionMode
                  ? readerNotifier.toggleVerseSelection(verse.verseNumber)
                  : readerNotifier.selectVerse(verse.verseNumber),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          color:
              isSelected ? selectedColor : highlightColor ?? Colors.transparent,
          borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.lg,
          vertical: 6,
        ),
        child: IgnorePointer(
          ignoring: isSelectionMode,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ── 주 번역본 ──────────────────────────────────────────
              if (isPrimaryEnglish)
                _TappableVerseText(
                  key: ValueKey(
                    'primary-${verse.translationCode}-${verse.verseNumber}',
                  ),
                  text: verse.text,
                  verseNumber: showVerseNumbers ? verse.verseNumber : null,
                  fontSize: fontSize,
                  lineSpacing: lineSpacing,
                  color: colorScheme.onSurface,
                  verseNumberColor:
                      isDark
                          ? AppColors.verseNumberDark
                          : AppColors.verseNumberLight,
                  onWordTap:
                      (word) => readerNotifier.onWordTap(word, source: verse),
                )
              else
                _PlainVerseText(
                  key: ValueKey(
                    'primary-${verse.translationCode}-${verse.verseNumber}',
                  ),
                  text: verse.text,
                  verseNumber: showVerseNumbers ? verse.verseNumber : null,
                  fontSize: fontSize,
                  lineSpacing: lineSpacing,
                  color: colorScheme.onSurface,
                  verseNumberColor:
                      isDark
                          ? AppColors.verseNumberDark
                          : AppColors.verseNumberLight,
                ),

              // ── 대역 번역본 ────────────────────────────────
              if (parallelVerse != null) ...[
                const SizedBox(height: 6),
                Container(
                  padding: const EdgeInsets.only(left: AppSpacing.sm),
                  decoration: BoxDecoration(
                    border: Border(
                      left: BorderSide(
                        color: colorScheme.primary.withAlpha(55),
                        width: 2,
                      ),
                    ),
                  ),
                  child:
                      isParallelEnglish
                          ? _TappableVerseText(
                            key: ValueKey(
                              'parallel-${parallelVerse!.translationCode}-${parallelVerse!.verseNumber}',
                            ),
                            text: parallelVerse!.text,
                            fontSize: fontSize,
                            lineSpacing: lineSpacing,
                            color: colorScheme.onSurfaceVariant,
                            verseNumberColor: colorScheme.onSurfaceVariant,
                            onWordTap:
                                (word) => readerNotifier.onWordTap(
                                  word,
                                  source: parallelVerse,
                                ),
                          )
                          : _PlainVerseText(
                            key: ValueKey(
                              'parallel-${parallelVerse!.translationCode}-${parallelVerse!.verseNumber}',
                            ),
                            text: parallelVerse!.text,
                            fontSize: fontSize,
                            lineSpacing: lineSpacing,
                            color: colorScheme.onSurfaceVariant,
                            verseNumberColor: colorScheme.onSurfaceVariant,
                          ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

// ── Tappable Verse Text ────────────────────────────────────────────────

class _TappableVerseText extends StatefulWidget {
  const _TappableVerseText({
    required this.text,
    required this.fontSize,
    required this.lineSpacing,
    required this.color,
    required this.verseNumberColor,
    required this.onWordTap,
    this.verseNumber,
    super.key,
  });

  final String text;
  final double fontSize;
  final double lineSpacing;
  final Color color;
  final Color verseNumberColor;
  final int? verseNumber;
  final void Function(String word) onWordTap;

  @override
  State<_TappableVerseText> createState() => _TappableVerseTextState();
}

class _TappableVerseTextState extends State<_TappableVerseText> {
  final _paragraphKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final spans = <InlineSpan>[
      if (widget.verseNumber != null)
        TextSpan(
          text: '${widget.verseNumber}  ',
          style: AppTypography.verseNumber.copyWith(
            fontSize: widget.fontSize * 0.7,
            height: widget.lineSpacing,
            color: widget.verseNumberColor,
          ),
        ),
      TextSpan(
        text: widget.text,
        style: TextStyle(
          fontSize: widget.fontSize,
          height: widget.lineSpacing,
          color: widget.color,
          fontFamily: 'NotoSerif',
        ),
      ),
    ];

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTapUp: _handleTapUp,
      child: RichText(key: _paragraphKey, text: TextSpan(children: spans)),
    );
  }

  void _handleTapUp(TapUpDetails details) {
    final paragraph =
        _paragraphKey.currentContext?.findRenderObject() as RenderParagraph?;
    if (paragraph == null) return;

    final prefixLength =
        widget.verseNumber == null ? 0 : '${widget.verseNumber}  '.length;
    final textOffset =
        paragraph.getPositionForOffset(details.localPosition).offset -
        prefixLength;
    final word = _wordAtOffset(widget.text, textOffset);
    if (word != null) widget.onWordTap(word);
  }
}

String? _wordAtOffset(String text, int rawOffset) {
  if (text.isEmpty || rawOffset < 0) return null;
  var offset = rawOffset.clamp(0, text.length - 1).toInt();
  if (!_isWordCharacter(text[offset])) {
    if (offset == 0 || !_isWordCharacter(text[offset - 1])) return null;
    offset--;
  }

  var start = offset;
  var end = offset + 1;
  while (start > 0 && _isWordCharacter(text[start - 1])) {
    start--;
  }
  while (end < text.length && _isWordCharacter(text[end])) {
    end++;
  }
  return text.substring(start, end);
}

bool _isWordCharacter(String character) {
  if (character == "'") return true;
  final code = character.codeUnitAt(0);
  return code >= 48 && code <= 57 ||
      code >= 65 && code <= 90 ||
      code >= 97 && code <= 122;
}

class _PlainVerseText extends StatelessWidget {
  const _PlainVerseText({
    required this.text,
    required this.fontSize,
    required this.lineSpacing,
    required this.color,
    required this.verseNumberColor,
    this.verseNumber,
    super.key,
  });

  final String text;
  final double fontSize;
  final double lineSpacing;
  final Color color;
  final Color verseNumberColor;
  final int? verseNumber;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          if (verseNumber != null)
            TextSpan(
              text: '$verseNumber  ',
              style: AppTypography.verseNumber.copyWith(
                fontSize: fontSize * 0.7,
                height: lineSpacing,
                color: verseNumberColor,
              ),
            ),
          TextSpan(
            text: text,
            style: AppTypography.bibleBody.copyWith(
              fontSize: fontSize,
              height: lineSpacing,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}
