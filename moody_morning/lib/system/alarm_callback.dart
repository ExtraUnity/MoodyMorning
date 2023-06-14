import 'package:alarm/alarm.dart';
import 'package:flutter/material.dart';
import 'package:moody_morning/screens/alarms_screen.dart';

void handleAlarm(BuildContext context, AlarmSettings activeAlarm) async {
  await showNotification();
}
