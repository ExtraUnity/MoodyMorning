import 'dart:async';

import 'package:alarm/alarm.dart';
import 'package:flutter/material.dart';
import 'package:moody_morning/screens/alarms_screen.dart';
import 'package:moody_morning/screens/set_alarm.dart';
import 'package:moody_morning/screens/solve_qrcode.dart';
import 'package:moody_morning/screens/solve_equation.dart';
import 'package:moody_morning/screens/solve_exercises.dart';
import 'package:moody_morning/screens/solve_riddle.dart';
import 'package:moody_morning/system/all_alarms.dart';
import 'package:moody_morning/system/notification_service.dart';
import 'package:provider/provider.dart';

//Handle listening to notifications
NotificationService notificationService = NotificationService();
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Alarm.init();
  notificationService.initNotification();

  runApp(
    ChangeNotifierProvider(
      create: (context) => AllAlarms(),
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          navigatorKey: navigatorKey,
          //home: AlarmScreen(),
          routes: {
            '/': (context) => const AlarmScreen(),
            '/setAlarm': (context) => const SetAlarm(),
            '/equationSettings': (context) =>
                const SolveEquation(), //TODO: Change to equation settings
            '/exerciseSettings': (context) =>
                const SolveExercises(), //TODO: Change to exercise settings
            '/QRSettings': (context) =>
                SolveQRCode(), //TODO: Change to QR settings
            '/gameSettings': (context) =>
                const SolveRiddle(), //TODO: Change to game settings
          }),
    ),
  );
}
