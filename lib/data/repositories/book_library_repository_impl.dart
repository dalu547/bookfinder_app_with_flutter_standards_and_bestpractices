import 'package:dartz/dartz.dart';
import 'package:bookfinder/app/utils/app_logger.dart';
import 'package:bookfinder/core/network/error_handler.dart';
import 'package:bookfinder/core/network/network_info.dart';
import 'package:bookfinder/data/datasources/local/book_library_local_datasource.dart';
import 'package:bookfinder/data/datasources/remote/book_library_remote_datasource.dart';
import 'package:bookfinder/domain/entities/book_details_entity.dart';
import 'package:bookfinder/domain/entities/book_entity.dart';
import 'package:bookfinder/domain/repositories/book_library_repository.dart';
import 'package:bookfinder/app/resources/strings_manager.dart';
import 'package:bookfinder/domain/core/failure.dart';

class BookLibraryRepositoryImpl extends BookLibraryRepository {
  final BookLibraryRemoteDatasource _remoteDataSource;
  final BookLibraryLocalDatasource _localDataSource;
  final NetworkInfo _networkInfo;

  BookLibraryRepositoryImpl(
    this._remoteDataSource,
    this._localDataSource,
    this._networkInfo,
  );

  @override
  Future<Either<Failure, List<BookEntity>>> searchBooks(
    String query,
    String fields,
    int page,
    int limit,
  ) async {
    if (await _networkInfo.isConnected) {
      try {
        final response =
            await _remoteDataSource.searchBooks(query, fields, page, limit);
        return Right(response.toEntityList());
      } catch (error, stacktrace) {
        AppLogger.fatal('Book search failed', error, stacktrace);
        return Left(ErrorHandler.handle(error));
      }
    } else {
      return Left(Failure.noInternet(AppStrings.noInternet));
    }
  }

  @override
  Future<Either<Failure, BookDetailEntity>> fetchBookDetails(
      String olid) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remoteDataSource.fetchBookDetail(olid);
        AppLogger.trace('Response Status: ${response.status}');
        final entity = response.toEntity();
        final isValid =
            entity.publishDate.isNotEmpty || entity.publisher.isNotEmpty;
        return Right(isValid ? entity : BookDetailEntity.empty());
      } catch (error, stacktrace) {
        AppLogger.fatal('Book detail fetch failed', error, stacktrace);
        return Left(ErrorHandler.handle(error));
      }
    } else {
      return Left(Failure.noInternet(AppStrings.noInternet));
    }
  }

  @override
  Future<BookDetailEntity?> getBookDetailsFromDB(String olid) async {
    return _localDataSource.getBookDetailsFromDB(olid);
  }

  @override
  Future<void> insertBookDetailsToDB(BookDetailEntity bookDetails) async {
    await _localDataSource.insertBookDetailsToDB(bookDetails);
  }
}
