class BookDetailEntity {
  final String olid;
  final String publisher;
  final int numberOfPages;
  final String publishDate;

  const BookDetailEntity({
    required this.olid,
    required this.publisher,
    required this.numberOfPages,
    required this.publishDate,
  });

  static BookDetailEntity empty() => const BookDetailEntity(
        olid: '',
        publisher: '',
        numberOfPages: 0,
        publishDate: '',
      );

  @override
  String toString() => 'BookDetailEntity(olid: $olid, publisher: $publisher, '
      'pages: $numberOfPages, publishDate: $publishDate)';
}
