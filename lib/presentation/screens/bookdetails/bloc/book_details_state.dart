import 'package:equatable/equatable.dart';
import 'package:bookfinder/core/network/response_error.dart';
import 'package:bookfinder/domain/entities/book_details_entity.dart';

abstract class BookDetailsState extends Equatable {
  const BookDetailsState();

  @override
  List<Object?> get props => [];
}

class BookDetailsInitial extends BookDetailsState {
  const BookDetailsInitial();
}

class BookDetailsLoading extends BookDetailsState {
  const BookDetailsLoading();
}

class BookDetailsSuccess extends BookDetailsState {
  final BookDetailEntity bookDetailEntity;

  const BookDetailsSuccess(this.bookDetailEntity);

  @override
  List<Object?> get props => [bookDetailEntity];
}

class BookDetailsFailure extends BookDetailsState {
  final ResponseError error;

  const BookDetailsFailure(this.error);

  @override
  List<Object?> get props => [error];
}
