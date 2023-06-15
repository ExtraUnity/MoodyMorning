import 'package:flutter/material.dart';
import 'package:moody_morning/widgets/challenge_icon_button.dart';
import 'package:moody_morning/widgets/scroll_wheel.dart';
import 'package:moody_morning/widgets/logo_app_bar.dart';
import 'package:moody_morning/system/alarm_callback.dart';
import 'package:alarm/alarm.dart';
import 'package:provider/provider.dart';

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
  String selectedChallenge = "/QRSettings";
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
              context: context,
              buttonPressed: (path) {
                setState(() => selectedChallenge = path);

                print("Selected path $path");
              },
              borderWidth:
                  1.0 + (selectedChallenge == "/equationSettings" ? 2 : 0),
            ),
            ChallengeIconButton(
              icon: const Icon(Icons.fitness_center),
              path: '/exerciseSettings',
              context: context,
              buttonPressed: (path) {
                setState(() => selectedChallenge = path);
                print("Selected path $path");
              },
              borderWidth:
                  1.0 + (selectedChallenge == "/exerciseSettings" ? 2 : 0),
            ),
            ChallengeIconButton(
              icon: const Icon(Icons.qr_code_2),
              path: '/QRSettings',
              context: context,
              buttonPressed: (path) {
                setState(() => selectedChallenge = path);
                print("Selected path $path");
              },
              borderWidth: 1.0 + (selectedChallenge == "/QRSettings" ? 2 : 0),
            ),
            ChallengeIconButton(
              icon: const Icon(Icons.videogame_asset),
              path: '/gameSettings',
              context: context,
              buttonPressed: (path) {
                setState(() => selectedChallenge = path);
                print("Selected path $path");
              },
              borderWidth: 1.0 + (selectedChallenge == "/gameSettings" ? 2 : 0),
            ),
          ],
        ),
        const SizedBox(height: 50),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          SizedBox(
            width: 100,
            child: ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/');
                },
                child: const Text("Cancel")),
          ),
          const SizedBox(width: 20),
          SizedBox(
            width: 100,
            child: ElevatedButton(
              onPressed: () async {
                AlarmData alarm = AlarmData.createAlarmData(selectedHour, selectedMinute, selectedChallenge);
                if (await Permission.scheduleExactAlarm.isDenied) {
                  print("Permission to schedule alarm is denied");
                }
                PermissionStatus status =
                    await Permission.scheduleExactAlarm.request();
                while (status.isDenied) {
                  status = await Permission.scheduleExactAlarm.request();
                }

                if (status.isPermanentlyDenied) {
                  //Open app settings to allow user to grant permission
                  await openAppSettings();
                }
                if (await Permission.scheduleExactAlarm.isGranted) {
                  AllAlarms.addAlarm(alarm);
                }
                try {
                  Alarm.ringStream.stream.listen(
                      (activeAlarm) => handleAlarm(context, activeAlarm));
                } catch (_) {
                  print("Already listening");
                }
                // ignore: use_build_context_synchronously
                Navigator.pushReplacementNamed(context, '/');
              },
              child: const Text("Save"),
            ),
          ),
        ]),
      ]),
    );
  }
}
