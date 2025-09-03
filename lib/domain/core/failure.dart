class Failure {
  final int code;
  final String message;

  const Failure(this.code, this.message);

  // Common helpers
  factory Failure.noInternet(String message) => Failure(-1, message);
  factory Failure.timeout(String message) => Failure(-2, message);
  factory Failure.server(int code, String message) => Failure(code, message);
  factory Failure.cancelled(String message) => Failure(-3, message);
  factory Failure.unknown(String message) => Failure(-4, message);
  factory Failure.unexpected(String message) => Failure(-5, message);

  @override
  String toString() => 'Failure(code: $code, message: $message)';
}

