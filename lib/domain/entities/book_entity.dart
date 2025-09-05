import 'package:equatable/equatable.dart';

class BookEntity extends Equatable {
  final String title;
  final String author;
  final String editionKey;

  const BookEntity({
    required this.title,
    required this.author,
    required this.editionKey,
  });

  @override
  List<Object?> get props => [title, author, editionKey];

  @override
  String toString() =>
      'BookEntity(title: $title, author: $author, editionKey: $editionKey)';
}
