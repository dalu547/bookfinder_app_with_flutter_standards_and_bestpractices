import 'package:bookfinder/app/resources/strings_manager.dart';
import 'package:flutter/material.dart';

import 'package:bookfinder/core/network/network_info.dart';

void showAppSnackBar(
  BuildContext context,
  String message, {
  Color color = Colors.red,
}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      backgroundColor: color,
      behavior: SnackBarBehavior.floating,
    ),
  );
}

Future<void> checkInternetAndShowSnackBar(
  BuildContext context,
  NetworkInfo networkInfo,
) async {
  final hasConnection = await networkInfo.isConnected;
  if (!hasConnection) {
    showAppSnackBar(context, AppStrings.noInternet);
  }
}
