import 'dart:async';
import 'package:bookfinder/app/resources/app_constants.dart';
import 'package:bookfinder/core/router/routes_manager.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Timer? _timer;
  @override
  void initState() {
    super.initState();

    _timer = Timer(AppConstants.splashDelay, () {
      if (!mounted) return;
      Navigator.pushReplacementNamed(context, Routes.bookList);
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Image(
          image: AssetImage(AppConstants.splashImage),
          width: AppConstants.splashImageWidth,
          height: AppConstants.splashImageHeight,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
