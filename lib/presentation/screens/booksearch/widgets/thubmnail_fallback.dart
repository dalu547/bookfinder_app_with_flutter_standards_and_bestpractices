import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class NetworkImageWithFallback extends StatelessWidget {
  final String imageUrl;
  final double width;
  final double height;
  final String fallbackAsset;

  const NetworkImageWithFallback({
    super.key,
    required this.imageUrl,
    required this.width,
    required this.height,
    required this.fallbackAsset,
  });

  @override
  Widget build(BuildContext context) {
    if (imageUrl.isEmpty) {
      return Image.asset(
        fallbackAsset,
        width: width,
        height: height,
        fit: BoxFit.cover,
      );
    }

    return CachedNetworkImage(
      imageUrl: imageUrl,
      width: width,
      height: height,
      fit: BoxFit.cover,
      placeholder: (_, __) => Image.asset(
        fallbackAsset,
        width: width,
        height: height,
        fit: BoxFit.cover,
      ),
      errorWidget: (_, __, ___) => Image.asset(
        fallbackAsset,
        width: width,
        height: height,
        fit: BoxFit.cover,
      ),
    );
  }
}
