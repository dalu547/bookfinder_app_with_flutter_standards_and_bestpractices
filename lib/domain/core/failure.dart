sealed class Failure {
  final int code;
  final String message;

  const Failure(this.code, this.message);

  // Convenience factories for callers that don't care about concrete types
  factory Failure.noInternet(String message) => NoInternetFailure(message);
  factory Failure.timeout(String message) => TimeoutFailure(message);
  factory Failure.server(int code, String message) => ServerFailure(code, message);
  factory Failure.cancelled(String message) => CancelledFailure(message);
  factory Failure.unknown(String message) => UnknownFailure(message);
  factory Failure.unexpected(String message) => UnexpectedFailure(message);

  @override
  String toString() => 'Failure(code: $code, message: $message)';
}

class NoInternetFailure extends Failure {
  const NoInternetFailure(String message) : super(-1, message);
}

class TimeoutFailure extends Failure {
  const TimeoutFailure(String message) : super(-2, message);
}

class ServerFailure extends Failure {
  const ServerFailure(int code, String message) : super(code, message);
}

class CancelledFailure extends Failure {
  const CancelledFailure(String message) : super(-3, message);
}

class UnknownFailure extends Failure {
  const UnknownFailure(String message) : super(-4, message);
}

class UnexpectedFailure extends Failure {
  const UnexpectedFailure(String message) : super(-5, message);
}
