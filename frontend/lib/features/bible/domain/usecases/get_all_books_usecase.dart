// lib/features/bible/domain/usecases/get_all_books_usecase.dart
// [NEW] 성경 66권 목록 조회 유스케이스

import '../../../../core/error/failures.dart';
import '../../../../core/utils/result.dart';
import '../entities/book.dart';
import '../repositories/bible_repository.dart';

/// 성경 66권 목록을 순서대로 반환한다.
/// 구약/신약으로 그룹핑된 결과도 제공한다.
final class GetAllBooksUseCase {
  const GetAllBooksUseCase(this._repository);

  final BibleRepository _repository;

  Future<Result<List<Book>, Failure>> call() =>
      _repository.getAllBooks();

  /// 구약/신약 분리 결과.
  Future<Result<BooksGrouped, Failure>> grouped() async {
    final result = await _repository.getAllBooks();
    return result.map(BooksGrouped.from);
  }
}

/// 구약 + 신약으로 분리된 책 목록.
final class BooksGrouped {
  const BooksGrouped({
    required this.oldTestament,
    required this.newTestament,
  });

  factory BooksGrouped.from(List<Book> books) => BooksGrouped(
        oldTestament: books.where((b) => b.isOldTestament).toList(),
        newTestament: books.where((b) => b.isNewTestament).toList(),
      );

  final List<Book> oldTestament;
  final List<Book> newTestament;

  List<Book> get all => [...oldTestament, ...newTestament];
  int get totalBooks => oldTestament.length + newTestament.length;
}
