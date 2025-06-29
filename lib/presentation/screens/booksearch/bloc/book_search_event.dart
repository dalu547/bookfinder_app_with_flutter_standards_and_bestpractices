import 'package:equatable/equatable.dart';

abstract class BookSearchEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class SearchBook extends BookSearchEvent {
  final String query;
  final String fields;
  final int page;
  final int limit;

  SearchBook(this.query, this.fields, this.page, this.limit);
}
