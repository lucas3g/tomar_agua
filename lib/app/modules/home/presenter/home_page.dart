import 'dart:async';

import 'package:alarm/alarm.dart';
import 'package:flutter/material.dart';
import 'package:tomar_agua/app/core/constants/constants.dart';
import 'package:tomar_agua/app/core/di/dependecy_injection.dart';
import 'package:tomar_agua/app/core/shared/app_images.dart';
import 'package:tomar_agua/app/core/shared/controller/alarm_controller.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final alarmController = getIt<AlarmController>();

  late StreamSubscription sub;

  Future _initAlarm() async {
    await alarmController.initAlarm();
  }

  @override
  void initState() {
    super.initState();

    _initAlarm();

    alarmController.addListener(() {
      setState(() {});
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      sub = Alarm.ringStream.stream.listen((_) {
        Navigator.pushReplacementNamed(context, 'stop');
      });
    });
  }

  @override
  void dispose() {
    alarmController.removeListener(() {});
    alarmController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    onPressed: alarmController.decreaseTime,
                    icon: Icon(
                      Icons.remove_circle_outline_outlined,
                      size: 50,
                      color: context.appTheme.primary,
                    ),
                  ),
                  Text(
                    alarmController.formatTimer(),
                    style: context.textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 50,
                    ),
                  ),
                  IconButton(
                    onPressed: alarmController.increaseTime,
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
                onPressed: () async => await alarmController.setAlarm(context),
                icon: const Icon(Icons.check),
                label: const Text('Lembrar'),
              ),
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
                onPressed: () async {
                  await alarmController.stopAlarm();
                },
                icon: const Icon(Icons.check),
                label: const Text('Stop Page'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
