import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:moody_morning/system/all_alarms.dart';
import 'package:moody_morning/widgets/logo_app_bar.dart';
import 'package:provider/provider.dart';
import '../widgets/navigation_bar.dart';
import 'package:moody_morning/main.dart';

class AlarmScreen extends StatefulWidget {
  @override
  State<AlarmScreen> createState() => _AlarmScreenState();
}

class _AlarmScreenState extends State<AlarmScreen> {
  @override
  void initState() {
    super.initState();
    _configureSelectNotificationSubject();
  }

  void _configureSelectNotificationSubject() {
    notificationService.selectNotificationStream.stream
        .listen((String? payload) async {
      await Navigator.of(context).pushNamed(payload!);
    });
  }

  @override
  void dispose() {
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
      body: ListView(
        children: [
          for (AlarmData alarms in allAlarms.alarms)
            AlarmCard(
              alarm: alarms,
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
  await notificationService.flutterLocalNotificationsPlugin.show(
      0, 'plain title', 'plain body', notificationDetails,
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
