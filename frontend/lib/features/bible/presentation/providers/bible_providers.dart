// lib/features/bible/presentation/providers/bible_providers.dart
// [NEW] Bible feature Riverpod Providers

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/di/providers.dart';
import '../../data/datasources/bible_local_datasource_impl.dart';
import '../../data/datasources/user_local_datasource_impl.dart';
import '../../data/repositories/bible_repository_impl.dart';
import '../../data/repositories/reading_tabs_repository_impl.dart';
import '../../domain/entities/book.dart';
import '../../domain/entities/chapter_content.dart';
import '../../domain/repositories/bible_repository.dart';
import '../../domain/repositories/reading_tabs_repository.dart';
import '../../domain/usecases/get_all_books_usecase.dart';
import '../../domain/usecases/get_chapter_usecase.dart';

// ── Repository ────────────────────────────────────────────────────────

final bibleRepositoryProvider = Provider<BibleRepository>((ref) {
  final db = ref.watch(appDatabaseProvider);
  final dataSource = BibleLocalDataSourceImpl(db);
  return BibleRepositoryImpl(dataSource);
});

final readingTabsRepositoryProvider = Provider<ReadingTabsRepository>((ref) {
  final dataSource = UserLocalDataSourceImpl(ref.watch(appDatabaseProvider));
  return ReadingTabsRepositoryImpl(dataSource);
});

// ── Use Cases ─────────────────────────────────────────────────────────

final getAllBooksUseCaseProvider = Provider<GetAllBooksUseCase>((ref) {
  return GetAllBooksUseCase(ref.watch(bibleRepositoryProvider));
});

final getChapterUseCaseProvider = Provider<GetChapterUseCase>((ref) {
  return GetChapterUseCase(ref.watch(bibleRepositoryProvider));
});

// ── Data Providers ────────────────────────────────────────────────────

/// 66권 목록 FutureProvider.
final allBooksProvider = FutureProvider<List<Book>>((ref) async {
  final useCase = ref.watch(getAllBooksUseCaseProvider);
  final result = await useCase();
  return result.when(
    success: (books) => books,
    failure: (f) => throw Exception(f.message),
  );
});

/// 구약/신약 그룹 FutureProvider.
final booksGroupedProvider = FutureProvider<BooksGrouped>((ref) async {
  final useCase = ref.watch(getAllBooksUseCaseProvider);
  final result = await useCase.grouped();
  return result.when(
    success: (grouped) => grouped,
    failure: (f) => throw Exception(f.message),
  );
});

/// 현재 읽는 장(Chapter) 파라미터.
final currentChapterParamsProvider = StateProvider<GetChapterParams>((ref) {
  return const GetChapterParams(
    bookId: 1, // Genesis
    chapter: 1,
    translationCode: 'KJV',
  );
});

/// 현재 장 내용 StreamProvider (파라미터 변경 시 자동 갱신).
final currentChapterProvider = FutureProvider<ChapterContent>((ref) async {
  final params = ref.watch(currentChapterParamsProvider);
  final useCase = ref.watch(getChapterUseCaseProvider);
  final result = await useCase(params);
  return result.when(
    success: (content) => content,
    failure: (f) => throw Exception(f.message),
  );
});

/// 특정 번역본 로드 여부.
final isTranslationLoadedProvider = FutureProvider.family<bool, String>((
  ref,
  translationCode,
) async {
  final repo = ref.watch(bibleRepositoryProvider);
  final result = await repo.isTranslationLoaded(translationCode);
  return result.valueOrNull ?? false;
});

/// 로드된 번역본 목록.
final loadedTranslationsProvider = FutureProvider<List<String>>((ref) async {
  final repo = ref.watch(bibleRepositoryProvider);
  final result = await repo.getLoadedTranslations();
  return result.valueOrNull ?? [];
});
