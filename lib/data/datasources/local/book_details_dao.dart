import 'package:floor/floor.dart';
import 'package:bookfinder/data/tables/book_details_table.dart';

@dao
abstract class BookDetailsDao {
  @Insert(onConflict: OnConflictStrategy.replace)
  Future<int> insertBookDetails(BookDetailsTable bookDetails);

  @update
  Future<int> updateBook(BookDetailsTable bookDetails);

  @delete
  Future<int> deleteBook(BookDetailsTable bookDetails);

  @Query('SELECT * FROM tblBookDetails')
  Future<List<BookDetailsTable>> getAllBookDetails();

  @Query('SELECT * FROM tblBookDetails WHERE olid = :olid')
  Future<BookDetailsTable?> getBookDetailsById(String olid);
}
