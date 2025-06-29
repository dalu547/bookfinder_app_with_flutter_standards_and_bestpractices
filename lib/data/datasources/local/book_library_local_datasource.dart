import 'package:bookfinder/data/datasources/local/book_details_dao.dart';
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
    final bookDetails = await bookDetailsDao.getBookDetailsById(olid);
    return bookDetails;
  }

  @override
  Future<void> insertBookDetailsToDB(BookDetailEntity bookDetails) async {
    await bookDetailsDao.insertBookDetails(bookDetails);
  }
}
