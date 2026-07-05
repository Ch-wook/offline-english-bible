// lib/features/grammar/presentation/providers/grammar_providers.dart
// [NEW] Grammar 분석 Riverpod Providers

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/services/offline_pos_tagger.dart';
import '../../domain/entities/grammar_analysis.dart';

// ── Tagger ────────────────────────────────────────────────────────────

final offlinePosTaggerProvider = Provider<OfflinePosTagger>(
  (_) => const OfflinePosTagger(),
);

// ── Analysis ──────────────────────────────────────────────────────────

/// 절 텍스트 → POS 분석 결과.
/// 동일 텍스트는 캐시됨 (family provider).
final grammarAnalysisProvider =
    Provider.family<GrammarAnalysis, String>((ref, text) {
  final tagger = ref.watch(offlinePosTaggerProvider);
  return tagger.analyze(text);
});

/// 단어 토큰 정보만 (구두점 제외).
final contentTokensProvider =
    Provider.family<List<TokenAnalysis>, String>((ref, text) {
  final analysis = ref.watch(grammarAnalysisProvider(text));
  return analysis.contentWords;
});
