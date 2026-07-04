// test/helpers/provider_container_helper.dart
// [NEW] Riverpod ProviderContainer 헬퍼 (테스트용)

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:offline_english_bible/core/database/app_database.dart';
import 'package:offline_english_bible/core/di/providers.dart';
import 'package:offline_english_bible/features/settings/presentation/providers/settings_provider.dart';

/// 테스트용 ProviderContainer 생성.
/// overrides 로 실제 의존성을 인메모리/mock 으로 교체한다.
ProviderContainer createTestContainer({
  AppDatabase? db,
  Box<dynamic>? settingsBox,
  List<Override> additionalOverrides = const [],
}) {
  final testDb = db ?? AppDatabase(createInMemoryConnection());
  final testBox = settingsBox ?? _createEmptyBox();

  return ProviderContainer(
    overrides: [
      appDatabaseOverride(testDb),
      settingsBoxProvider.overrideWithValue(testBox),
      ...additionalOverrides,
    ],
  );
}

Box<dynamic> _createEmptyBox() {
  // 테스트용 인메모리 Box (Hive 미초기화 환경)
  return _InMemoryBox();
}

/// Hive Box 를 초기화 없이 사용하기 위한 인메모리 구현.
class _InMemoryBox extends Box<dynamic> {
  final _store = <dynamic, dynamic>{};

  @override
  dynamic get(dynamic key, {dynamic defaultValue}) =>
      _store[key] ?? defaultValue;

  @override
  Future<void> put(dynamic key, dynamic value) async => _store[key] = value;

  @override
  bool get isOpen => true;

  @override
  String get name => 'test_settings';

  @override
  bool containsKey(dynamic key) => _store.containsKey(key);

  @override
  Future<void> close() async {}

  @override
  Future<void> clear() async => _store.clear();

  @override
  int get length => _store.length;

  @override
  bool get isEmpty => _store.isEmpty;

  @override
  bool get isNotEmpty => _store.isNotEmpty;

  @override
  Iterable<dynamic> get keys => _store.keys;

  @override
  Iterable<dynamic> get values => _store.values;

  @override
  dynamic getAt(int index) => _store.values.elementAt(index);

  @override
  Future<void> putAll(Map<dynamic, dynamic> entries) async =>
      _store.addAll(entries);

  @override
  Future<void> delete(dynamic key) async => _store.remove(key);

  @override
  Future<void> deleteAll(Iterable<dynamic> keys) async {
    for (final k in keys) {
      _store.remove(k);
    }
  }

  @override
  Map<dynamic, dynamic> toMap() => Map.from(_store);

  @override
  dynamic operator [](dynamic key) => _store[key];

  @override
  void operator []=(dynamic key, dynamic value) => _store[key] = value;

  @override
  bool get lazy => false;

  @override
  String? get path => null;

  @override
  Future<int> add(dynamic value) async {
    final key = _store.length;
    _store[key] = value;
    return key;
  }

  @override
  Future<Iterable<int>> addAll(Iterable<dynamic> values) async {
    final keys = <int>[];
    for (final v in values) {
      keys.add(await add(v));
    }
    return keys;
  }

  @override
  Future<void> compact() async {}

  @override
  Future<void> deleteAt(int index) async {
    final key = _store.keys.elementAt(index);
    _store.remove(key);
  }

  @override
  Future<void> deleteFromDisk() async {}

  @override
  Future<void> flush() async {}

  @override
  Future<void> putAt(int index, dynamic value) async {
    final key = _store.keys.elementAt(index);
    _store[key] = value;
  }

  @override
  Stream<BoxEvent> watch({dynamic key}) => const Stream.empty();

  @override
  Iterable<dynamic> valuesBetween({dynamic startKey, dynamic endKey}) =>
      _store.values;

  @override
  Iterable<dynamic> keysBetween({dynamic startKey, dynamic endKey}) =>
      _store.keys;
}
