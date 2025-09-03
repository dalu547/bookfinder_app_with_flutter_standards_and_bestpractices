import 'package:bookfinder/app/resources/strings_manager.dart';
import 'package:bookfinder/domain/core/failure.dart';

String mapFailureToMessage(Failure failure) {
  // Prefer message if provided; otherwise fall back by code buckets
  if (failure.message.isNotEmpty) return failure.message;

  switch (failure.code) {
    case -1:
      return AppStrings.noInternet;
    case -2:
      return AppStrings.connectionTimeout;
    case -3:
      return AppStrings.requestCancelled;
    default:
      return AppStrings.genericError;
  }
}

