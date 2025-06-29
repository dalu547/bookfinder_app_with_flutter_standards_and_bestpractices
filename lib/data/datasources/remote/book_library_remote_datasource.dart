import 'package:bookfinder/data/datasources/remote/book_library_service_client.dart';
import 'package:bookfinder/data/models/book_detail_model.dart';
import 'package:bookfinder/data/models/book_response.dart';

abstract class BookLibraryRemoteDatasource {
  Future<BookResponse> searchBooks(
      String query, String fields, int page, int limit);
  Future<BookDetailModel> fetchBookDetail(String olid);
}

class RemoteDataSourceImpl implements BookLibraryRemoteDatasource {
  final BookLibraryServiceClient _serviceClient;

  RemoteDataSourceImpl(this._serviceClient);

  @override
  Future<BookResponse> searchBooks(
      String query, String fields, int page, int limit) async {
    return await _serviceClient.searchBooks(query, fields, page, limit);
  }

  @override
  Future<BookDetailModel> fetchBookDetail(String olid) async {
    return await _serviceClient.getBookDetail(olid);
  }
}
