import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
import 'package:bookfinder/core/network/network_config.dart';
import 'package:bookfinder/core/network/parse_error_logger.dart';
import 'package:bookfinder/data/models/book_detail_model.dart';
import 'package:bookfinder/data/models/book_response.dart';

part 'book_library_service_client.g.dart';

@RestApi(baseUrl: NetworkConfig.baseUrl)
abstract class BookLibraryServiceClient {
  factory BookLibraryServiceClient(Dio dio, {String baseUrl}) =
      _BookLibraryServiceClient;

  @GET("search.json")
  Future<BookResponse> searchBooks(
    @Query("q") String query,
    @Query("fields") String fields,
    @Query("page") int page,
    @Query("limit") int limit,
  );

  @GET("books/{olid}.json")
  Future<BookDetailModel> getBookDetail(@Path("olid") String olid);
}
