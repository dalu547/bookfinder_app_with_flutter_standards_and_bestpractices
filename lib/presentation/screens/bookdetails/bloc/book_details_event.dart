import 'package:equatable/equatable.dart';

abstract class BookDetailsEvent extends Equatable {
  const BookDetailsEvent();

  @override
  List<Object> get props => [];
}

class GetBookDetails extends BookDetailsEvent {
  final String olid;

  const GetBookDetails(this.olid);

  @override
  List<Object> get props => [olid];
}
