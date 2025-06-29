import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:bookfinder/app/app.dart';
import 'package:bookfinder/core/di/app_di.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initAppModule();
  runApp(
    Sizer(
      builder: (context, orientation, deviceType) {
        return const MyApp();
      },
    ),
  );
}
