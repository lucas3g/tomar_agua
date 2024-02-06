import 'package:flutter/material.dart';
import 'package:tomar_agua/app/core/routes/app_routes.dart';
import 'package:tomar_agua/app/core/theme/themes.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: ThemeMode.light,
      initialRoute: '/',
      routes: AppRoutes.routes,
    );
  }
}
