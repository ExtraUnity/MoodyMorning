import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:moody_morning/system/all_alarms.dart';
import 'package:moody_morning/widgets/logo_app_bar.dart';
import '../widgets/navigation_bar.dart';
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
    _configureSelectNotificationSubject();
  }

  void _configureSelectNotificationSubject() {
    notificationService.selectNotificationStream.stream
        .listen((String? input) async {
      //Ensure that there is no current screen
      while (navigatorKey.currentState!.canPop()) {
        navigatorKey.currentState!.pop();
      }
      List<String> inputs = input!.split(' ');
      String payload = inputs[0];
      int alarmID = int.parse(inputs[1]);
      //Push to relevant challenge screen using navigatorKey
      await navigatorKey.currentState
          ?.pushNamed(
        payload,
        arguments: alarmID,
      )
          .then((value) {
        if (value != null) {
          print("I DONT KNOW WHAT THIS IS ${value.toString()}");
          navigatorKey.currentState?.pushReplacement(
            value as Route<Object>,
          );
        }
      });
    });
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
      body: ListView(
        children: [
          FloatingActionButton(onPressed: () {
              showDelete();
            }),
          for (AlarmData alarms in AllAlarms.alarms)
            AlarmCard(alarm: alarms, show: show, callBack: updateScreen),
        ],
      ),
    );
  }
}

Future<void> showNotification(String payload) async {
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
    0,
    'Time to wake up!',
    'Click here to get your challenge',
    notificationDetails,
    payload: payload,
  );
}

class AlarmCard extends StatelessWidget {
  const AlarmCard({
    super.key,
    required this.alarm, required this.show, required this.callBack,
  });
  final bool show;
  final AlarmData alarm;
  final Function() callBack;

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
          Row(
            children: [
              OnOff(alarm : alarm),
              DeleteBotton(id : alarm.alarmsetting.id, show: show, callBack: callBack),
            ],
          ),
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

class DeleteBotton extends StatefulWidget {
  const DeleteBotton({super.key, required this.id, required this.show, required this.callBack});
  final int id;
  final bool show;
  final Function() callBack;

  @override
  State<DeleteBotton> createState() => _DeleteBottonState();
}

class _DeleteBottonState extends State<DeleteBotton> {
  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: widget.show,
      child: IconButton(
        onPressed: () {
          setState(() {
            AllAlarms.deleteAlarm(widget.id);
            widget.callBack();
          });
        },
        icon: const Icon(Icons.remove_circle_outline, color: Colors.red,)
      ),
    );
  }
}
