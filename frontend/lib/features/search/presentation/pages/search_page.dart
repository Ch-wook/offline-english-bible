// lib/features/search/presentation/pages/search_page.dart
// [MODIFY] 전문 검색 화면 — FTS5 기반 완전 구현

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../shared/widgets/loading_indicator.dart';
import '../../../../theme/app_spacing.dart';
import '../../../../theme/app_typography.dart';
import '../../domain/entities/search_result.dart';
import '../providers/search_providers.dart';

class SearchPage extends ConsumerStatefulWidget {
  const SearchPage({super.key});

  @override
  ConsumerState<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends ConsumerState<SearchPage> {
  final _controller = TextEditingController();
  final _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => _focusNode.requestFocus(),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final searchState = ref.watch(searchNotifierProvider);
    final notifier = ref.read(searchNotifierProvider.notifier);
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: TextField(
          controller: _controller,
          focusNode: _focusNode,
          onChanged: (v) {
            if (v.length >= 2) {
              notifier.search(v);
            } else if (v.isEmpty) {
              notifier.clear();
            }
          },
          onSubmitted: (v) => notifier.search(v),
          decoration: InputDecoration(
            hintText: '성경 전문 검색… (KJV/한국어)',
            border: InputBorder.none,
            hintStyle: AppTypography.bodyMedium.copyWith(
              color: colorScheme.onSurfaceVariant,
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.md,
            ),
          ),
          style: AppTypography.bodyMedium.copyWith(
            color: colorScheme.onSurface,
          ),
          textInputAction: TextInputAction.search,
        ),
        actions: [
          if (_controller.text.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.clear_rounded),
              onPressed: () {
                _controller.clear();
                notifier.clear();
                _focusNode.requestFocus();
              },
            ),
        ],
      ),
      body: Column(
        children: [
          // ── 필터 바 ──────────────────────────────────────────────
          _FilterBar(state: searchState, notifier: notifier),
          const Divider(height: 1),

          // ── 결과 ────────────────────────────────────────────────
          Expanded(
            child:
                searchState.isSearching
                    ? const Center(child: InlineLoader())
                    : !searchState.hasSearched
                    ? const _SearchHint()
                    : searchState.isEmpty
                    ? _NoResults(query: searchState.query)
                    : _SearchResults(results: searchState.results),
          ),
        ],
      ),
    );
  }
}

// ── Filter Bar ────────────────────────────────────────────────────────

class _FilterBar extends ConsumerWidget {
  const _FilterBar({required this.state, required this.notifier});

  final SearchState state;
  final SearchNotifier notifier;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      child: Row(
        children: [
          // 번역본 선택
          _FilterChip(
            label: state.translationCode,
            icon: Icons.translate_rounded,
            isSelected: false,
            onTap: () => _showTranslationPicker(context),
          ),
          const SizedBox(width: AppSpacing.sm),

          // OT / NT 필터
          _FilterChip(
            label: '구약',
            icon: Icons.book_rounded,
            isSelected: state.testament == 'OT',
            onTap: () => notifier.setBookFilter(null),
          ),
          const SizedBox(width: AppSpacing.sm),

          _FilterChip(
            label: '신약',
            icon: Icons.book_outlined,
            isSelected: state.testament == 'NT',
            onTap: () => notifier.setBookFilter(null),
          ),

          // 필터 초기화
          if (state.bookId != null || state.testament != null) ...[
            const SizedBox(width: AppSpacing.sm),
            ActionChip(
              label: const Text('초기화'),
              avatar: const Icon(Icons.close_rounded, size: 14),
              onPressed: notifier.clearFilters,
              visualDensity: VisualDensity.compact,
            ),
          ],
        ],
      ),
    );
  }

  void _showTranslationPicker(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      builder:
          (_) => RadioGroup<String>(
            groupValue: state.translationCode,
            onChanged: (value) {
              if (value == null) return;
              notifier.setTranslation(value);
              Navigator.pop(context);
            },
            child: const Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: AppSpacing.lg),
                RadioListTile<String>(
                  title: Text('KJV (영어)'),
                  value: 'KJV',
                ),
                RadioListTile<String>(
                  title: Text('개역한글 (한국어)'),
                  value: 'KOREAN_RV',
                ),
                SizedBox(height: AppSpacing.xl),
              ],
            ),
          ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  const _FilterChip({
    required this.label,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return FilterChip(
      label: Text(label),
      avatar: Icon(icon, size: 14),
      selected: isSelected,
      onSelected: (_) => onTap(),
      visualDensity: VisualDensity.compact,
    );
  }
}

// ── Search Results ────────────────────────────────────────────────────

class _SearchResults extends ConsumerWidget {
  const _SearchResults({required this.results});

  final List<SearchResult> results;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    final navigate = ref.read(navigateToVerseProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.lg,
            vertical: AppSpacing.sm,
          ),
          child: Text(
            '${results.length}개 결과',
            style: AppTypography.labelMedium.copyWith(
              color: colorScheme.onSurfaceVariant,
            ),
          ),
        ),
        Expanded(
          child: ListView.separated(
            itemCount: results.length,
            separatorBuilder: (_, __) => const Divider(height: 1),
            itemBuilder: (_, i) {
              final result = results[i];
              return ListTile(
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.lg,
                  vertical: AppSpacing.sm,
                ),
                title: Row(
                  children: [
                    Text(
                      result.reference,
                      style: AppTypography.labelMedium.copyWith(
                        color: colorScheme.primary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 1,
                      ),
                      decoration: BoxDecoration(
                        color: colorScheme.primaryContainer.withAlpha(80),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        result.verse.translationCode,
                        style: AppTypography.labelSmall.copyWith(
                          fontSize: 9,
                          color: colorScheme.primary,
                        ),
                      ),
                    ),
                  ],
                ),
                subtitle: Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: _HighlightedText(text: result.highlightedText),
                ),
                onTap: () {
                  navigate(result);
                  context.go('/bible');
                },
              );
            },
          ),
        ),
      ],
    );
  }
}

// ── Highlighted Text ──────────────────────────────────────────────────

class _HighlightedText extends StatelessWidget {
  const _HighlightedText({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final spans = <InlineSpan>[];
    final parts = text.split(RegExp(r'\*\*'));

    for (var i = 0; i < parts.length; i++) {
      final isBold = i % 2 == 1;
      spans.add(
        TextSpan(
          text: parts[i],
          style: AppTypography.bodySmall.copyWith(
            color: isBold ? colorScheme.primary : colorScheme.onSurface,
            fontWeight: isBold ? FontWeight.w700 : FontWeight.w400,
            backgroundColor:
                isBold ? colorScheme.primaryContainer.withAlpha(60) : null,
            fontFamily: 'NotoSerif',
          ),
        ),
      );
    }

    return RichText(
      text: TextSpan(children: spans),
      maxLines: 3,
      overflow: TextOverflow.ellipsis,
    );
  }
}

// ── Empty States ──────────────────────────────────────────────────────

class _SearchHint extends StatelessWidget {
  const _SearchHint();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.search_rounded,
            size: 64,
            color: colorScheme.outlineVariant,
          ),
          const SizedBox(height: AppSpacing.lg),
          Text(
            '성경 전문을 검색합니다',
            style: AppTypography.bodyMedium.copyWith(
              color: colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            '예: "shepherd", "사랑", "beginning"',
            style: AppTypography.labelMedium.copyWith(
              color: colorScheme.outlineVariant,
            ),
          ),
        ],
      ),
    );
  }
}

class _NoResults extends StatelessWidget {
  const _NoResults({required this.query});

  final String query;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.search_off_rounded,
            size: 48,
            color: colorScheme.outlineVariant,
          ),
          const SizedBox(height: AppSpacing.lg),
          Text(
            '"$query" 검색 결과 없음',
            style: AppTypography.bodyMedium.copyWith(
              color: colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}
