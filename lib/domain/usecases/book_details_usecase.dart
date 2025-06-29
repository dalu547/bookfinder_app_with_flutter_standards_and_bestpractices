import 'package:dartz/dartz.dart';
import 'package:bookfinder/core/base/base_usecase.dart';
import 'package:bookfinder/core/network/response_error.dart';
import 'package:bookfinder/domain/entities/book_details_entity.dart';
import 'package:bookfinder/domain/repositories/book_library_repository.dart';

class BookDetailsUseCase
    implements BaseUseCase<BookDetailsUseCaseInput, BookDetailEntity> {
  final BookLibraryRepository _repository;

  BookDetailsUseCase(this._repository);

  @override
  Future<Either<ResponseError, BookDetailEntity>> execute(
    BookDetailsUseCaseInput input,
  ) async {
    try {
      final local = await _repository.getBookDetailsFromDB(input.olid);
      if (local != null) {
        return Right(local);
      }
    } catch (_) {}

    final result = await _repository.fetchBookDetails(input.olid);

    result.fold(
      (_) => null,
      (book) => _repository.insertBookDetailsToDB(book),
    );

    return result;
  }
}

class BookDetailsUseCaseInput {
  final String olid;

  const BookDetailsUseCaseInput(this.olid);
}
