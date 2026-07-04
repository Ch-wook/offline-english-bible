// lib/shared/widgets/bible_error_widget.dart
// [NEW] 공통 에러 표시 위젯

import 'package:flutter/material.dart';

import '../../core/error/failures.dart';
import '../../theme/app_typography.dart';

/// 앱 전체에서 사용하는 에러 표시 위젯.
class BibleErrorWidget extends StatelessWidget {
  const BibleErrorWidget({
    required this.failure,
    this.onRetry,
    super.key,
  });

  final Failure failure;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    return _ErrorBody(
      icon: _iconFor(failure),
      title: _titleFor(failure),
      message: failure.message,
      onRetry: onRetry,
    );
  }

  IconData _iconFor(Failure f) => switch (f) {
        WordNotFoundFailure() => Icons.search_off_rounded,
        BibleDataNotLoadedFailure() => Icons.library_books_outlined,
        NetworkFailure() || ServerFailure() => Icons.wifi_off_rounded,
        DatabaseFailure() || RecordNotFoundFailure() =>
          Icons.storage_rounded,
        _ => Icons.error_outline_rounded,
      };

  String _titleFor(Failure f) => switch (f) {
        WordNotFoundFailure() => '단어를 찾을 수 없습니다',
        BibleDataNotLoadedFailure() => '성경 데이터 로딩 중',
        NetworkFailure() || ServerFailure() => '연결 실패',
        DatabaseFailure() => '데이터베이스 오류',
        _ => '오류가 발생했습니다',
      };
}

/// 일반 에러 위젯 (String 메시지).
class GenericErrorWidget extends StatelessWidget {
  const GenericErrorWidget({
    required this.message,
    this.title = '오류가 발생했습니다',
    this.onRetry,
    super.key,
  });

  final String title;
  final String message;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    return _ErrorBody(
      icon: Icons.error_outline_rounded,
      title: title,
      message: message,
      onRetry: onRetry,
    );
  }
}

/// 빈 상태 위젯.
class EmptyStateWidget extends StatelessWidget {
  const EmptyStateWidget({
    required this.title,
    required this.message,
    this.icon = Icons.inbox_rounded,
    this.action,
    this.actionLabel,
    super.key,
  });

  final String title;
  final String message;
  final IconData icon;
  final VoidCallback? action;
  final String? actionLabel;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: colorScheme.surfaceContainerHighest,
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                size: 36,
                color: colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              title,
              style: AppTypography.titleMedium.copyWith(
                color: colorScheme.onSurface,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              message,
              style: AppTypography.bodyMedium.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
            ),
            if (action != null && actionLabel != null) ...[
              const SizedBox(height: 24),
              FilledButton.tonal(
                onPressed: action,
                child: Text(actionLabel!),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

/// 내부 공통 에러 바디.
class _ErrorBody extends StatelessWidget {
  const _ErrorBody({
    required this.icon,
    required this.title,
    required this.message,
    this.onRetry,
  });

  final IconData icon;
  final String title;
  final String message;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: colorScheme.errorContainer,
                shape: BoxShape.circle,
              ),
              child: Icon(icon, size: 36, color: colorScheme.onErrorContainer),
            ),
            const SizedBox(height: 20),
            Text(
              title,
              style: AppTypography.titleMedium.copyWith(
                color: colorScheme.onSurface,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              message,
              style: AppTypography.bodyMedium.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
            ),
            if (onRetry != null) ...[
              const SizedBox(height: 24),
              FilledButton.icon(
                onPressed: onRetry,
                icon: const Icon(Icons.refresh_rounded),
                label: const Text('다시 시도'),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
