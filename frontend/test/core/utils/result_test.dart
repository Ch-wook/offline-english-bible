// test/core/utils/result_test.dart
// [NEW] Result<S, F> 타입 유닛 테스트

import 'package:flutter_test/flutter_test.dart';
import 'package:offline_english_bible/core/error/failures.dart';
import 'package:offline_english_bible/core/utils/result.dart';

void main() {
  group('Result', () {
    // ── Success ─────────────────────────────────────────────────────

    group('Success', () {
      test('isSuccess returns true', () {
        const result = Success<String, Failure>('hello');
        expect(result.isSuccess, isTrue);
        expect(result.isFailure, isFalse);
      });

      test('valueOrNull returns value', () {
        const result = Success<int, Failure>(42);
        expect(result.valueOrNull, 42);
      });

      test('failureOrNull returns null', () {
        const result = Success<int, Failure>(42);
        expect(result.failureOrNull, isNull);
      });

      test('when calls success branch', () {
        const result = Success<String, Failure>('hello');
        final output = result.when(
          success: (v) => 'got: $v',
          failure: (_) => 'failed',
        );
        expect(output, 'got: hello');
      });

      test('map transforms value', () {
        const result = Success<int, Failure>(5);
        final mapped = result.map((v) => v * 2);
        expect(mapped.valueOrNull, 10);
      });

      test('flatMap chains results', () {
        const result = Success<int, Failure>(5);
        final chained = result.flatMap(
          (v) => v > 0
              ? Success(v.toString())
              : const FailureResult<String, Failure>(ValidationFailure('negative')),
        );
        expect(chained.valueOrNull, '5');
      });

      test('equality works', () {
        const a = Success<int, Failure>(1);
        const b = Success<int, Failure>(1);
        const c = Success<int, Failure>(2);
        expect(a, equals(b));
        expect(a, isNot(equals(c)));
      });

      test('toString is descriptive', () {
        const result = Success<String, Failure>('test');
        expect(result.toString(), contains('success'));
        expect(result.toString(), contains('test'));
      });
    });

    // ── FailureResult ────────────────────────────────────────────────

    group('FailureResult', () {
      const failure = DatabaseFailure('DB error');

      test('isFailure returns true', () {
        const result = FailureResult<String, Failure>(failure);
        expect(result.isFailure, isTrue);
        expect(result.isSuccess, isFalse);
      });

      test('valueOrNull returns null', () {
        const result = FailureResult<String, Failure>(failure);
        expect(result.valueOrNull, isNull);
      });

      test('failureOrNull returns failure', () {
        const result = FailureResult<String, Failure>(failure);
        expect(result.failureOrNull, failure);
      });

      test('when calls failure branch', () {
        const result = FailureResult<String, Failure>(failure);
        final output = result.when(
          success: (_) => 'ok',
          failure: (f) => f.message,
        );
        expect(output, 'DB error');
      });

      test('map passes failure through', () {
        const result = FailureResult<int, Failure>(failure);
        final mapped = result.map((v) => v * 2);
        expect(mapped.isFailure, isTrue);
        expect(mapped.failureOrNull, failure);
      });

      test('flatMap passes failure through', () {
        const result = FailureResult<int, Failure>(failure);
        final chained = result.flatMap(
          (v) => Success(v + 1),
        );
        expect(chained.isFailure, isTrue);
      });

      test('equality works', () {
        const a = FailureResult<int, Failure>(failure);
        const b = FailureResult<int, Failure>(failure);
        const c = FailureResult<int, Failure>(
          NetworkFailure('net'),
        );
        expect(a, equals(b));
        expect(a, isNot(equals(c)));
      });
    });

    // ── runCatchingAsync ─────────────────────────────────────────────

    group('runCatchingAsync', () {
      test('returns Success on no exception', () async {
        final result = await runCatchingAsync(() async => 42);
        expect(result.valueOrNull, 42);
      });

      test('returns FailureResult on exception', () async {
        final result = await runCatchingAsync<int>(
          () async => throw Exception('boom'),
        );
        expect(result.isFailure, isTrue);
      });

      test('uses custom onError handler', () async {
        final result = await runCatchingAsync<int>(
          () async => throw Exception('boom'),
          onError: (e, _) => const NetworkFailure('custom'),
        );
        expect(result.failureOrNull, isA<NetworkFailure>());
        expect(result.failureOrNull?.message, 'custom');
      });
    });

    // ── whenSuccess / whenFailure ────────────────────────────────────

    group('whenSuccess / whenFailure', () {
      test('whenSuccess returns value on success', () {
        const result = Success<int, Failure>(10);
        expect(result.whenSuccess((v) => v * 2), 20);
      });

      test('whenSuccess returns null on failure', () {
        const result = FailureResult<int, Failure>(
          DatabaseFailure('err'),
        );
        expect(result.whenSuccess((v) => v * 2), isNull);
      });

      test('whenFailure returns value on failure', () {
        const result = FailureResult<int, Failure>(
          NetworkFailure('timeout'),
        );
        expect(result.whenFailure((f) => f.message), 'timeout');
      });

      test('whenFailure returns null on success', () {
        const result = Success<int, Failure>(5);
        expect(result.whenFailure((f) => f.message), isNull);
      });
    });
  });

  // ── Failure Equality ─────────────────────────────────────────────────

  group('Failure', () {
    test('same type and message are equal', () {
      const a = DatabaseFailure('error');
      const b = DatabaseFailure('error');
      expect(a, equals(b));
    });

    test('different types are not equal', () {
      const a = DatabaseFailure('error');
      const b = NetworkFailure('error');
      expect(a, isNot(equals(b)));
    });

    test('WordNotFoundFailure has word in message', () {
      const f = WordNotFoundFailure('grace');
      expect(f.message, contains('grace'));
    });

    test('ChapterNotFoundFailure has book and chapter info', () {
      const f = ChapterNotFoundFailure(book: 1, chapter: 999);
      expect(f.message, contains('999'));
    });
  });
}
