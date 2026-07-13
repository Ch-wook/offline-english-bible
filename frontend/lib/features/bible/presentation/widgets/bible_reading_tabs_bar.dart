import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../theme/app_spacing.dart';
import '../../../../theme/app_typography.dart';
import '../providers/bible_providers.dart';
import '../providers/reading_tabs_provider.dart';
import 'book_selector_sheet.dart';

class BibleReadingTabsBar extends ConsumerWidget {
  const BibleReadingTabsBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    final tabsAsync = ref.watch(readingTabsProvider);
    final books = ref.watch(allBooksProvider).valueOrNull ?? const [];
    final bookById = {for (final book in books) book.id: book};

    return Material(
      color: colorScheme.surface,
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(color: colorScheme.outlineVariant.withAlpha(110)),
          ),
        ),
        child: tabsAsync.when(
          loading:
              () => const Center(
                child: SizedBox.square(
                  dimension: 18,
                  child: CircularProgressIndicator(strokeWidth: 2),
                ),
              ),
          error:
              (_, __) => Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '읽기 탭을 불러오지 못했습니다',
                    style: AppTypography.labelMedium.copyWith(
                      color: colorScheme.error,
                    ),
                  ),
                  IconButton(
                    tooltip: '다시 시도',
                    onPressed: ref.read(readingTabsProvider.notifier).reload,
                    icon: const Icon(Icons.refresh_rounded, size: 20),
                  ),
                ],
              ),
          data:
              (state) => Row(
                children: [
                  Expanded(
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.only(left: AppSpacing.xs),
                      itemCount: state.tabs.length,
                      separatorBuilder: (_, __) => const SizedBox(width: 2),
                      itemBuilder: (context, index) {
                        final tab = state.tabs[index];
                        final book = bookById[tab.bookId];
                        final label =
                            '${book?.abbreviationKorean ?? '성경'} ${tab.chapter}';
                        return _ReadingTabButton(
                          label: label,
                          translationLabel:
                              tab.isParallelView
                                  ? '한영'
                                  : tab.translationCode == 'KJV'
                                  ? '영어'
                                  : '한글',
                          selected: tab.id == state.activeTabId,
                          canClose: state.tabs.length > 1,
                          onTap:
                              () => ref
                                  .read(readingTabsProvider.notifier)
                                  .selectTab(tab.id),
                          onClose:
                              () => ref
                                  .read(readingTabsProvider.notifier)
                                  .closeTab(tab.id),
                        );
                      },
                    ),
                  ),
                  VerticalDivider(
                    width: 1,
                    thickness: 1,
                    color: colorScheme.outlineVariant.withAlpha(110),
                  ),
                  IconButton(
                    tooltip:
                        state.tabs.length >= maxBibleReadingTabs
                            ? '읽기 탭은 최대 $maxBibleReadingTabs개까지 사용할 수 있습니다'
                            : '읽기 탭 추가',
                    onPressed:
                        state.tabs.length >= maxBibleReadingTabs
                            ? null
                            : () => _addTab(context, ref),
                    icon: const Icon(Icons.add_rounded),
                  ),
                ],
              ),
        ),
      ),
    );
  }

  Future<void> _addTab(BuildContext context, WidgetRef ref) async {
    final added = await ref.read(readingTabsProvider.notifier).addTab();
    if (!context.mounted) return;
    if (!added) {
      final tabCount = ref.read(readingTabsProvider).valueOrNull?.tabs.length;
      if (tabCount == null || tabCount < maxBibleReadingTabs) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('읽기 탭은 최대 6개까지 사용할 수 있습니다')));
      return;
    }
    await BookSelectorSheet.show(context);
  }
}

class _ReadingTabButton extends StatelessWidget {
  const _ReadingTabButton({
    required this.label,
    required this.translationLabel,
    required this.selected,
    required this.canClose,
    required this.onTap,
    required this.onClose,
  });

  final String label;
  final String translationLabel;
  final bool selected;
  final bool canClose;
  final VoidCallback onTap;
  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Semantics(
      selected: selected,
      button: true,
      label: '$label 읽기 탭',
      child: InkWell(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 160),
          width: canClose ? 126 : 112,
          padding: const EdgeInsets.only(left: AppSpacing.md),
          decoration: BoxDecoration(
            color:
                selected
                    ? colorScheme.primaryContainer.withAlpha(105)
                    : Colors.transparent,
            border: Border(
              bottom: BorderSide(
                color: selected ? colorScheme.primary : Colors.transparent,
                width: 2.5,
              ),
            ),
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      label,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTypography.labelMedium.copyWith(
                        color:
                            selected
                                ? colorScheme.onPrimaryContainer
                                : colorScheme.onSurface,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      translationLabel,
                      style: AppTypography.labelSmall.copyWith(
                        fontSize: 9,
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
              if (canClose)
                IconButton(
                  tooltip: '$label 탭 닫기',
                  onPressed: onClose,
                  visualDensity: VisualDensity.compact,
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints.tightFor(
                    width: 32,
                    height: 44,
                  ),
                  icon: const Icon(Icons.close_rounded, size: 17),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
