import 'package:flutter/material.dart';
import 'package:moody_morning/screens/solve_equation.dart';
import 'package:moody_morning/screens/set_alarm.dart';
import 'package:moody_morning/screens/solve_riddle.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    //home: SetAlarm(),
    home: SolveRiddle(),
    //home: SolveEquation(),
    //home: SolveQRcode(),
  ));
}
