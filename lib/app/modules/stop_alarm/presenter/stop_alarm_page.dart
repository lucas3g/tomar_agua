import 'package:flutter/material.dart';
import 'package:tomar_agua/app/core/constants/constants.dart';
import 'package:tomar_agua/app/core/di/dependecy_injection.dart';
import 'package:tomar_agua/app/core/shared/controller/alarm_controller.dart';

class StopAlarmPage extends StatefulWidget {
  const StopAlarmPage({
    Key? key,
  }) : super(key: key);

  @override
  State<StopAlarmPage> createState() => _StopAlarmPageState();
}

class _StopAlarmPageState extends State<StopAlarmPage> {
  final alarmController = getIt<AlarmController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: context.appTheme.primary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            textStyle: context.textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          onPressed: () async => await alarmController.stopAlarm(),
          child: const Text('Bebi água já carai'),
        ),
      ),
    );
  }
}
