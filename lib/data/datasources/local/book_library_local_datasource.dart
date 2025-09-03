import 'package:bookfinder/data/datasources/local/book_details_dao.dart';
import 'package:bookfinder/data/tables/book_details_table.dart';
import 'package:bookfinder/domain/entities/book_details_entity.dart';

abstract class BookLibraryLocalDatasource {
  Future<void> insertBookDetailsToDB(BookDetailEntity bookDetails);
  Future<BookDetailEntity?> getBookDetailsFromDB(String olid);
}

class LocalDataSourceImpl implements BookLibraryLocalDatasource {
  final BookDetailsDao bookDetailsDao;

  LocalDataSourceImpl(this.bookDetailsDao);

  @override
  Future<BookDetailEntity?> getBookDetailsFromDB(String olid) async {
    final table = await bookDetailsDao.getBookDetailsById(olid);
    if (table == null) return null;
    return BookDetailEntity(
      olid: table.olid,
      publisher: table.publisher,
      numberOfPages: table.numberOfPages,
      publishDate: table.publishDate,
    );
  }

  @override
  Future<void> insertBookDetailsToDB(BookDetailEntity bookDetails) async {
    final table = BookDetailsTable(
      olid: bookDetails.olid,
      publisher: bookDetails.publisher,
      numberOfPages: bookDetails.numberOfPages,
      publishDate: bookDetails.publishDate,
    );
    await bookDetailsDao.insertBookDetails(table);
  }
}
