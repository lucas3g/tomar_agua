import 'package:flutter/material.dart';
import 'package:tomar_agua/app/app_widget.dart';
import 'package:tomar_agua/app/core/di/dependecy_injection.dart';

void main() {
  configureDependencies();

  runApp(const AppWidget());
}
