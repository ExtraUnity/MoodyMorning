import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:moody_morning/screens/set_alarm.dart';
import 'package:moody_morning/screens/solve_QRcode.dart';
import 'package:moody_morning/screens/alarms_screen.dart';
import 'package:alarm/alarm.dart';

import 'package:moody_morning/system/notification_service.dart';

late final NotificationService service;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  service = NotificationService();
  await service.initNotification();
  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );
  // final fcmToken = await FirebaseMessaging.instance.getToken();
  // print(fcmToken);

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
    },
  ));
  await Alarm.init();
}
