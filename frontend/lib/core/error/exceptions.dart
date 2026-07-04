// lib/core/error/exceptions.dart
// [NEW] 데이터 레이어 예외 정의 (Data layer only — never cross domain boundary)

/// Base exception for all data layer exceptions.
sealed class AppException implements Exception {
  const AppException(this.message, {this.cause});

  final String message;
  final Object? cause;

  @override
  String toString() => '$runtimeType: $message${cause != null ? ' (caused by: $cause)' : ''}';
}

// ── Database Exceptions ──────────────────────────────────────────────
final class DatabaseException extends AppException {
  const DatabaseException(super.message, {super.cause});
}

final class RecordNotFoundException extends AppException {
  const RecordNotFoundException(String entity, dynamic id)
      : super('$entity with id=$id not found');
}

final class DatabaseInitException extends AppException {
  const DatabaseInitException(super.message, {super.cause});
}

final class MigrationException extends AppException {
  const MigrationException({required int from, required int to, super.cause})
      : super('Database migration failed from v$from to v$to');
}

// ── Dictionary Exceptions ────────────────────────────────────────────
final class WordNotFoundException extends AppException {
  const WordNotFoundException(String word) : super('Word not found: $word');
}

final class StrongNumberNotFoundException extends AppException {
  const StrongNumberNotFoundException(String number)
      : super("Strong's number not found: $number");
}

// ── Bible Exceptions ─────────────────────────────────────────────────
final class BibleDataException extends AppException {
  const BibleDataException(super.message, {super.cause});
}

final class TranslationNotFoundException extends AppException {
  const TranslationNotFoundException(String code)
      : super('Translation not found: $code');
}

// ── Network Exceptions ───────────────────────────────────────────────
final class NetworkException extends AppException {
  const NetworkException(super.message, {this.statusCode, super.cause});

  final int? statusCode;
}

final class UnauthorizedException extends AppException {
  const UnauthorizedException() : super('401 Unauthorized');
}

final class TimeoutException extends AppException {
  const TimeoutException(super.message);
}

// ── Storage Exceptions ───────────────────────────────────────────────
final class StorageException extends AppException {
  const StorageException(super.message, {super.cause});
}

// ── Audio Exceptions ─────────────────────────────────────────────────
final class AudioException extends AppException {
  const AudioException(super.message, {super.cause});
}
