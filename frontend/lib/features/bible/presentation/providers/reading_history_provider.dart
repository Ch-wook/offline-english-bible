// lib/features/bible/presentation/providers/reading_history_provider.dart
// [NEW] 읽기 기록 Provider — 자동 저장 + 최근 기록 조회

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/di/providers.dart';
import '../../data/datasources/user_local_datasource_impl.dart';
import '../providers/bible_reader_provider.dart';

// ── Data Source Provider ──────────────────────────────────────────────

final userDataSourceProvider = Provider((ref) {
  final db = ref.watch(appDatabaseProvider);
  return UserLocalDataSourceImpl(db);
});

// ── Reading History Save ──────────────────────────────────────────────

/// 현재 읽기 위치를 DB 에 자동 저장하는 Provider.
/// [bibleReaderProvider] 를 listen 하고 위치 변경 시 저장.
final readingHistoryAutoSaveProvider = Provider<void>((ref) {
  final dataSource = ref.watch(userDataSourceProvider);

  ref.listen<BibleReaderState>(bibleReaderProvider, (prev, next) {
    if (prev?.bookId != next.bookId || prev?.chapter != next.chapter) {
      dataSource.saveReadingHistory(
        bookId: next.bookId,
        chapter: next.chapter,
        translationCode: next.translationCode,
      );
    }
  });
});

// ── Last Read ─────────────────────────────────────────────────────────

final lastReadChapterProvider = FutureProvider((ref) async {
  final ds = ref.watch(userDataSourceProvider);
  return ds.getLastReadChapter();
});

// ── Recent History ────────────────────────────────────────────────────

final recentReadingHistoryProvider = FutureProvider((ref) async {
  final ds = ref.watch(userDataSourceProvider);
  return ds.getRecentReadingHistory(limit: 20);
});
