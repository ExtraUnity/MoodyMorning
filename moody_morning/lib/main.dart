import 'package:flutter/material.dart';
import 'package:moody_morning/screens/alarms_screen.dart';
import 'package:moody_morning/screens/solve_equation.dart';
import 'package:moody_morning/screens/set_alarm.dart'
import 'package:moody_morning/screens/solve_riddle.dart';
import 'package:moody_morning/screens/solve_exercises.dart';
import 'package:moody_morning/screens/solve_QRcode.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    //home: AlarmScreen(),
    routes: {
      '/': (context) => AlarmScreen(),
      '/setAlarm': (context) => SetAlarm(),
    }
  ));
}
