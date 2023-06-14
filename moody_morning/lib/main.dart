import 'package:flutter/material.dart';
import 'package:moody_morning/screens/alarms_screen.dart';
import 'package:moody_morning/screens/solve_equation.dart';
import 'package:moody_morning/screens/set_alarm.dart';
import 'package:moody_morning/screens/solve_QRcode.dart';
import 'package:moody_morning/screens/solve_v1.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';


void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    //home: SetAlarm(),
    //home: solveEquation(),
    home: MyHomePageState1(),

  ));
}
