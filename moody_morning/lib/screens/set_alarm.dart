import 'package:flutter/material.dart';
import 'package:moody_morning/widgets/challenge_icon_button.dart';
import 'package:moody_morning/widgets/scroll_wheel.dart';
import 'package:moody_morning/widgets/logo_app_bar.dart';
import 'package:moody_morning/system/alarm_callback.dart';
import 'package:alarm/alarm.dart';

import 'package:moody_morning/system/all_alarms.dart';
import 'package:moody_morning/widgets/navigation_bar.dart';
import 'package:permission_handler/permission_handler.dart';

class SetAlarm extends StatefulWidget {
  const SetAlarm({super.key});
  @override
  State<SetAlarm> createState() => _SetAlarmState();
}

class _SetAlarmState extends State<SetAlarm> {
  int selectedHour = 0;
  int selectedMinute = 0;
  String selectedChallenge = "/equationSettings";
  late ScrollWheel hours;
  late ScrollWheel minutes;

  _SetAlarmState() {
    hours = ScrollWheel(
      numberOfElements: 24,
      onNumberSelected: (hour) => selectedHour = hour,
    );
    minutes = ScrollWheel(
      numberOfElements: 60,
      onNumberSelected: (minute) => selectedMinute = minute,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF423E72),
      appBar: LogoAppBar(),
      bottomNavigationBar: const Navigation(
        startingIndex: 1,
      ),
      body: Column(children: [
        const SizedBox(height: 50),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          hours,
          const Center(
              child: Text(
            ':',
            style: TextStyle(
                fontSize: 40, color: Colors.white, fontWeight: FontWeight.bold),
          )),
          minutes,
        ]),
        const SizedBox(height: 50),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ChallengeIconButton(
              icon: const Icon(Icons.calculate),
              path: '/equationSettings',
              buttonPressed: (path) =>
                  setState(() => selectedChallenge = path!),
              borderWidth:
                  1.0 + (selectedChallenge == "/equationSettings" ? 2 : 0),
              size: 20.0 + (selectedChallenge == '/equationSettings' ? 5.0 : 0),
            ),
            ChallengeIconButton(
              icon: const Icon(Icons.fitness_center),
              path: '/exerciseSettings',
              buttonPressed: (path) =>
                  setState(() => selectedChallenge = path!),
              borderWidth:
                  1.0 + (selectedChallenge == "/exerciseSettings" ? 2 : 0),
              size: 20.0 + (selectedChallenge == '/exerciseSettings' ? 5.0 : 0),
            ),
            ChallengeIconButton(
              icon: const Icon(Icons.qr_code_2),
              path: '/QRSettings',
              buttonPressed: (path) =>
                  setState(() => selectedChallenge = path!),
              borderWidth: 1.0 + (selectedChallenge == "/QRSettings" ? 2 : 0),
              size: 20.0 + (selectedChallenge == '/QRSettings' ? 5.0 : 0),
            ),
            ChallengeIconButton(
              icon: const Icon(Icons.videogame_asset),
              path: '/gameSettings',
              buttonPressed: (path) =>
                  setState(() => selectedChallenge = path!),
              borderWidth: 1.0 + (selectedChallenge == "/gameSettings" ? 2 : 0),
              size: 20.0 + (selectedChallenge == '/gameSettings' ? 5.0 : 0),
            ),
          ],
        ),
        const SizedBox(height: 50),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          SizedBox(
            width: 100,
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF8F8BBF),
                ),
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/');
                },
                child: const Text("Cancel")),
          ),
          const SizedBox(width: 20),
          SizedBox(
            width: 100,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple.shade300,
              ),
              onPressed: () async {
                createAlarm();
              },
              child: const Text("Save"),
            ),
          ),
        ]),
      ]),
    );
  }

  void createAlarm() async {
    AlarmData alarm = AlarmData.createAlarmData(
        selectedHour, selectedMinute, selectedChallenge);
    await checkPermission();
    if (await Permission.scheduleExactAlarm.isGranted) {
      AllAlarms.addAlarm(alarm);
    }
    try {
      Alarm.ringStream.stream.listen((activeAlarm) => handleAlarm(activeAlarm));
    } catch (_) {
      debugPrint("Already listening");
    }

    if (context.mounted) Navigator.pushReplacementNamed(context, '/');
  }

  Future<void> checkPermission() async {
    if (await Permission.scheduleExactAlarm.isDenied) {
      debugPrint("Permission to schedule alarm is denied");
    }
    PermissionStatus status = await Permission.scheduleExactAlarm.request();
    while (status.isDenied) {
      status = await Permission.scheduleExactAlarm.request();
    }

    if (status.isPermanentlyDenied) {
      //Open app settings to allow user to grant permission
      await openAppSettings();
    }
  }
}
