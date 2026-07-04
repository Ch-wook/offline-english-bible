// lib/features/vocabulary/presentation/pages/vocabulary_page.dart
// [NEW] 단어장 화면 — TASK 5에서 완전 구현

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../shared/widgets/bible_error_widget.dart';
import '../../../../theme/app_spacing.dart';
import '../../../../theme/app_typography.dart';

class VocabularyPage extends ConsumerWidget {
  const VocabularyPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '단어장',
          style: AppTypography.titleLarge
              .copyWith(color: colorScheme.onSurface),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.sort_rounded),
            onPressed: () {},
            tooltip: '정렬',
          ),
        ],
      ),
      body: EmptyStateWidget(
        icon: Icons.auto_stories_rounded,
        title: '단어장이 비어 있습니다',
        message: '성경을 읽다가 단어를 탭하면\n단어장에 추가할 수 있습니다.',
        action: () {},
        actionLabel: '성경 읽기로 이동',
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        icon: const Icon(Icons.play_arrow_rounded),
        label: const Text('복습 시작'),
      ),
    );
  }
}
