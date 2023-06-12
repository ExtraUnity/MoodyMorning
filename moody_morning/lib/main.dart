import 'package:flutter/material.dart';
import 'package:moody_morning/screens/alarms_screen.dart';
import 'package:moody_morning/screens/solve_equation.dart';
import 'package:moody_morning/screens/set_alarm.dart';

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
