import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:moody_morning/main.dart';

class NotificationService {
  final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> initNotification() async {
    AndroidInitializationSettings initSettingsAndroid =
        const AndroidInitializationSettings('flutter_logo');

    var initSettingsIOS = DarwinInitializationSettings(
        requestAlertPermission: true,
        requestBadgePermission: true,
        requestSoundPermission: true,
        onDidReceiveLocalNotification: onDidRecieveLocalNotification);

    final InitializationSettings initSettings = InitializationSettings(
        android: initSettingsAndroid, iOS: initSettingsIOS);

    await _notificationsPlugin.initialize(initSettings,
        onDidReceiveNotificationResponse:
            onDidReceiveBackgroundNotificationResponse,
        onDidReceiveBackgroundNotificationResponse:
            onDidReceiveBackgroundNotificationResponse);
  }

  void onDidRecieveLocalNotification(
      int id, String? title, String? body, String? payload) async {
    print("Payload: $payload");
  }

  notificationDetails() {
    return const NotificationDetails(
      android: AndroidNotificationDetails('channelId', 'channelName',
          importance: Importance.max, priority: Priority.max),
      iOS: DarwinNotificationDetails(),
    );
  }

  Future<void> showNotification(
      {int id = 0,
      required String title,
      required String body,
      required String payload}) async {
    await _notificationsPlugin
        .show(id, title, body, await notificationDetails(), payload: payload);
  }

  static void onDidReceiveBackgroundNotificationResponse(
      NotificationResponse details) {
    debugPrint("PRESSED NOTIFICATION WITH PAYLOAD: ${details.payload}");
  }
}

class ReceivedNotification {
  ReceivedNotification({
    required this.id,
    required this.title,
    required this.body,
    required this.payload,
  });

  final int id;
  final String? title;
  final String? body;
  final String? payload;
}
