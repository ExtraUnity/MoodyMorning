import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:moody_morning/system/all_alarms.dart';
import 'package:moody_morning/widgets/alarm_card.dart';
import 'package:moody_morning/widgets/challenge_icon_button.dart';
import 'package:moody_morning/widgets/logo_app_bar.dart';
import 'package:moody_morning/widgets/navigation_bar.dart';
import 'package:moody_morning/main.dart';

class AlarmScreen extends StatefulWidget {
  const AlarmScreen({super.key});

  @override
  State<AlarmScreen> createState() => _AlarmScreenState();
}

class _AlarmScreenState extends State<AlarmScreen> {
  @override
  void initState() {
    super.initState();
    () async {
      await AllAlarms.loadJson();
      setState(() {});
    }();
    notificationService.configureSelectNotificationSubject();
  }

  @override
  void dispose() {
    super.dispose();
  }

  bool show = false;
  void showDelete() {
    setState(() {
      show = !show;
    });
  }

  void updateScreen() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF423E72),
      appBar: LogoAppBar(),
      bottomNavigationBar: const Navigation(
        startingIndex: 0,
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        child: ListView(
          children: [
            Container(
              alignment: Alignment.topRight,
              margin: const EdgeInsets.symmetric(vertical: 10.0),
              child: ChallengeIconButton(
                icon: const Icon(Icons.edit),
                buttonPressed: (_) => showDelete(),
                borderWidth: 1.0,
                size: 15,
              ),
            ),
            for (AlarmData alarms in AllAlarms.alarms)
              Column(
                children: [
                  SizedBox(
                      height: 100,
                      child: AlarmCard(
                        alarm: alarms,
                        show: show,
                        callBack: updateScreen,
                      )),
                  const Divider(
                    height: 10,
                  )
                ],
              ),
          ],
        ),
      ),
    );
  }
}

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

  //Display notification
  await notificationService.flutterLocalNotificationsPlugin.show(
    0,
    'Time to wake up!',
    'Click here to get your challenge',
    notificationDetails,
    payload: payload,
  );
}
