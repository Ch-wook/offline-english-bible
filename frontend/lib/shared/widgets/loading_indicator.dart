// lib/shared/widgets/loading_indicator.dart
// [NEW] 공통 로딩 인디케이터 위젯

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../theme/app_colors.dart';
import '../../theme/app_typography.dart';

/// 풀스크린 로딩 오버레이.
class FullScreenLoader extends StatelessWidget {
  const FullScreenLoader({this.message, super.key});

  final String? message;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _PulsingCross(color: colorScheme.primary),
            const SizedBox(height: 24),
            if (message != null)
              Text(
                message!,
                style: AppTypography.bodyMedium.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
                textAlign: TextAlign.center,
              ),
          ],
        ),
      ),
    );
  }
}

/// 인라인 로딩 (리스트 하단 등).
class InlineLoader extends StatelessWidget {
  const InlineLoader({this.size = 24.0, super.key});

  final double size;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: size,
        height: size,
        child: CircularProgressIndicator(
          strokeWidth: 2.5,
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
    );
  }
}

/// 작은 로딩 스피너 (버튼 내부 등).
class MiniLoader extends StatelessWidget {
  const MiniLoader({this.color, super.key});

  final Color? color;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 18,
      height: 18,
      child: CircularProgressIndicator(
        strokeWidth: 2,
        color: color ?? Theme.of(context).colorScheme.primary,
      ),
    );
  }
}

/// 성경 앱 특화: 십자가 아이콘 + 펄스 애니메이션.
class _PulsingCross extends StatefulWidget {
  const _PulsingCross({required this.color});

  final Color color;

  @override
  State<_PulsingCross> createState() => _PulsingCrossState();
}

class _PulsingCrossState extends State<_PulsingCross>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _scaleAnim;
  late final Animation<double> _opacityAnim;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat(reverse: true);

    _scaleAnim = Tween<double>(begin: 0.85, end: 1.1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
    _opacityAnim = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) => Transform.scale(
        scale: _scaleAnim.value,
        child: Opacity(
          opacity: _opacityAnim.value,
          child: Icon(
            Icons.menu_book_rounded,
            size: 48,
            color: widget.color,
          ),
        ),
      ),
    );
  }
}

/// 데이터베이스 초기화 전용 로더.
class DatabaseInitLoader extends StatelessWidget {
  const DatabaseInitLoader({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(32),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.menu_book_rounded,
                  size: 64,
                  color: colorScheme.primary,
                ),
                const SizedBox(height: 32),
                Text(
                  'Offline English Bible',
                  style: AppTypography.headlineMedium.copyWith(
                    color: colorScheme.onSurface,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  '성경 데이터베이스를 준비하고 있습니다…',
                  style: AppTypography.bodyMedium.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 40),
                LinearProgressIndicator(
                  backgroundColor:
                      colorScheme.surfaceContainerHighest,
                  color: colorScheme.primary,
                  borderRadius: BorderRadius.circular(4),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Riverpod AsyncValue 전용 빌더 헬퍼.
/// Usage: asyncValue.toWidget(data: (d) => MyWidget(d))
extension AsyncValueLoadingExt<T> on AsyncValue<T> {
  Widget toWidget({
    required Widget Function(T data) data,
    Widget Function(Object error, StackTrace? stack)? error,
    Widget? loading,
  }) {
    return when(
      data: data,
      error: error ??
          (e, s) => Center(
                child: Text(
                  e.toString(),
                  style: AppTypography.bodyMedium.copyWith(
                    color: AppColors.lightError,
                  ),
                ),
              ),
      loading: () => loading ?? const InlineLoader(),
    );
  }
}
