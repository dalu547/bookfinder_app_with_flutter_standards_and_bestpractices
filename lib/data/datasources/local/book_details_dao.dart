import 'package:floor/floor.dart';
import 'package:bookfinder/domain/entities/book_details_entity.dart';

@dao
abstract class BookDetailsDao {
  @Insert(onConflict: OnConflictStrategy.replace)
  Future<int> insertBookDetails(BookDetailEntity bookDetails);

  @update
  Future<int> updateBook(BookDetailEntity bookDetails);

  @delete
  Future<int> deleteBook(BookDetailEntity bookDetails);

  @Query('SELECT * FROM tblBookDetails')
  Future<List<BookDetailEntity>> getAllBookDetails();

  @Query('SELECT * FROM tblBookDetails WHERE olid = :olid')
  Future<BookDetailEntity?> getBookDetailsById(String olid);
}
