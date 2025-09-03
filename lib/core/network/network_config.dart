class NetworkConfig {
  // Allow override via --dart-define (useful for flavors/environments)
  static const String baseUrl =
      String.fromEnvironment('BASE_URL', defaultValue: 'http://openlibrary.org/');

  static const String imageCoverBaseUrl = String.fromEnvironment(
    'IMAGE_COVER_BASE_URL',
    defaultValue: 'https://covers.openlibrary.org/b/olid/',
  );

  static const int timeout = int.fromEnvironment('TIMEOUT_MS', defaultValue: 5000);
  static const Duration connectTimeout = Duration(milliseconds: timeout);
  static const Duration receiveTimeout = Duration(milliseconds: timeout);

  static const String applicationJson = "application/json";
  static const String contentType = "content-type";
  static const String accept = "accept";
  static const String authorization = "authorization";
  static const String defaultLanguage = "language";
}
