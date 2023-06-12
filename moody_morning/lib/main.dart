import 'package:flutter/material.dart';
import 'package:moody_morning/screens/solve_equation.dart';
import 'package:moody_morning/screens/set_alarm.dart';
import 'package:moody_morning/screens/solve_QRcode.dart';
import 'package:moody_morning/screens/solve_exercises.dart';
import 'package:moody_morning/system/all_alarms.dart';
import 'package:moody_morning/screens/alarms_screen.dart';
import 'package:alarm/alarm.dart';

void main() async {
  runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      //home: AlarmScreen(),
      routes: {
        '/': (context) => AlarmScreen(),
        '/setAlarm': (context) => SetAlarm(),
      }));
  await Alarm.init();
}
