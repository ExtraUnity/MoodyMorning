import 'dart:async';

import 'package:alarm/alarm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:moody_morning/screens/alarms_screen.dart';
import 'package:moody_morning/screens/set_alarm.dart';
import 'package:moody_morning/screens/solve_QRcode.dart';
import 'package:moody_morning/system/all_alarms.dart';
import 'package:moody_morning/system/notification_service.dart';
import 'package:provider/provider.dart';

//Handle listening to notifications
NotificationService notificationService = NotificationService();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Alarm.init();
  notificationService.initNotification();

  runApp(
    ChangeNotifierProvider(
      create: (context) => AllAlarms(),
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          //home: AlarmScreen(),
          routes: {
            '/': (context) => AlarmScreen(),
            '/setAlarm': (context) => SetAlarm(),
            '/equationSettings': (context) =>
                AlarmScreen(), //TODO: Change to equation settings
            '/exerciseSettings': (context) =>
                AlarmScreen(), //TODO: Change to exercise settings
            '/QRSettings': (context) =>
                MainScreen(), //TODO: Change to QR settings
            '/gameSettings': (context) =>
                AlarmScreen(), //TODO: Change to game settings
          }),
    ),
  );
}
