import 'package:bookfinder/core/base/base_response.dart';
import 'package:bookfinder/data/models/book_model.dart';
import 'package:bookfinder/domain/entities/book_entity.dart';

class BookResponse extends BaseResponse {
  final List<BookModel> books;

  BookResponse({required this.books});

  factory BookResponse.fromJson(Map<String, dynamic> map) {
    final docs = map['docs'];
    final booksList = docs is List
        ? docs.map((e) => BookModel.fromJson(e)).toList()
        : <BookModel>[];

    return BookResponse(books: booksList);
  }

  Map<String, dynamic> toJson() {
    return {
      'docs': books.map((e) => e.toJson()).toList(),
    };
  }

  BookResponse copyWith({List<BookModel>? books}) {
    return BookResponse(books: books ?? this.books);
  }

  List<BookEntity> toEntityList() {
    return books.map((e) => e.toEntity()).toList();
  }

  @override
  String toString() => 'BookResponse(books: $books)';
}
