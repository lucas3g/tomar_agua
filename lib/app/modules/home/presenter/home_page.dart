import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:tomar_agua/app/core/constants/constants.dart';
import 'package:tomar_agua/app/core/shared/app_images.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final hour = ValueNotifier<int>(0);
  final minutes = ValueNotifier<int>(30);

  String _formatTimer(int hour, int minutes) {
    final sHour = hour.toString();
    final sMinutes = minutes.toString();

    return '${sHour.padLeft(2, '0')}:${sMinutes.padLeft(2, '0')}';
  }

  _sumTime() {
    if (minutes.value < 55 && hour.value < 24) {
      minutes.value += 5;
    } else {
      if (hour.value < 24) {
        hour.value++;
        minutes.value = 0;
      }
    }

    setState(() {});
  }

  _decreaseTime() {
    if (minutes.value > 0) {
      minutes.value -= 5;
    } else {
      if (hour.value > 0 && minutes.value == 0) {
        hour.value--;
        minutes.value = 55;
      } else {
        if (minutes.value > 0) {
          minutes.value -= 5;
        } else {
          if (hour.value > 0) {
            hour.value--;
          }
        }
      }
    }

    setState(() {});
  }

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    super.initState();

    var initializationSettingsAndroid =
        const AndroidInitializationSettings('@mipmap/launcher_icon');

    var initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);

    flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  Future<void> _scheduleNotification() async {
    var androidPlatformChannelSpecifics = const AndroidNotificationDetails(
      'water_channel',
      'Water Reminder',
      importance: Importance.high,
      priority: Priority.high,
    );

    var platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.periodicallyShow(
      0,
      'Drink Water',
      'Time to hydrate!',
      RepeatInterval.everyMinute,
      platformChannelSpecifics,
      androidScheduleMode: AndroidScheduleMode.alarmClock,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.appTheme.primaryContainer,
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(12),
          height: context.screenHeight,
          width: context.screenWidth,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Bora tomar água?',
                style: context.textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                ),
              ),
              const SizedBox(height: 10),
              Image.asset(
                AppImages.pathAgua,
                width: context.screenWidth * .6,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: _decreaseTime,
                    icon: Icon(
                      Icons.remove_circle_outline_outlined,
                      size: 50,
                      color: context.appTheme.primary,
                    ),
                  ),
                  Text(
                    _formatTimer(hour.value, minutes.value),
                    style: context.textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 50,
                    ),
                  ),
                  IconButton(
                    onPressed: _sumTime,
                    icon: Icon(
                      Icons.add_circle_outline_outlined,
                      size: 50,
                      color: context.appTheme.primary,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: context.appTheme.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  textStyle: context.textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onPressed: _scheduleNotification,
                icon: const Icon(Icons.check),
                label: const Text('Lembrar'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
