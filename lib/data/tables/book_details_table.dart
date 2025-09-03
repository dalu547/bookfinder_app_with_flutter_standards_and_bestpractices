import 'package:floor/floor.dart';

@Entity(tableName: 'tblBookDetails')
class BookDetailsTable {
  @primaryKey
  final String olid;
  final String publisher;
  final int numberOfPages;
  final String publishDate;

  const BookDetailsTable({
    required this.olid,
    required this.publisher,
    required this.numberOfPages,
    required this.publishDate,
  });
}

