// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:alarm/alarm.dart';
import 'package:flutter/material.dart';
import 'package:tomar_agua/app/core/shared/components/app_snackbar.dart';

class AlarmController extends ChangeNotifier {
  final hour = ValueNotifier<int>(0);
  final minutes = ValueNotifier<int>(30);

  String formatTimer() {
    final sHour = hour.value.toString();
    final sMinutes = minutes.value.toString();

    return '${sHour.padLeft(2, '0')}:${sMinutes.padLeft(2, '0')}';
  }

  void increaseTime() {
    if (minutes.value < 55 && hour.value < 24) {
      minutes.value += 5;
    } else {
      if (hour.value < 24) {
        hour.value++;
        minutes.value = 0;
      }
    }

    notifyListeners();
  }

  void decreaseTime() {
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

    notifyListeners();
  }

  Future initAlarm() async {
    await Alarm.init();
  }

  Future setAlarm(BuildContext context) async {
    final alarmSettings = AlarmSettings(
      id: 42,
      dateTime: DateTime.now().add(const Duration(seconds: 5)),
      assetAudioPath: 'assets/sounds/alarm.mp3',
      loopAudio: true,
      vibrate: true,
      volume: 0.2,
      fadeDuration: 3.0,
      notificationTitle: 'Águaaaaaaaa',
      notificationBody: 'Ta na hora de tomar água, calabreso!',
      enableNotificationOnKill: true,
    );

    await Alarm.setNotificationOnAppKillContent(
      'Águaaaaaaaa',
      'Ta na hora de tomar água, calabreso!',
    );

    final result = await Alarm.set(alarmSettings: alarmSettings);

    if (result) {
      showAppSnackbar(
        context,
        title: 'Uhuul',
        message: 'Lembrete para tomar água, salvo com sucesso!',
        type: TypeSnack.success,
      );
    }
  }

  Future stopAlarm() async {
    await Alarm.stop(42);
  }
}
