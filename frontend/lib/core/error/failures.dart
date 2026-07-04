// lib/core/error/failures.dart
// [NEW] 앱 전체 실패 타입 정의 (sealed class)

import 'package:equatable/equatable.dart';

/// 앱의 모든 실패 케이스를 표현하는 sealed class.
/// Repository 는 항상 Either<Failure, T> 또는 Result<T, Failure> 를 반환한다.
sealed class Failure extends Equatable {
  const Failure(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}

// ── Database Failures ────────────────────────────────────────────────
final class DatabaseFailure extends Failure {
  const DatabaseFailure(super.message);
}

final class RecordNotFoundFailure extends Failure {
  const RecordNotFoundFailure(super.message);
}

// ── Dictionary Failures ──────────────────────────────────────────────
final class WordNotFoundFailure extends Failure {
  const WordNotFoundFailure(String word)
      : super('Word not found in dictionary: $word');
}

final class StrongNumberNotFoundFailure extends Failure {
  const StrongNumberNotFoundFailure(String number)
      : super("Strong's number not found: $number");
}

// ── Bible Failures ───────────────────────────────────────────────────
final class BibleDataNotLoadedFailure extends Failure {
  const BibleDataNotLoadedFailure()
      : super('Bible data has not been loaded yet. Please wait.');
}

final class TranslationNotAvailableFailure extends Failure {
  const TranslationNotAvailableFailure(String code)
      : super('Translation not available: $code');
}

final class ChapterNotFoundFailure extends Failure {
  const ChapterNotFoundFailure({required int book, required int chapter})
      : super('Chapter not found: Book $book, Chapter $chapter');
}

// ── Network / Sync Failures ──────────────────────────────────────────
final class NetworkFailure extends Failure {
  const NetworkFailure(super.message);
}

final class UnauthorizedFailure extends Failure {
  const UnauthorizedFailure() : super('Session expired. Please login again.');
}

final class ServerFailure extends Failure {
  const ServerFailure(super.message);

  const ServerFailure.unknown() : super('An unexpected server error occurred.');
}

// ── Validation Failures ──────────────────────────────────────────────
final class ValidationFailure extends Failure {
  const ValidationFailure(super.message);
}

// ── Storage Failures ─────────────────────────────────────────────────
final class StorageFailure extends Failure {
  const StorageFailure(super.message);
}

final class PermissionFailure extends Failure {
  const PermissionFailure(super.message);
}

// ── Audio Failures ───────────────────────────────────────────────────
final class AudioFailure extends Failure {
  const AudioFailure(super.message);
}

final class AudioFileNotFoundFailure extends Failure {
  const AudioFileNotFoundFailure(String path)
      : super('Audio file not found: $path');
}
