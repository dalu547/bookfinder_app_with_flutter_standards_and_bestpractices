class BookEntity {
  final String title;
  final String author;
  final String editionKey;

  BookEntity({
    required this.title,
    required this.author,
    required this.editionKey,
  });

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is BookEntity &&
            runtimeType == other.runtimeType &&
            title == other.title &&
            author == other.author &&
            editionKey == other.editionKey;
  }

  @override
  int get hashCode => title.hashCode ^ author.hashCode ^ editionKey.hashCode;

  @override
  String toString() =>
      'BookEntity(title: $title, author: $author, editionKey: $editionKey)';
}
