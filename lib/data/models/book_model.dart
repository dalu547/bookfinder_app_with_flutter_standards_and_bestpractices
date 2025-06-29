import 'package:bookfinder/domain/entities/book_entity.dart';

class BookModel {
  final String title;
  final List<String> authorNames;
  final String? editionKey;

  BookModel({
    required this.title,
    required this.authorNames,
    this.editionKey,
  });

  factory BookModel.fromJson(Map<String, dynamic> map) {
    final rawAuthorNames = map['author_name'];
    return BookModel(
      title: map['title'] is String ? map['title'] : '',
      authorNames: rawAuthorNames is List
          ? rawAuthorNames.map((e) => e.toString()).toList()
          : <String>[],
      editionKey: map['cover_edition_key']?.toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'author_name': authorNames,
      'cover_edition_key': editionKey,
    };
  }

  BookModel copyWith({
    String? title,
    List<String>? authorNames,
    String? editionKey,
  }) {
    return BookModel(
      title: title ?? this.title,
      authorNames: authorNames ?? this.authorNames,
      editionKey: editionKey ?? this.editionKey,
    );
  }

  BookEntity toEntity() {
    return BookEntity(
      title: title,
      author: authorNames.isNotEmpty ? authorNames.first : '',
      editionKey: editionKey ?? '',
    );
  }

  @override
  String toString() =>
      'BookModel(title: $title, authorNames: $authorNames, editionKey: $editionKey)';
}
