import 'package:dio/dio.dart';
import 'package:bookfinder/domain/repositories/book_library_repository.dart';
import 'package:bookfinder/domain/usecases/book_details_usecase.dart';

import '../../../core/database/app_database.dart';
import '../../../core/di/app_di.dart';
import '../data/datasources/local/book_library_local_datasource.dart';
import '../data/datasources/local/book_details_dao.dart';
import '../data/datasources/remote/book_library_remote_datasource.dart';
import '../data/datasources/remote/book_library_service_client.dart';
import '../data/repositories/book_library_repository_impl.dart';
import '../domain/usecases/book_search_usecase.dart';
import '../presentation/screens/bookdetails/bloc/book_details_bloc.dart';
import '../presentation/screens/booksearch/bloc/book_search_bloc.dart';

Future<void> initBookLibraryModule() async {
  final dio = instance<Dio>();

  instance.registerLazySingleton<BookLibraryServiceClient>(
      () => BookLibraryServiceClient(dio));

  instance.registerLazySingleton<BookLibraryRemoteDatasource>(
      () => RemoteDataSourceImpl(instance()));

  instance.registerLazySingleton<BookDetailsDao>(
      () => instance<AppDatabase>().booDetailsDao);

  instance.registerLazySingleton<BookLibraryLocalDatasource>(
      () => LocalDataSourceImpl(instance<BookDetailsDao>()));

  instance.registerLazySingleton<BookLibraryRepository>(
      () => BookLibraryRepositoryImpl(instance(), instance(), instance()));

  instance.registerLazySingleton<BookSearchUseCase>(
      () => BookSearchUseCase(instance()));

  instance.registerFactory<BookSearchBloc>(
      () => BookSearchBloc(instance<BookSearchUseCase>()));

  instance.registerLazySingleton<BookDetailsUseCase>(
      () => BookDetailsUseCase(instance()));

  instance.registerFactory<BookDetailsBloc>(
      () => BookDetailsBloc(instance<BookDetailsUseCase>()));
}
