// lib/features/bible/presentation/providers/bible_reader_provider.dart
// [NEW] 성경 읽기 화면 StateNotifier + State

import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../dictionary/domain/services/dictionary_query_normalizer.dart';
import '../../../settings/presentation/providers/settings_provider.dart';
import '../../domain/entities/chapter_reading_position.dart';
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
    this.scrollVerse = 1,
    this.scrollFraction = 0,
    this.scrollOffset = 0,
    this.selectedVerseNumbers = const {},
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
  final int scrollVerse;
  final double scrollFraction;
  final double scrollOffset;

  /// 길게 누른 뒤 선택된 절 번호들.
  final Set<int> selectedVerseNumbers;

  bool get isVerseSelectionActive => selectedVerseNumbers.isNotEmpty;

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
    int? scrollVerse,
    double? scrollFraction,
    double? scrollOffset,
    Set<int>? selectedVerseNumbers,
    bool clearVerseSelection = false,
    String? tappedWord,
    int? tappedBookId,
    int? tappedChapter,
    int? tappedVerse,
    String? tappedTranslationCode,
    bool clearTappedWord = false,
  }) => BibleReaderState(
    bookId: bookId ?? this.bookId,
    chapter: chapter ?? this.chapter,
    translationCode: translationCode ?? this.translationCode,
    isParallelView: isParallelView ?? this.isParallelView,
    parallelTranslationCode:
        parallelTranslationCode ?? this.parallelTranslationCode,
    autoScrollEnabled: autoScrollEnabled ?? this.autoScrollEnabled,
    scrollVerse: scrollVerse ?? this.scrollVerse,
    scrollFraction: scrollFraction ?? this.scrollFraction,
    scrollOffset: scrollOffset ?? this.scrollOffset,
    selectedVerseNumbers:
        clearVerseSelection
            ? const {}
            : selectedVerseNumbers ?? this.selectedVerseNumbers,
    tappedWord: clearTappedWord ? null : tappedWord ?? this.tappedWord,
    tappedBookId: clearTappedWord ? null : tappedBookId ?? this.tappedBookId,
    tappedChapter: clearTappedWord ? null : tappedChapter ?? this.tappedChapter,
    tappedVerse: clearTappedWord ? null : tappedVerse ?? this.tappedVerse,
    tappedTranslationCode:
        clearTappedWord
            ? null
            : tappedTranslationCode ?? this.tappedTranslationCode,
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
          scrollVerse == other.scrollVerse &&
          scrollFraction == other.scrollFraction &&
          scrollOffset == other.scrollOffset &&
          _setsEqual(selectedVerseNumbers, other.selectedVerseNumbers) &&
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
    scrollVerse,
    scrollFraction,
    scrollOffset,
    Object.hashAllUnordered(selectedVerseNumbers),
    tappedWord,
    tappedBookId,
    tappedChapter,
    tappedVerse,
    tappedTranslationCode,
  );

  static bool _setsEqual(Set<int> left, Set<int> right) =>
      left.length == right.length && left.containsAll(right);
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
  final Map<(int, int), ChapterReadingPosition> _chapterPositions = {};
  int? _activeReadingTabId;
  int _positionLoadGeneration = 0;

  // ── Navigation ────────────────────────────────────────────────────

  void navigateTo({required int bookId, required int chapter, int? verse}) {
    _cacheCurrentPosition(persist: true);
    final restored =
        verse == null ? _chapterPositions[(bookId, chapter)] : null;
    state = state.copyWith(
      bookId: bookId,
      chapter: chapter,
      scrollVerse:
          verse == null ? restored?.scrollVerse ?? 1 : verse.clamp(1, 999),
      scrollFraction: restored?.scrollFraction ?? 0,
      scrollOffset: restored?.scrollOffset ?? 0,
      clearVerseSelection: true,
      clearTappedWord: true,
    );
    _syncToChapterParams();
  }

  Future<void> restoreReadingTab(BibleReadingTab tab) async {
    _activeReadingTabId = tab.id;
    _chapterPositions.clear();
    final generation = ++_positionLoadGeneration;
    state = BibleReaderState(
      bookId: tab.bookId,
      chapter: tab.chapter,
      translationCode: tab.translationCode,
      isParallelView: tab.isParallelView,
      parallelTranslationCode: tab.parallelTranslationCode,
      scrollVerse: tab.scrollVerse,
      scrollFraction: tab.scrollFraction,
      scrollOffset: tab.scrollOffset,
    );
    _chapterPositions[(tab.bookId, tab.chapter)] = ChapterReadingPosition(
      readingTabId: tab.id,
      bookId: tab.bookId,
      chapter: tab.chapter,
      scrollVerse: tab.scrollVerse,
      scrollFraction: tab.scrollFraction,
      scrollOffset: tab.scrollOffset,
      updatedAt: tab.updatedAt,
    );
    _syncToChapterParams();
    try {
      final positions = await _ref
          .read(readingTabsRepositoryProvider)
          .getChapterPositions(tab.id);
      if (_activeReadingTabId != tab.id ||
          generation != _positionLoadGeneration) {
        return;
      }
      for (final position in positions) {
        final key = (position.bookId, position.chapter);
        final cached = _chapterPositions[key];
        if (cached == null || position.updatedAt.isAfter(cached.updatedAt)) {
          _chapterPositions[key] = position;
        }
      }
      final latest = _chapterPositions[(state.bookId, state.chapter)];
      if (latest != null && latest.updatedAt.isAfter(tab.updatedAt)) {
        state = state.copyWith(
          scrollVerse: latest.scrollVerse,
          scrollFraction: latest.scrollFraction,
          scrollOffset: latest.scrollOffset,
        );
      }
    } on Object {
      // The active tab remains usable even if historical positions fail to load.
    }
  }

  void goToNextChapter(int maxChapter) {
    if (state.chapter < maxChapter) {
      navigateTo(bookId: state.bookId, chapter: state.chapter + 1);
    }
  }

  void goToPreviousChapter() {
    if (state.chapter > 1) {
      navigateTo(bookId: state.bookId, chapter: state.chapter - 1);
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
      clearVerseSelection: true,
      clearTappedWord: true,
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
    state = state.copyWith(clearTappedWord: true);
  }

  void selectVerse(int verseNumber) {
    state = state.copyWith(selectedVerseNumbers: {verseNumber});
  }

  void toggleVerseSelection(int verseNumber) {
    final selected = {...state.selectedVerseNumbers};
    if (!selected.add(verseNumber)) selected.remove(verseNumber);
    state = state.copyWith(
      selectedVerseNumbers: selected,
      clearVerseSelection: selected.isEmpty,
    );
  }

  void clearVerseSelection() {
    state = state.copyWith(clearVerseSelection: true);
  }

  void updateReadingPosition({
    required int verse,
    required double fraction,
    required double offset,
  }) {
    final safeVerse = verse < 1 ? 1 : verse;
    final safeFraction = fraction.clamp(0.0, 1.0);
    final safeOffset = offset < 0 ? 0.0 : offset;
    if (state.scrollVerse == safeVerse &&
        (state.scrollFraction - safeFraction).abs() < 0.001 &&
        (state.scrollOffset - safeOffset).abs() < 0.5) {
      return;
    }
    state = state.copyWith(
      scrollVerse: safeVerse,
      scrollFraction: safeFraction,
      scrollOffset: safeOffset,
    );
    _cacheCurrentPosition();
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

  void _cacheCurrentPosition({bool persist = false}) {
    final readingTabId = _activeReadingTabId;
    if (readingTabId == null) return;
    final position = ChapterReadingPosition(
      readingTabId: readingTabId,
      bookId: state.bookId,
      chapter: state.chapter,
      scrollVerse: state.scrollVerse,
      scrollFraction: state.scrollFraction,
      scrollOffset: state.scrollOffset,
      updatedAt: DateTime.now(),
    );
    _chapterPositions[(state.bookId, state.chapter)] = position;
    if (persist) unawaited(_persistPosition(position));
  }

  Future<void> _persistPosition(ChapterReadingPosition position) async {
    try {
      await _ref
          .read(readingTabsRepositoryProvider)
          .saveChapterPosition(position);
    } on Object {
      // The in-memory location still restores correctly during this session.
    }
  }
}

// ── Providers ─────────────────────────────────────────────────────────

final bibleReaderProvider =
    StateNotifierProvider<BibleReaderNotifier, BibleReaderState>((ref) {
      return BibleReaderNotifier(ref);
    });
