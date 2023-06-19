import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:moody_morning/main.dart';
import 'package:volume_controller/volume_controller.dart';

///This class handles everything to do with displaying and interacting with notifications
class NotificationService {
  static int id = 0;
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

//This should handle notifications on iOS
  final StreamController<ReceivedNotification>
      didReceiveLocalNotificationStream =
      StreamController<ReceivedNotification>.broadcast();

//create listener to subscribe to user interaction with notification
  final StreamController<String?> notificationStream =
      StreamController<String?>.broadcast();

  final InitializationSettings initializationSettings =
      _getNotificationInitSettings();

  Future<void> initNotification() async {
    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse:
          (NotificationResponse notificationResponse) {
        if (notificationResponse.notificationResponseType ==
            NotificationResponseType.selectedNotification) {
          notificationStream.add(notificationResponse.payload);
        }
      },
    );
  }

  ///Return the configured initialization settings for each operating system.
  static InitializationSettings _getNotificationInitSettings() {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('app_icon');

    final DarwinInitializationSettings initializationSettingsDarwin =
        DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
      onDidReceiveLocalNotification:
          (int id, String? title, String? body, String? payload) async {
        notificationService.didReceiveLocalNotificationStream.add(
          ReceivedNotification(
            id: id,
            title: title,
            body: body,
            payload: payload,
          ),
        );
      },
    );

    final LinuxInitializationSettings initializationSettingsLinux =
        LinuxInitializationSettings(
      defaultActionName: 'Open notification',
      defaultIcon: AssetsLinuxIcon('icons/app_icon.png'),
    );
    return InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsDarwin,
      macOS: initializationSettingsDarwin,
      linux: initializationSettingsLinux,
    );
  }

  ///Configure what should happen when the notification is clicked
  ///subscribes to the notification stream and listens for activity
  ///redirects the user to challenge, that is associated with alarm (input string)
  ///'input' is a space separated string containing the payload and alarm id.
  void configureSelectNotificationSubject() {
    notificationService.notificationStream.stream.listen((String? input) async {
      //Ensure that there is no current screen
      while (navigatorKey.currentState!.canPop()) {
        navigatorKey.currentState!.pop();
      }
      List<String> inputs = input!.split(' ');
      String payload = inputs[0];
      int alarmID = int.parse(inputs[1]);
      //Push to relevant challenge screen using navigatorKey
      await navigatorKey.currentState
          ?.pushReplacementNamed(
        payload,
        arguments: alarmID,
      )
          .then((value) {
        if (value != null) {
          navigatorKey.currentState?.pushReplacement(
            value as Route<Object>,
          );
        }
      });
    });
  }

  ///Displays a notification on the screen, with intent of displaying fullscreen
  ///Automatically sets volume to max.
  Future<void> showNotification(String payload) async {
    //Setup notification details
    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails('your channel id', 'your channel name',
            channelDescription: 'your channel description',
            importance: Importance.max,
            priority: Priority.high,
            fullScreenIntent: true,
            ticker: 'ticker');
    const NotificationDetails notificationDetails =
        NotificationDetails(android: androidNotificationDetails);
    VolumeController().showSystemUI = false;
    VolumeController().maxVolume();
    VolumeController().listener((volume) {
      VolumeController().maxVolume();
    });
    //Display notification
    await notificationService.flutterLocalNotificationsPlugin.show(
      id++,
      'Time to wake up!',
      'Click here to get your challenge',
      notificationDetails,
      payload: payload,
    );
  }
}

class ReceivedNotification {
  final int id;
  final String? title;
  final String? body;
  final String? payload;

  ReceivedNotification({
    required this.id,
    required this.title,
    required this.body,
    required this.payload,
  });
}
