import 'package:equatable/equatable.dart';
import 'package:bookfinder/domain/core/failure.dart';
import 'package:bookfinder/domain/entities/book_entity.dart';

abstract class BookSearchState extends Equatable {
  const BookSearchState();

  @override
  List<Object?> get props => [];
}

class BookSearchInitial extends BookSearchState {
  const BookSearchInitial();
}

class BookSearchLoading extends BookSearchState {
  const BookSearchLoading();
}

class BookSearchSuccess extends BookSearchState {
  final List<BookEntity> books;

  const BookSearchSuccess(this.books);

  @override
  List<Object?> get props => [books];
}

class BookSearchFailure extends BookSearchState {
  final Failure error;

  const BookSearchFailure(this.error);

  @override
  List<Object?> get props => [error];
}
