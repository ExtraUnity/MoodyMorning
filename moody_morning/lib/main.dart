import 'package:flutter/material.dart';
import 'package:moody_morning/screens/solve_equation.dart';
import 'package:moody_morning/screens/set_alarm.dart';
import 'package:moody_morning/screens/solve_QRcode.dart';
import 'package:moody_morning/system/all_alarms.dart';
import 'package:alarm/alarm.dart';

void main() async {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    //home: SetAlarm(),
    //home: solveEquation(),
    home: SetAlarm(),
  ));
  await Alarm.init();
}
