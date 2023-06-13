import 'package:flutter/material.dart';
import 'package:moody_morning/screens/solve_equation.dart';
import 'package:moody_morning/screens/set_alarm.dart';
import 'package:moody_morning/screens/solve_QRcode.dart';
import 'package:moody_morning/screens/solve_exercises.dart';
import 'package:moody_morning/system/all_alarms.dart';
import 'package:moody_morning/screens/alarms_screen.dart';
import 'package:alarm/alarm.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:moody_morning/firebase_options.dart';

void main() async {
  runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      //home: AlarmScreen(),
      routes: {
        '/': (context) => AlarmScreen(),
        '/setAlarm': (context) => SetAlarm(),
        '/equationSettings': (context) =>
            AlarmScreen(), //TODO: Change to equation settings
        '/exerciseSettings': (context) =>
            AlarmScreen(), //TODO: Change to exercise settings
        '/QRSettings': (context) => AlarmScreen(), //TODO: Change to QR settings
        '/gameSettings': (context) =>
            AlarmScreen(), //TODO: Change to game settings
        '/QRChallenge': (context) => MainScreen(),
      }));
  await Alarm.init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}
