class NetworkConfig {
  static const String baseUrl = "http://openlibrary.org/";

  static const String imageCoverBaseUrl =
      "https://covers.openlibrary.org/b/olid/";

  static const int timeout = 5000;
  static const Duration connectTimeout = Duration(milliseconds: timeout);
  static const Duration receiveTimeout = Duration(milliseconds: timeout);

  static const String applicationJson = "application/json";
  static const String contentType = "content-type";
  static const String accept = "accept";
  static const String authorization = "authorization";
  static const String defaultLanguage = "language";
}
