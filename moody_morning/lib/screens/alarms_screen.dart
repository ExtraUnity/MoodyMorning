import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:moody_morning/screens/set_alarm.dart';
import 'package:moody_morning/screens/solve_QRcode.dart';
import 'package:moody_morning/system/all_alarms.dart';
import 'package:moody_morning/widgets/logo_app_bar.dart';
import 'package:provider/provider.dart';
import '../system/notification_service.dart';
import '../widgets/navigation_bar.dart';
import 'package:alarm/alarm.dart';
import 'package:moody_morning/main.dart';

class AlarmScreen extends StatefulWidget {
  @override
  State<AlarmScreen> createState() => _AlarmScreenState();
}

class _AlarmScreenState extends State<AlarmScreen> {
  @override
  void initState() {
    super.initState();
    _configureDidReceiveLocalNotificationSubject();
    _configureSelectNotificationSubject();
  }

  void _configureDidReceiveLocalNotificationSubject() {
    didReceiveLocalNotificationStream.stream
        .listen((ReceivedNotification receivedNotification) async {
      await showDialog(
        context: context,
        builder: (BuildContext context) => CupertinoAlertDialog(
          title: receivedNotification.title != null
              ? Text(receivedNotification.title!)
              : null,
          content: receivedNotification.body != null
              ? Text(receivedNotification.body!)
              : null,
          actions: <Widget>[
            CupertinoDialogAction(
              isDefaultAction: true,
              onPressed: () async {
                Navigator.of(context, rootNavigator: true).pop();
                await Navigator.of(context).push(
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) => SetAlarm(),
                  ),
                );
              },
              child: const Text('Ok'),
            )
          ],
        ),
      );
    });
  }

  void _configureSelectNotificationSubject() {
    selectNotificationStream.stream.listen((String? payload) async {
      await Navigator.of(context).pushNamed(payload!);
    });
  }

  @override
  void dispose() {
    //didReceiveLocalNotificationStream.close();
    //selectNotificationStream.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var allAlarms = context.watch<AllAlarms>();

    return Scaffold(
      backgroundColor: Colors.purple.shade700,
      appBar: LogoAppBar(),
      bottomNavigationBar: Navigation(
        startingIndex: 0,
      ),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () async {
              await showNotification();
            },
            child: Text("Click for notification"),
          ),
          if (allAlarms.alarms.isNotEmpty)
            ListView(
              children: [
                for (AlarmData alarms in allAlarms.alarms)
                  AlarmCard(
                    alarm: alarms,
                  ),
              ],
            ),
        ],
      ),
    );
  }
}

Future<void> showNotification() async {
  const AndroidNotificationDetails androidNotificationDetails =
      AndroidNotificationDetails('your channel id', 'your channel name',
          channelDescription: 'your channel description',
          importance: Importance.max,
          priority: Priority.high,
          fullScreenIntent: true,
          ticker: 'ticker');
  const NotificationDetails notificationDetails =
      NotificationDetails(android: androidNotificationDetails);
  await flutterLocalNotificationsPlugin.show(
      id++, 'plain title', 'plain body', notificationDetails,
      payload: '/QRSettings');
}

class AlarmCard extends StatelessWidget {
  const AlarmCard({
    super.key,
    required this.alarm,
  });

  final AlarmData alarm;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: Text(
              "${alarm.alarmsetting.dateTime.hour.toString().padLeft(2, "0")} : ${alarm.alarmsetting.dateTime.minute.toString().padLeft(2, "0")}",
              textScaleFactor: 2,
            ),
          ),
          OnOff(alarm: alarm),
        ],
      ),
    );
  }
}

class OnOff extends StatefulWidget {
  const OnOff({super.key, required this.alarm});
  final AlarmData alarm;
  @override
  State<OnOff> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<OnOff> {
  @override
  Widget build(BuildContext context) {
    return Switch(
        value: widget.alarm.active,
        onChanged: (bool value) {
          setState(() {
            widget.alarm.stopStartAlarm();
          });
        });
  }
}
