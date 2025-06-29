import 'package:dartz/dartz.dart';
import 'package:bookfinder/core/base/base_usecase.dart';
import 'package:bookfinder/core/network/response_error.dart';
import 'package:bookfinder/domain/entities/book_entity.dart';
import 'package:bookfinder/domain/repositories/book_library_repository.dart';

class BookSearchUseCase
    implements BaseUseCase<BookSearchUseCaseInput, List<BookEntity>> {
  final BookLibraryRepository _repository;

  BookSearchUseCase(this._repository);

  @override
  Future<Either<ResponseError, List<BookEntity>>> execute(
      BookSearchUseCaseInput input) {
    return _repository.searchBooks(
      input.query,
      input.fields,
      input.page,
      input.limit,
    );
  }
}

class BookSearchUseCaseInput {
  final String query;
  final String fields;
  final int page;
  final int limit;

  const BookSearchUseCaseInput(
    this.query,
    this.fields,
    this.page,
    this.limit,
  );
}
