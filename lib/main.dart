import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:bookfinder/app/app.dart';
import 'package:bookfinder/core/di/app_di.dart';
import 'package:flutter/foundation.dart';
import 'package:bookfinder/core/logging/app_bloc_observer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initAppModule();
  if (!kReleaseMode) {
    Bloc.observer = AppBlocObserver();
  }
  runApp(
    Sizer(
      builder: (context, orientation, deviceType) {
        return const MyApp();
      },
    ),
  );
}
