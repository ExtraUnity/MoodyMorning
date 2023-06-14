import 'package:alarm/alarm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:moody_morning/screens/alarms_screen.dart';
import 'package:moody_morning/main.dart';
import 'package:moody_morning/screens/solve_QRcode.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:moody_morning/firebase_options.dart';
import 'package:moody_morning/system/notification_service.dart';

void handleAlarm(BuildContext context, AlarmSettings activeAlarm) async {
  print("ALARM IS RINGING AND THIS FUNCTION HAS JUST BEEN CALLED");

  await service.showNotification(
      title: 'THIS IS A LOCAL NOTIFICATION!!',
      body: 'Press here to get your challenge!',
      payload: '/QRChallenge');

  // FirebaseMessaging messaging = FirebaseMessaging.instance;

  // NotificationSettings settings = await messaging.requestPermission(
  //   alert: true,
  //   announcement: false,
  //   badge: true,
  //   carPlay: false,
  //   criticalAlert: false,
  //   provisional: false,
  //   sound: true,
  // );
  // print('User granted permission: ${settings.authorizationStatus}');

  //TODO:
  //Handle different selection of challenges
  //Redirect to correct page
}
