import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/chapter_reading_position.dart';
import '../../domain/entities/reading_tab.dart';
import '../../domain/repositories/reading_tabs_repository.dart';
import 'bible_providers.dart';
import 'bible_reader_provider.dart';

const maxBibleReadingTabs = 6;

final class ReadingTabsState {
  const ReadingTabsState({required this.tabs, required this.activeTabId});

  final List<BibleReadingTab> tabs;
  final int activeTabId;

  BibleReadingTab get activeTab =>
      tabs.firstWhere((tab) => tab.id == activeTabId);

  ReadingTabsState copyWith({List<BibleReadingTab>? tabs, int? activeTabId}) =>
      ReadingTabsState(
        tabs: tabs ?? this.tabs,
        activeTabId: activeTabId ?? this.activeTabId,
      );
}

final class ReadingTabsNotifier
    extends StateNotifier<AsyncValue<ReadingTabsState>> {
  ReadingTabsNotifier(this._ref, this._repository)
    : super(const AsyncLoading()) {
    Future.microtask(_load);
  }

  final Ref _ref;
  final ReadingTabsRepository _repository;
  Future<void> _saveQueue = Future.value();
  bool _isMutating = false;

  Future<void> reload() async {
    state = const AsyncLoading();
    await _load();
  }

  Future<void> _load() async {
    try {
      var tabs = await _repository.getTabs();
      if (tabs.isEmpty) {
        final reader = _ref.read(bibleReaderProvider);
        final created = await _repository.createTab(
          bookId: reader.bookId,
          chapter: reader.chapter,
          translationCode: reader.translationCode,
          isParallelView: reader.isParallelView,
          parallelTranslationCode: reader.parallelTranslationCode,
          scrollVerse: reader.scrollVerse,
          scrollFraction: reader.scrollFraction,
          scrollOffset: reader.scrollOffset,
          sortOrder: 0,
        );
        tabs = [created];
      }

      var active = tabs.where((tab) => tab.isActive).firstOrNull;
      active ??= tabs.first;
      if (!active.isActive || tabs.where((tab) => tab.isActive).length != 1) {
        await _repository.setActiveTab(active.id);
        tabs = [
          for (final tab in tabs) tab.copyWith(isActive: tab.id == active.id),
        ];
        active = tabs.firstWhere((tab) => tab.id == active!.id);
      }

      await _ref.read(bibleReaderProvider.notifier).restoreReadingTab(active);
      state = AsyncData(ReadingTabsState(tabs: tabs, activeTabId: active.id));
    } catch (error, stackTrace) {
      state = AsyncError(error, stackTrace);
    }
  }

  Future<bool> addTab() async {
    final current = state.valueOrNull;
    if (current == null ||
        current.tabs.length >= maxBibleReadingTabs ||
        _isMutating) {
      return false;
    }

    _isMutating = true;
    try {
      final reader = _ref.read(bibleReaderProvider);
      await syncActiveLocation(reader);
      final syncedCurrent = state.valueOrNull ?? current;
      final created = await _repository.createTab(
        bookId: reader.bookId,
        chapter: reader.chapter,
        translationCode: reader.translationCode,
        isParallelView: reader.isParallelView,
        parallelTranslationCode: reader.parallelTranslationCode,
        scrollVerse: reader.scrollVerse,
        scrollFraction: reader.scrollFraction,
        scrollOffset: reader.scrollOffset,
        sortOrder: syncedCurrent.tabs.length,
      );
      final tabs = [
        for (final tab in syncedCurrent.tabs) tab.copyWith(isActive: false),
        created,
      ];
      state = AsyncData(ReadingTabsState(tabs: tabs, activeTabId: created.id));
      await _ref.read(bibleReaderProvider.notifier).restoreReadingTab(created);
      return true;
    } catch (error, stackTrace) {
      state = AsyncError(error, stackTrace);
      return false;
    } finally {
      _isMutating = false;
    }
  }

  Future<void> selectTab(int id) async {
    final current = state.valueOrNull;
    if (current == null || current.activeTabId == id || _isMutating) return;
    if (!current.tabs.any((tab) => tab.id == id)) return;

    _isMutating = true;
    try {
      await syncActiveLocation(_ref.read(bibleReaderProvider));
      final syncedCurrent = state.valueOrNull ?? current;
      await _repository.setActiveTab(id);
      final tabs = [
        for (final tab in syncedCurrent.tabs)
          tab.copyWith(isActive: tab.id == id),
      ];
      final active = tabs.firstWhere((tab) => tab.id == id);
      state = AsyncData(ReadingTabsState(tabs: tabs, activeTabId: id));
      await _ref.read(bibleReaderProvider.notifier).restoreReadingTab(active);
    } catch (error, stackTrace) {
      state = AsyncError(error, stackTrace);
    } finally {
      _isMutating = false;
    }
  }

  Future<bool> closeTab(int id) async {
    final current = state.valueOrNull;
    if (current == null || current.tabs.length <= 1 || _isMutating) {
      return false;
    }

    final closingIndex = current.tabs.indexWhere((tab) => tab.id == id);
    if (closingIndex < 0) return false;
    _isMutating = true;
    try {
      if (id == current.activeTabId) {
        await syncActiveLocation(_ref.read(bibleReaderProvider));
      }
      final syncedCurrent = state.valueOrNull ?? current;
      final remaining =
          syncedCurrent.tabs.where((tab) => tab.id != id).toList();
      var activeId = current.activeTabId;

      if (id == current.activeTabId) {
        final replacementIndex = closingIndex.clamp(0, remaining.length - 1);
        activeId = remaining[replacementIndex].id;
        await _repository.setActiveTab(activeId);
      }
      await _repository.deleteTab(id);

      final tabs = [
        for (var i = 0; i < remaining.length; i++)
          remaining[i].copyWith(
            sortOrder: i,
            isActive: remaining[i].id == activeId,
          ),
      ];
      state = AsyncData(ReadingTabsState(tabs: tabs, activeTabId: activeId));

      for (final tab in tabs) {
        await _repository.updateTab(tab);
      }
      if (id == current.activeTabId) {
        final active = tabs.firstWhere((tab) => tab.id == activeId);
        await _ref.read(bibleReaderProvider.notifier).restoreReadingTab(active);
      }
      return true;
    } catch (error, stackTrace) {
      state = AsyncError(error, stackTrace);
      return false;
    } finally {
      _isMutating = false;
    }
  }

  Future<void> syncActiveLocation(BibleReaderState reader) async {
    final current = state.valueOrNull;
    if (current == null) return;
    final active = current.activeTab;
    if (active.bookId == reader.bookId &&
        active.chapter == reader.chapter &&
        active.translationCode == reader.translationCode &&
        active.isParallelView == reader.isParallelView &&
        active.parallelTranslationCode == reader.parallelTranslationCode &&
        active.scrollVerse == reader.scrollVerse &&
        (active.scrollFraction - reader.scrollFraction).abs() < 0.001 &&
        (active.scrollOffset - reader.scrollOffset).abs() < 0.5) {
      return;
    }

    final now = DateTime.now();
    final updated = active.copyWith(
      bookId: reader.bookId,
      chapter: reader.chapter,
      translationCode: reader.translationCode,
      isParallelView: reader.isParallelView,
      parallelTranslationCode: reader.parallelTranslationCode,
      scrollVerse: reader.scrollVerse,
      scrollFraction: reader.scrollFraction,
      scrollOffset: reader.scrollOffset,
      updatedAt: now,
    );
    final position = ChapterReadingPosition(
      readingTabId: active.id,
      bookId: reader.bookId,
      chapter: reader.chapter,
      scrollVerse: reader.scrollVerse,
      scrollFraction: reader.scrollFraction,
      scrollOffset: reader.scrollOffset,
      updatedAt: now,
    );
    final tabs = [
      for (final tab in current.tabs)
        if (tab.id == updated.id) updated else tab,
    ];
    state = AsyncData(current.copyWith(tabs: tabs));
    _saveQueue = _saveQueue
        .then((_) async {
          await _repository.saveChapterPosition(position);
          await _repository.updateTab(updated);
        })
        .catchError((Object error, StackTrace stackTrace) {
          state = AsyncError(error, stackTrace);
        });
    await _saveQueue;
  }
}

final readingTabsProvider =
    StateNotifierProvider<ReadingTabsNotifier, AsyncValue<ReadingTabsState>>((
      ref,
    ) {
      return ReadingTabsNotifier(ref, ref.watch(readingTabsRepositoryProvider));
    });

final readingTabsAutoSaveProvider = Provider<void>((ref) {
  ref.read(readingTabsProvider);
  ref.listen<BibleReaderState>(bibleReaderProvider, (previous, next) {
    if (previous == null ||
        previous.bookId != next.bookId ||
        previous.chapter != next.chapter ||
        previous.translationCode != next.translationCode ||
        previous.isParallelView != next.isParallelView ||
        previous.parallelTranslationCode != next.parallelTranslationCode ||
        previous.scrollVerse != next.scrollVerse ||
        (previous.scrollFraction - next.scrollFraction).abs() >= 0.001 ||
        (previous.scrollOffset - next.scrollOffset).abs() >= 0.5) {
      ref.read(readingTabsProvider.notifier).syncActiveLocation(next);
    }
  });
});
