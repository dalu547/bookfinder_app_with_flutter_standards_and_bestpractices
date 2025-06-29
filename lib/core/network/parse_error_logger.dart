import 'package:dio/dio.dart';
import 'package:bookfinder/app/utils/app_logger.dart';

class ParseErrorLogger {
  void logError(Object error, StackTrace stackTrace, RequestOptions options) {
    AppLogger.error("Error occurred: $error");
    AppLogger.error("Stack trace: $stackTrace");
    AppLogger.error("Request options: ${options.method} ${options.uri}");
  }
}
