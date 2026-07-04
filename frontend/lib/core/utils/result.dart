// lib/core/utils/result.dart
// [NEW] Result<S, F> 패턴 — Railway Oriented Programming

import 'package:offline_english_bible/core/error/failures.dart';

/// Result type that represents either a successful value [S] or a failure [F].
///
/// Usage:
/// ```dart
/// Result<String, Failure> result = Success('Hello');
/// result.when(
///   success: (value) => print(value),
///   failure: (f) => print(f.message),
/// );
/// ```
sealed class Result<S, F extends Failure> {
  const Result();

  /// Returns true if this is a [Success].
  bool get isSuccess => this is Success<S, F>;

  /// Returns true if this is a [Failure].
  bool get isFailure => this is Failure<S, F>;

  /// Returns the success value or null.
  S? get valueOrNull => switch (this) {
        Success(value: final v) => v,
        Failure() => null,
      };

  /// Returns the failure or null.
  F? get failureOrNull => switch (this) {
        Success() => null,
        FailureResult(failure: final f) => f,
      };

  /// Transforms the success value using [mapper], passing failures through.
  Result<T, F> map<T>(T Function(S value) mapper) => switch (this) {
        Success(value: final v) => Success(mapper(v)),
        FailureResult(failure: final f) => FailureResult(f),
      };

  /// Transforms the success value using a mapper that also returns a Result.
  Result<T, F> flatMap<T>(Result<T, F> Function(S value) mapper) =>
      switch (this) {
        Success(value: final v) => mapper(v),
        FailureResult(failure: final f) => FailureResult(f),
      };

  /// Executes [onSuccess] or [onFailure] based on the result type.
  T when<T>({
    required T Function(S value) success,
    required T Function(F failure) failure,
  }) =>
      switch (this) {
        Success(value: final v) => success(v),
        FailureResult(failure: final f) => failure(f),
      };

  /// Executes [onSuccess] if successful, returns null otherwise.
  T? whenSuccess<T>(T Function(S value) onSuccess) => switch (this) {
        Success(value: final v) => onSuccess(v),
        FailureResult() => null,
      };

  /// Executes [onFailure] if failed, returns null otherwise.
  T? whenFailure<T>(T Function(F failure) onFailure) => switch (this) {
        Success() => null,
        FailureResult(failure: final f) => onFailure(f),
      };

  @override
  String toString() => switch (this) {
        Success(value: final v) => 'Result.success($v)',
        FailureResult(failure: final f) => 'Result.failure(${f.message})',
      };
}

/// Represents a successful result containing a value.
final class Success<S, F extends Failure> extends Result<S, F> {
  const Success(this.value);

  final S value;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Success<S, F> &&
          runtimeType == other.runtimeType &&
          value == other.value;

  @override
  int get hashCode => value.hashCode;
}

/// Represents a failed result containing a [Failure].
final class FailureResult<S, F extends Failure> extends Result<S, F> {
  const FailureResult(this.failure);

  final F failure;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FailureResult<S, F> &&
          runtimeType == other.runtimeType &&
          failure == other.failure;

  @override
  int get hashCode => failure.hashCode;
}

// ── Convenience type aliases ──────────────────────────────────────────
typedef BibleResult<S> = Result<S, Failure>;

/// Wraps a throwing function into a Result.
Result<S, Failure> runCatching<S>(
  S Function() block, {
  Failure Function(Object error, StackTrace stack)? onError,
}) {
  try {
    return Success(block());
  } catch (e, stack) {
    if (onError != null) {
      return FailureResult(onError(e, stack));
    }
    return FailureResult(DatabaseFailure(e.toString()));
  }
}

/// Async version of [runCatching].
Future<Result<S, Failure>> runCatchingAsync<S>(
  Future<S> Function() block, {
  Failure Function(Object error, StackTrace stack)? onError,
}) async {
  try {
    return Success(await block());
  } catch (e, stack) {
    if (onError != null) {
      return FailureResult(onError(e, stack));
    }
    return FailureResult(DatabaseFailure(e.toString()));
  }
}
