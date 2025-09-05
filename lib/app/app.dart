import 'package:flutter/material.dart';
import 'package:bookfinder/core/router/routes_manager.dart';
import 'package:bookfinder/app/resources/theme_manager.dart';
import 'package:bookfinder/core/theme/theme_controller.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: ThemeController.instance,
      builder: (context, _) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          restorationScopeId: 'app',
          theme: ThemeManager.light,
          darkTheme: ThemeManager.dark,
          themeMode: ThemeController.instance.mode,
          initialRoute: Routes.splash,
          onGenerateRoute: Routes.generateRoute,
        );
      },
    );
  }
}
