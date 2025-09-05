import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:bookfinder/di/book_library_di.dart';

import '../../../core/network/dio_client.dart';
import '../../../core/network/network_info.dart';
import '../database/app_database.dart';

final GetIt instance = GetIt.instance;
Future<void> initAppModule() async {
  instance.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(InternetConnectionChecker.createInstance()));

  instance.registerLazySingleton<DioClient>(() => DioClient());

  final dioClient = instance<DioClient>();
  final dio = await dioClient.getDio();

  instance.registerLazySingleton<Dio>(() => dio);

  final database =
      await $FloorAppDatabase.databaseBuilder('app_database.db').build();
  instance.registerLazySingleton<AppDatabase>(() => database);

  await initModuleDependecies();
}

Future<void> initModuleDependecies() async {
  instance.pushNewScope();
  await initBookLibraryModule();
}
