// lib/features/bible/presentation/widgets/verse_item.dart
// [NEW] 성경 절(Verse) 위젯 — 단어 탭 지원

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
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
    this.highlightColorCode,
    super.key,
  });

  final Verse verse;
  final Verse? parallelVerse;
  final bool isSelected;
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
    final readerState = ref.watch(bibleReaderProvider);
    final readerNotifier = ref.read(bibleReaderProvider.notifier);

    final isPrimaryEnglish = readerState.translationCode != 'KOREAN_RV';
    final isParallelEnglish =
        readerState.parallelTranslationCode != 'KOREAN_RV';

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
      onLongPress: () => readerNotifier.selectVerse(verse.verseNumber),
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
  final List<TapGestureRecognizer> _recognizers = [];

  @override
  void dispose() {
    for (final r in _recognizers) {
      r.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // 이전 recognizer 정리
    for (final r in _recognizers) {
      r.dispose();
    }
    _recognizers.clear();

    final tokens = _tokenize(widget.text);

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
      ...tokens.map((token) {
        if (token.isWord) {
          final recognizer =
              TapGestureRecognizer()
                ..onTap = () => widget.onWordTap(token.text);
          _recognizers.add(recognizer);

          return TextSpan(
            text: token.text,
            recognizer: recognizer,
            style: TextStyle(
              fontSize: widget.fontSize,
              height: widget.lineSpacing,
              color: widget.color,
              fontFamily: 'NotoSerif',
            ),
          );
        } else {
          // 공백, 구두점 — 탭 불가
          return TextSpan(
            text: token.text,
            style: TextStyle(
              fontSize: widget.fontSize,
              height: widget.lineSpacing,
              color: widget.color,
              fontFamily: 'NotoSerif',
            ),
          );
        }
      }),
    ];

    return RichText(text: TextSpan(children: spans));
  }

  /// 텍스트를 단어/비단어 토큰으로 분리.
  List<_Token> _tokenize(String text) {
    final tokens = <_Token>[];
    final regex = RegExp(r"[\w']+|[^\w']+");
    final wordCheck = RegExp(r"[\w']");
    for (final match in regex.allMatches(text)) {
      final t = match.group(0)!;
      tokens.add(_Token(t, isWord: wordCheck.hasMatch(t)));
    }
    return tokens;
  }
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

class _Token {
  const _Token(this.text, {required this.isWord});
  final String text;
  final bool isWord;
}
