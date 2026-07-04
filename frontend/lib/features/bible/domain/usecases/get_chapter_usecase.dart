// lib/features/bible/domain/usecases/get_chapter_usecase.dart
// [NEW] 성경 장 조회 유스케이스

import '../../../../core/error/failures.dart';
import '../../../../core/utils/result.dart';
import '../entities/chapter_content.dart';
import '../repositories/bible_repository.dart';

/// 요청 파라미터.
final class GetChapterParams {
  const GetChapterParams({
    required this.bookId,
    required this.chapter,
    required this.translationCode,
    this.parallelTranslationCode,
  });

  final int bookId;
  final int chapter;
  final String translationCode;

  /// 지정하면 대역 보기용 병렬 절을 함께 조회.
  final String? parallelTranslationCode;

  GetChapterParams copyWith({
    int? bookId,
    int? chapter,
    String? translationCode,
    String? parallelTranslationCode,
  }) =>
      GetChapterParams(
        bookId: bookId ?? this.bookId,
        chapter: chapter ?? this.chapter,
        translationCode: translationCode ?? this.translationCode,
        parallelTranslationCode:
            parallelTranslationCode ?? this.parallelTranslationCode,
      );

  GetChapterParams nextChapter() =>
      copyWith(chapter: chapter + 1);

  GetChapterParams previousChapter() =>
      copyWith(chapter: chapter > 1 ? chapter - 1 : chapter);

  @override
  String toString() =>
      'GetChapterParams($translationCode Book$bookId:$chapter)';
}

/// 성경 특정 장(chapter) 내용 전체를 조회한다.
/// 대역 보기 요청 시 parallelVerses 도 함께 채워진다.
final class GetChapterUseCase {
  const GetChapterUseCase(this._repository);

  final BibleRepository _repository;

  Future<Result<ChapterContent, Failure>> call(
    GetChapterParams params,
  ) =>
      _repository.getChapter(
        bookId: params.bookId,
        chapter: params.chapter,
        translationCode: params.translationCode,
        parallelTranslationCode: params.parallelTranslationCode,
      );
}
