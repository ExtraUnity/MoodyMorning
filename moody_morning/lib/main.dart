import 'dart:async';

import 'package:alarm/alarm.dart';
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:moody_morning/screens/alarms_screen.dart';
import 'package:moody_morning/screens/set_alarm.dart';
import 'package:moody_morning/screens/solve_qrcode.dart';
import 'package:moody_morning/screens/solve_equation.dart';
import 'package:moody_morning/screens/solve_exercises.dart';
import 'package:moody_morning/screens/solve_puzzle.dart';
import 'package:moody_morning/system/all_alarms.dart';
import 'package:moody_morning/system/notification_service.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  AllAlarms.storage = LocalStorage('savedAlarms.json');
  await Alarm.init();
  NotificationService.initNotification();
  runApp(
    MaterialApp(
        debugShowCheckedModeBanner: false,
        navigatorKey: navigatorKey,
        //home: AlarmScreen(),
        routes: {
          '/': (context) => const AlarmScreen(),
          '/setAlarm': (context) => const SetAlarm(),
          '/equationSettings': (context) => const SolveEquation(),
          '/exerciseSettings': (context) => const SolveExercises(),
          '/QRSettings': (context) => const SolveQRCode(),
          '/gameSettings': (context) => const SolveRiddle(),
        }),
  );
}
