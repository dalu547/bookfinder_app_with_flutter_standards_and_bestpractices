import 'package:bookfinder/app/resources/strings_manager.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:bookfinder/app/utils/app_logger.dart';
import 'package:bookfinder/core/network/network_config.dart';

class DioClient {
  DioClient();

  Future<Dio> getDio() async {
    final dio = Dio();

    final headers = {
      NetworkConfig.contentType: NetworkConfig.applicationJson,
      NetworkConfig.accept: NetworkConfig.applicationJson,
    };

    dio.options = BaseOptions(
      baseUrl: NetworkConfig.baseUrl,
      connectTimeout: NetworkConfig.connectTimeout,
      receiveTimeout: NetworkConfig.receiveTimeout,
      headers: headers,
    );

    if (kReleaseMode) {
      AppLogger.info(AppStrings.releaseModeNoLogs);
    } else {
      dio.interceptors.add(
        PrettyDioLogger(
          request: true,
          requestHeader: true,
          requestBody: true,
          responseHeader: true,
          responseBody: true,
          error: true,
          compact: true,
        ),
      );
    }

    return dio;
  }
}
