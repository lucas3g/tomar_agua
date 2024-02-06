import 'package:flutter/material.dart';
import 'package:tomar_agua/app/modules/home/presenter/home_page.dart';
import 'package:tomar_agua/app/modules/splash/presenter/splash_page.dart';

class AppRoutes {
  static Map<String, Widget Function(BuildContext)> get routes => {
        '/': (context) => const SplashPage(),
        'home': (context) => const HomePage(),
      };
}
