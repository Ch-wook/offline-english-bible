// lib/features/bible/presentation/providers/bible_reader_provider.dart
// [NEW] 성경 읽기 화면 StateNotifier + State

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../dictionary/domain/services/dictionary_query_normalizer.dart';
import '../../../settings/presentation/providers/settings_provider.dart';
import '../../domain/entities/reading_tab.dart';
import '../../domain/entities/verse.dart';
import '../../domain/usecases/get_chapter_usecase.dart';
import '../providers/bible_providers.dart';

// ── State ─────────────────────────────────────────────────────────────

final class BibleReaderState {
  const BibleReaderState({
    this.bookId = 1,
    this.chapter = 1,
    this.translationCode = 'KJV',
    this.isParallelView = false,
    this.parallelTranslationCode = 'KOREAN_RV',
    this.autoScrollEnabled = false,
    this.selectedVerseNumber,
    this.tappedWord,
    this.tappedBookId,
    this.tappedChapter,
    this.tappedVerse,
    this.tappedTranslationCode,
  });

  final int bookId;
  final int chapter;
  final String translationCode;
  final bool isParallelView;
  final String parallelTranslationCode;
  final bool autoScrollEnabled;

  /// 길게 눌린 절 번호 (형광펜/북마크 메뉴 표시용).
  final int? selectedVerseNumber;

  /// 탭된 단어 (사전 바텀시트 트리거).
  final String? tappedWord;
  final int? tappedBookId;
  final int? tappedChapter;
  final int? tappedVerse;
  final String? tappedTranslationCode;

  GetChapterParams toChapterParams() => GetChapterParams(
    bookId: bookId,
    chapter: chapter,
    translationCode: translationCode,
    parallelTranslationCode: isParallelView ? parallelTranslationCode : null,
  );

  BibleReaderState copyWith({
    int? bookId,
    int? chapter,
    String? translationCode,
    bool? isParallelView,
    String? parallelTranslationCode,
    bool? autoScrollEnabled,
    int? selectedVerseNumber,
    String? tappedWord,
    int? tappedBookId,
    int? tappedChapter,
    int? tappedVerse,
    String? tappedTranslationCode,
  }) => BibleReaderState(
    bookId: bookId ?? this.bookId,
    chapter: chapter ?? this.chapter,
    translationCode: translationCode ?? this.translationCode,
    isParallelView: isParallelView ?? this.isParallelView,
    parallelTranslationCode:
        parallelTranslationCode ?? this.parallelTranslationCode,
    autoScrollEnabled: autoScrollEnabled ?? this.autoScrollEnabled,
    selectedVerseNumber: selectedVerseNumber,
    tappedWord: tappedWord,
    tappedBookId: tappedBookId,
    tappedChapter: tappedChapter,
    tappedVerse: tappedVerse,
    tappedTranslationCode: tappedTranslationCode,
  );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BibleReaderState &&
          bookId == other.bookId &&
          chapter == other.chapter &&
          translationCode == other.translationCode &&
          isParallelView == other.isParallelView &&
          parallelTranslationCode == other.parallelTranslationCode &&
          autoScrollEnabled == other.autoScrollEnabled &&
          selectedVerseNumber == other.selectedVerseNumber &&
          tappedWord == other.tappedWord &&
          tappedBookId == other.tappedBookId &&
          tappedChapter == other.tappedChapter &&
          tappedVerse == other.tappedVerse &&
          tappedTranslationCode == other.tappedTranslationCode;

  @override
  int get hashCode => Object.hash(
    bookId,
    chapter,
    translationCode,
    isParallelView,
    parallelTranslationCode,
    autoScrollEnabled,
    selectedVerseNumber,
    tappedWord,
    tappedBookId,
    tappedChapter,
    tappedVerse,
    tappedTranslationCode,
  );
}

// ── Notifier ──────────────────────────────────────────────────────────

class BibleReaderNotifier extends StateNotifier<BibleReaderState> {
  BibleReaderNotifier(this._ref) : super(const BibleReaderState()) {
    // 초기값을 Settings 에서 로드
    final settings = _ref.read(settingsProvider);
    state = BibleReaderState(
      translationCode: settings.defaultTranslation,
      parallelTranslationCode:
          settings.defaultTranslation == 'KJV'
              ? settings.defaultKoreanTranslation
              : 'KJV',
      isParallelView: settings.parallelView,
    );
    // 생성자 완료 후 다른 provider에 sync (즉시 호출 시 assertion 에러)
    Future.microtask(_syncToChapterParams);
  }

  final Ref _ref;

  // ── Navigation ────────────────────────────────────────────────────

  void navigateTo({required int bookId, required int chapter}) {
    state = state.copyWith(bookId: bookId, chapter: chapter);
    _syncToChapterParams();
  }

  void restoreReadingTab(BibleReadingTab tab) {
    state = BibleReaderState(
      bookId: tab.bookId,
      chapter: tab.chapter,
      translationCode: tab.translationCode,
      isParallelView: tab.isParallelView,
      parallelTranslationCode: tab.parallelTranslationCode,
    );
    _syncToChapterParams();
  }

  void goToNextChapter(int maxChapter) {
    if (state.chapter < maxChapter) {
      state = state.copyWith(chapter: state.chapter + 1);
      _syncToChapterParams();
    }
  }

  void goToPreviousChapter() {
    if (state.chapter > 1) {
      state = state.copyWith(chapter: state.chapter - 1);
      _syncToChapterParams();
    }
  }

  // ── Translation ───────────────────────────────────────────────────

  void setTranslation(String code) {
    String newParallel = state.parallelTranslationCode;

    if (code == 'KOREAN_RV') {
      newParallel = 'KJV';
    } else if (code == 'KJV') {
      newParallel = 'KOREAN_RV';
    }

    state = state.copyWith(
      translationCode: code,
      parallelTranslationCode: newParallel,
    );
    _syncToChapterParams();
  }

  void toggleParallelView() {
    state = state.copyWith(isParallelView: !state.isParallelView);
    _syncToChapterParams();
  }

  void setParallelTranslation(String code) {
    state = state.copyWith(parallelTranslationCode: code);
    _syncToChapterParams();
  }

  // ── Word / Verse Interaction ──────────────────────────────────────

  void onWordTap(String word, {Verse? source}) {
    // 구두점 제거 후 소문자화
    final cleaned = const DictionaryQueryNormalizer().normalize(word);
    if (cleaned.isEmpty) return;
    state = state.copyWith(
      tappedWord: cleaned,
      tappedBookId: source?.bookId ?? state.bookId,
      tappedChapter: source?.chapter ?? state.chapter,
      tappedVerse: source?.verseNumber ?? 0,
      tappedTranslationCode: source?.translationCode ?? state.translationCode,
    );
  }

  void clearWordTap() {
    state = state.copyWith();
  }

  void selectVerse(int verseNumber) {
    state = state.copyWith(selectedVerseNumber: verseNumber);
  }

  void clearVerseSelection() {
    state = state.copyWith();
  }

  // ── Auto Scroll ───────────────────────────────────────────────────

  void toggleAutoScroll() {
    state = state.copyWith(autoScrollEnabled: !state.autoScrollEnabled);
  }

  // ── Private ───────────────────────────────────────────────────────

  void _syncToChapterParams() {
    _ref.read(currentChapterParamsProvider.notifier).state =
        state.toChapterParams();
  }
}

// ── Providers ─────────────────────────────────────────────────────────

final bibleReaderProvider =
    StateNotifierProvider<BibleReaderNotifier, BibleReaderState>((ref) {
      return BibleReaderNotifier(ref);
    });
