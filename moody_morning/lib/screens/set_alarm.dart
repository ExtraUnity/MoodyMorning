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
  int _selectedHour = 0;
  int _selectedMinute = 0;
  String _selectedChallenge = "/equationSettings";
  late ScrollWheel _hours;
  late ScrollWheel _minutes;

  _SetAlarmState() {
    _hours = ScrollWheel(
      numberOfElements: 24,
      onNumberSelected: (hour) => _selectedHour = hour,
    );
    _minutes = ScrollWheel(
      numberOfElements: 60,
      onNumberSelected: (minute) => _selectedMinute = minute,
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
        //----Scroll wheel----//
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          _hours,
          const Center(
              child: Text(
            ':',
            style: TextStyle(
                fontSize: 40, color: Colors.white, fontWeight: FontWeight.bold),
          )),
          _minutes,
        ]),
        const Divider(height: 50),
        //----Challenge selection----//
        const Center(
          child: Text(
            'Select your challenge:',
            style: TextStyle(
                fontSize: 30, color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
        const Divider(height: 25),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ChallengeIconButton(
              icon: const Icon(Icons.calculate),
              path: '/equationSettings',
              buttonPressed: (path) =>
                  setState(() => _selectedChallenge = path!),
              borderWidth:
                  1.0 + (_selectedChallenge == "/equationSettings" ? 2 : 0),
              size:
                  20.0 + (_selectedChallenge == '/equationSettings' ? 5.0 : 0),
            ),
            ChallengeIconButton(
              icon: const Icon(Icons.fitness_center),
              path: '/exerciseSettings',
              buttonPressed: (path) =>
                  setState(() => _selectedChallenge = path!),
              borderWidth:
                  1.0 + (_selectedChallenge == "/exerciseSettings" ? 2 : 0),
              size:
                  20.0 + (_selectedChallenge == '/exerciseSettings' ? 5.0 : 0),
            ),
            ChallengeIconButton(
              icon: const Icon(Icons.qr_code_2),
              path: '/QRSettings',
              buttonPressed: (path) =>
                  setState(() => _selectedChallenge = path!),
              borderWidth: 1.0 + (_selectedChallenge == "/QRSettings" ? 2 : 0),
              size: 20.0 + (_selectedChallenge == '/QRSettings' ? 5.0 : 0),
            ),
            ChallengeIconButton(
              icon: const Icon(Icons.videogame_asset),
              path: '/gameSettings',
              buttonPressed: (path) =>
                  setState(() => _selectedChallenge = path!),
              borderWidth:
                  1.0 + (_selectedChallenge == "/gameSettings" ? 2 : 0),
              size: 20.0 + (_selectedChallenge == '/gameSettings' ? 5.0 : 0),
            ),
          ],
        ),
        const Divider(height: 200),
        //----Exit buttons----//
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 150,
              height: 50,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                    elevation: 20,
                    backgroundColor: const Color(0xFF8F8BBF),
                  ),
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/');
                  },
                  child: const Text("Cancel")),
            ),
            const SizedBox(width: 40),
            SizedBox(
              width: 150,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15))),
                  elevation: 20,
                  backgroundColor: Colors.deepPurple.shade300,
                ),
                onPressed: () async {
                  await createAlarm();
                },
                child: const Text("Save"),
              ),
            ),
          ],
        ),
      ]),
    );
  }

  ///Add alarm to AllAlarms list, set the alarm and subscribe to ringStream
  Future<void> createAlarm() async {
    AlarmData alarm = AlarmData.createAlarmData(
        _selectedHour, _selectedMinute, _selectedChallenge, AlarmData.calcID());
    await checkPermission();
    if (await Permission.scheduleExactAlarm.isGranted) {
      await AllAlarms.addAlarm(alarm);
    }
    try {
      Alarm.ringStream.stream.listen((activeAlarm) => handleAlarm(activeAlarm));
    } catch (_) {
      debugPrint("Already listening");
    }

    if (context.mounted) Navigator.pushReplacementNamed(context, '/');
  }

  ///Check if the relevant permissions are allowed to set alarm and request if denied
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
