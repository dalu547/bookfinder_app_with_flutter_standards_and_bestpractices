import 'dart:async';

import 'package:dio/dio.dart';

class RetryInterceptor extends Interceptor {
  final Dio dio;
  final int maxRetries;
  final Duration retryDelay;

  const RetryInterceptor({
    required this.dio,
    this.maxRetries = 2,
    this.retryDelay = const Duration(milliseconds: 300),
  });

  bool _isTransient(DioException e) {
    return e.type == DioExceptionType.connectionTimeout ||
        e.type == DioExceptionType.receiveTimeout ||
        e.type == DioExceptionType.sendTimeout ||
        e.type == DioExceptionType.connectionError;
  }

  @override
  Future onError(DioException err, ErrorInterceptorHandler handler) async {
    final requestOptions = err.requestOptions;

    if (!_isTransient(err)) {
      return handler.next(err);
    }

    final retries = (requestOptions.extra['retries'] as int?) ?? 0;
    if (retries >= maxRetries) {
      return handler.next(err);
    }

    // increment retry count and retry
    final options = Options(
      method: requestOptions.method,
      headers: requestOptions.headers,
      responseType: requestOptions.responseType,
      contentType: requestOptions.contentType,
      followRedirects: requestOptions.followRedirects,
      receiveDataWhenStatusError: requestOptions.receiveDataWhenStatusError,
      validateStatus: requestOptions.validateStatus,
    );

    await Future<void>.delayed(retryDelay);

    try {
      final cloned = await dio.request<dynamic>(
        requestOptions.path,
        data: requestOptions.data,
        queryParameters: requestOptions.queryParameters,
        options: options.copyWith(
          extra: {
            ...requestOptions.extra,
            'retries': retries + 1,
          },
        ),
        cancelToken: requestOptions.cancelToken,
        onReceiveProgress: requestOptions.onReceiveProgress,
        onSendProgress: requestOptions.onSendProgress,
      );
      return handler.resolve(cloned);
    } catch (e) {
      return handler.next(err);
    }
  }
}

