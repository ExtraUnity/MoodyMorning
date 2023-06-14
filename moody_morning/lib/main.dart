import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:moody_morning/screens/set_alarm.dart';
import 'package:moody_morning/screens/solve_QRcode.dart';
import 'package:moody_morning/screens/alarms_screen.dart';
import 'package:alarm/alarm.dart';
import 'package:provider/provider.dart';

import 'package:moody_morning/system/notification_service.dart';

late final NotificationService service;

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin(); //Manage alarm notifications

final StreamController<ReceivedNotification> didReceiveLocalNotificationStream =
    StreamController<
        ReceivedNotification>.broadcast(); //For listening to notifications on iOS

final StreamController<String?> selectNotificationStream =
    StreamController<String?>.broadcast(); //Listen to notification click

@pragma('vm:entry-point')
void notificationTapBackground(NotificationResponse notificationResponse) {
  // ignore: avoid_print
  print('notification(${notificationResponse.id}) action tapped: '
      '${notificationResponse.actionId} with'
      ' payload: ${notificationResponse.payload}');
  if (notificationResponse.input?.isNotEmpty ?? false) {
    // ignore: avoid_print
    print(
        'notification action tapped with input: ${notificationResponse.input}');
  }
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // service = NotificationService();
  // await service.initNotification();

  final NotificationAppLaunchDetails? notificationAppLaunchDetails = !kIsWeb &&
          Platform.isLinux
      ? null
      : await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();
  String initialRoute = '/';
  if (notificationAppLaunchDetails?.didNotificationLaunchApp ?? false) {
    initialRoute = 'QRChallenge';
  }
  runApp(ChangeNotifierProvider(
    create: (context) => AllAlarms(),
    child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: initialRoute,
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
       }),
     ),
  );
  await Alarm.init();
}
