import 'package:bookfinder/app/resources/strings_manager.dart';
import 'package:bookfinder/core/network/response_error.dart';
import 'package:dio/dio.dart';

enum SimpleErrorType {
  noInternet,
  serverError,
  unknown,
}

class ErrorHandler {
  static ResponseError handle(dynamic error) {
    if (error is DioException) {
      switch (error.type) {
        case DioExceptionType.connectionTimeout:
        case DioExceptionType.sendTimeout:
        case DioExceptionType.receiveTimeout:
          return ResponseError(-1, AppStrings.connectionTimeout);
        case DioExceptionType.badResponse:
          return ResponseError(
            error.response?.statusCode ?? 500,
            AppStrings.serverError,
          );
        case DioExceptionType.cancel:
          return ResponseError(-1, AppStrings.requestCancelled);
        case DioExceptionType.connectionError:
          return ResponseError(-1, AppStrings.noInternet);
        default:
          return ResponseError(-1, AppStrings.genericError);
      }
    }

    return ResponseError(-1, AppStrings.unexpectedError);
  }
}
