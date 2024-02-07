import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/material.dart';
import 'package:tomar_agua/app/app_widget.dart';
import 'package:tomar_agua/app/core/di/dependecy_injection.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await AndroidAlarmManager.initialize();

  configureDependencies();

  runApp(const AppWidget());
}
