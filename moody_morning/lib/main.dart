// import 'dart:async';
// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:moody_morning/screens/set_alarm.dart';
// import 'package:moody_morning/screens/solve_QRcode.dart';
// import 'package:moody_morning/screens/alarms_screen.dart';
// import 'package:alarm/alarm.dart';
// import 'package:moody_morning/system/all_alarms.dart';
// import 'package:provider/provider.dart';

// import 'package:moody_morning/system/notification_service.dart';

// late final NotificationService service;

// final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//     FlutterLocalNotificationsPlugin();

// final StreamController<ReceivedNotification> didReceiveLocalNotificationStream =
//     StreamController<
//         ReceivedNotification>.broadcast(); //For listening to notifications on iOS

// final StreamController<String?> selectNotificationStream =
//     StreamController<String?>.broadcast(); //Listen to notification click

// @pragma('vm:entry-point')
// void notificationTapBackground(NotificationResponse notificationResponse) {
//   // ignore: avoid_print
//   print('notification(${notificationResponse.id}) action tapped: '
//       '${notificationResponse.actionId} with'
//       ' payload: ${notificationResponse.payload}');
//   if (notificationResponse.input?.isNotEmpty ?? false) {
//     // ignore: avoid_print
//     print(
//         'notification action tapped with input: ${notificationResponse.input}');
//   }
// }

// void onDidRecieveLocalNotification(
//     int id, String? title, String? body, String? payload) async {
//   print("Payload: $payload");
// }

// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   service = NotificationService();
//   await service.initNotification();

//   final NotificationAppLaunchDetails? notificationAppLaunchDetails =
//       !kIsWeb && Platform.isLinux
//           ? null
//           : await service.notificationsPlugin.getNotificationAppLaunchDetails();
//   String initialRoute = '/';
//   if (notificationAppLaunchDetails?.didNotificationLaunchApp ?? false) {
//     initialRoute = '/QRSettings';
//   }

//   const AndroidInitializationSettings initSettingsAndroid =
//       AndroidInitializationSettings('flutter_logo');

//   final List<DarwinNotificationCategory> darwinNotificationCategories =
//       <DarwinNotificationCategory>[
//     DarwinNotificationCategory(
//       'textCategory',
//       actions: <DarwinNotificationAction>[
//         DarwinNotificationAction.text(
//           'text_1',
//           'Action 1',
//           buttonTitle: 'Send',
//           placeholder: 'Placeholder',
//         ),
//       ],
//     ),
//     DarwinNotificationCategory(
//       'plainCategory',
//       actions: <DarwinNotificationAction>[
//         DarwinNotificationAction.plain('id_1', 'Action 1'),
//         DarwinNotificationAction.plain(
//           'id_2',
//           'Action 2 (destructive)',
//           options: <DarwinNotificationActionOption>{
//             DarwinNotificationActionOption.destructive,
//           },
//         ),
//         DarwinNotificationAction.plain(
//           'id_3',
//           'Action 3 (foreground)',
//           options: <DarwinNotificationActionOption>{
//             DarwinNotificationActionOption.foreground,
//           },
//         ),
//         DarwinNotificationAction.plain(
//           'id_4',
//           'Action 4 (auth required)',
//           options: <DarwinNotificationActionOption>{
//             DarwinNotificationActionOption.authenticationRequired,
//           },
//         ),
//       ],
//       options: <DarwinNotificationCategoryOption>{
//         DarwinNotificationCategoryOption.hiddenPreviewShowTitle,
//       },
//     )
//   ];

//   final DarwinInitializationSettings initSettingsIOS =
//       DarwinInitializationSettings(
//     requestAlertPermission: true,
//     requestBadgePermission: true,
//     requestSoundPermission: true,
//     onDidReceiveLocalNotification:
//         (int id, String? title, String? body, String? payload) async {
//       didReceiveLocalNotificationStream.add(
//         ReceivedNotification(
//           id: id,
//           title: title,
//           body: body,
//           payload: payload,
//         ),
//       );
//     },
//     notificationCategories: darwinNotificationCategories,
//   );
//   final LinuxInitializationSettings initializationSettingsLinux =
//       LinuxInitializationSettings(
//     defaultActionName: 'Open notification',
//     defaultIcon: AssetsLinuxIcon('icons/app_icon.png'),
//   );

//   final InitializationSettings initSettings = InitializationSettings(
//     android: initSettingsAndroid,
//     iOS: initSettingsIOS,
//     macOS: initSettingsIOS,
//     linux: initializationSettingsLinux,
//   );

//   await flutterLocalNotificationsPlugin.initialize(
//     initSettings,
//     onDidReceiveNotificationResponse:
//         (NotificationResponse notificationResponse) {
//       print("Hello motherfucker!");
//       if (notificationResponse.notificationResponseType ==
//           NotificationResponseType.selectedNotification) {
//         selectNotificationStream.add(notificationResponse.payload);
//       }
//     },
//   );
// runApp(
//   ChangeNotifierProvider(
//     create: (context) => AllAlarms(),
//     child: MaterialApp(
//         debugShowCheckedModeBanner: false,
//         initialRoute: initialRoute,
//         //home: AlarmScreen(),
//         routes: {
//           '/': (context) => AlarmScreen(),
//           '/setAlarm': (context) => SetAlarm(),
//           '/equationSettings': (context) =>
//               AlarmScreen(), //TODO: Change to equation settings
//           '/exerciseSettings': (context) =>
//               AlarmScreen(), //TODO: Change to exercise settings
//           '/QRSettings': (context) =>
//               MainScreen(), //TODO: Change to QR settings
//           '/gameSettings': (context) =>
//               AlarmScreen(), //TODO: Change to game settings
//         }),
//   ),
// );
//   await Alarm.init();
// }

// notificationDetails() {
//   return const NotificationDetails(
//     android: AndroidNotificationDetails(
//       'channelId',
//       'channelName',
//       importance: Importance.max,
//       priority: Priority.max,
//       fullScreenIntent: true,
//     ),
//     iOS: DarwinNotificationDetails(),
//   );
// }

// Future<void> showNotification(
//     {int id = 0,
//     required String title,
//     required String body,
//     required String payload}) async {
//   await flutterLocalNotificationsPlugin.show(
//     id,
//     title,
//     body,
//     await notificationDetails(),
//     payload: payload,
//   );
// }
import 'dart:async';

import 'package:alarm/alarm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:moody_morning/screens/alarms_screen.dart';
import 'package:moody_morning/screens/set_alarm.dart';
import 'package:moody_morning/screens/solve_QRcode.dart';
import 'package:moody_morning/system/all_alarms.dart';
import 'package:provider/provider.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

//This should handle notifications on iOS
final StreamController<ReceivedNotification> didReceiveLocalNotificationStream =
    StreamController<ReceivedNotification>.broadcast();

//create listener to subscribe to user interaction with notification
final StreamController<String?> selectNotificationStream =
    StreamController<String?>.broadcast();

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

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Alarm.init();

  final InitializationSettings initializationSettings =
      getNotificationInitSettings();
  await flutterLocalNotificationsPlugin.initialize(
    initializationSettings,
    onDidReceiveNotificationResponse:
        (NotificationResponse notificationResponse) {
      // print("Hello there");
      if (notificationResponse.notificationResponseType ==
          NotificationResponseType.selectedNotification) {
        selectNotificationStream.add(notificationResponse.payload);
      }
    },
  );

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

getNotificationInitSettings() {
  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('flutter_logo');

  final DarwinInitializationSettings initializationSettingsDarwin =
      DarwinInitializationSettings(
    requestAlertPermission: true,
    requestBadgePermission: true,
    requestSoundPermission: true,
    onDidReceiveLocalNotification:
        (int id, String? title, String? body, String? payload) async {
      didReceiveLocalNotificationStream.add(
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
    defaultIcon: AssetsLinuxIcon('icons/flutter_logo.png'),
  );
  return InitializationSettings(
    android: initializationSettingsAndroid,
    iOS: initializationSettingsDarwin,
    macOS: initializationSettingsDarwin,
    linux: initializationSettingsLinux,
  );
}
