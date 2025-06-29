import 'package:bookfinder/app/resources/app_constants.dart';
import 'package:bookfinder/core/network/network_config.dart';

String getCoverUrl(String? editionKey) {
  if (editionKey == null || editionKey.isEmpty) return '';
  return '${NetworkConfig.imageCoverBaseUrl}$editionKey${AppConstants.imageSizeLarge}';
}

String getThumbnailUrl(String? editionKey) {
  if (editionKey == null || editionKey.isEmpty) return '';
  return '${NetworkConfig.imageCoverBaseUrl}$editionKey${AppConstants.imageSizeMedium}';
}
