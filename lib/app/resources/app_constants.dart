class AppConstants {
  static const Duration splashDelay = Duration(seconds: 2);
  static const double splashImageWidth = 120;
  static const double splashImageHeight = 120;
  static const String splashImage = 'assets/icon/book_finder_icon.png';

  static const int pageSize = 20;

  static const String fallbackCoverLarge = 'assets/images/fallback_image.png';

  static const double coverImageWidth = 200;
  static const double coverImageHeight = 300;

  static const String defaultSearchFields =
      'title,author_name,cover_edition_key';
  static const Duration debounceDuration = Duration(milliseconds: 500);

  static const double coverThumbnailWidth = 50;
  static const double coverThumbnailHeight = 60;

  static const String imageSizeLarge = "-L.jpg";
  static const String imageSizeMedium = "-M.jpg";
}
