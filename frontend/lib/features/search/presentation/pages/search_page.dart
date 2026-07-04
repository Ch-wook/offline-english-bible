// lib/features/search/presentation/pages/search_page.dart
// [NEW] 검색 화면 — TASK 7에서 완전 구현

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../shared/widgets/bible_error_widget.dart';
import '../../../../theme/app_spacing.dart';
import '../../../../theme/app_typography.dart';

class SearchPage extends ConsumerStatefulWidget {
  const SearchPage({super.key});

  @override
  ConsumerState<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends ConsumerState<SearchPage> {
  final _controller = TextEditingController();
  final _focusNode = FocusNode();

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '검색',
          style: AppTypography.titleLarge
              .copyWith(color: colorScheme.onSurface),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.lg,
              0,
              AppSpacing.lg,
              AppSpacing.md,
            ),
            child: SearchBar(
              controller: _controller,
              focusNode: _focusNode,
              hintText: '성경 구절, 단어, Strong 번호로 검색…',
              leading: const Icon(Icons.search_rounded),
              trailing: [
                if (_controller.text.isNotEmpty)
                  IconButton(
                    icon: const Icon(Icons.clear_rounded),
                    onPressed: () {
                      _controller.clear();
                      setState(() {});
                    },
                  ),
              ],
              onChanged: (_) => setState(() {}),
              onSubmitted: (_) {},
            ),
          ),
          const Expanded(
            child: EmptyStateWidget(
              icon: Icons.manage_search_rounded,
              title: '검색어를 입력하세요',
              message: '구절, 단어, Strong 번호(H430, G2316),\n인물, 장소로 검색할 수 있습니다.',
            ),
          ),
        ],
      ),
    );
  }
}
