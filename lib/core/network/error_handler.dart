import 'package:bookfinder/app/resources/strings_manager.dart';
import 'package:bookfinder/domain/core/failure.dart';
import 'package:dio/dio.dart';

enum SimpleErrorType {
  noInternet,
  serverError,
  unknown,
}

class ErrorHandler {
  static Failure handle(dynamic error) {
    if (error is DioException) {
      switch (error.type) {
        case DioExceptionType.connectionTimeout:
        case DioExceptionType.sendTimeout:
        case DioExceptionType.receiveTimeout:
          return Failure.timeout(AppStrings.connectionTimeout);
        case DioExceptionType.badResponse:
          return Failure.server(
            error.response?.statusCode ?? 500,
            AppStrings.serverError,
          );
        case DioExceptionType.cancel:
          return Failure.cancelled(AppStrings.requestCancelled);
        case DioExceptionType.connectionError:
          return Failure.noInternet(AppStrings.noInternet);
        default:
          return Failure.unknown(AppStrings.genericError);
      }
    }

    return Failure.unexpected(AppStrings.unexpectedError);
  }
}
