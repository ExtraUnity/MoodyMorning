import 'package:flutter/material.dart';
import 'package:moody_morning/widgets/challenge_icon_button.dart';
import 'package:moody_morning/widgets/scroll_wheel.dart';
import 'package:moody_morning/widgets/logo_app_bar.dart';
import 'package:moody_morning/system/alarm_callback.dart';
import 'package:alarm/alarm.dart';
import 'package:provider/provider.dart';

import 'package:moody_morning/system/all_alarms.dart';
import 'package:moody_morning/widgets/navigation_bar.dart';

class SetAlarm extends StatefulWidget {
  const SetAlarm({super.key});

  @override
  State<SetAlarm> createState() => _SetAlarmState();
}

class _SetAlarmState extends State<SetAlarm> {
  int selectedHour = 0;
  int selectedMinute = 0;
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
    var allAlarms = context.watch<AllAlarms>();
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
            ),
            ChallengeIconButton(
              icon: const Icon(Icons.fitness_center),
              path: '/exerciseSettings',
              context: context,
            ),
            ChallengeIconButton(
              icon: const Icon(Icons.qr_code_2),
              path: '/QRSettings',
              context: context,
            ),
            ChallengeIconButton(
              icon: const Icon(Icons.videogame_asset),
              path: '/gameSettings',
              context: context,
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
                int hourDifference = (selectedHour - DateTime.now().hour) % 24;
                int minuteDifference =
                    (selectedMinute - DateTime.now().minute) % 60;

                var sortedAlarms = Alarm.getAlarms()
                  ..sort((a, b) => b.id.compareTo(a.id)); //get highest id

                final alarmSettings = AlarmSettings(
                  //create alarm settings
                  id: sortedAlarms.isNotEmpty
                      ? sortedAlarms.elementAt(0).id + 1
                      : 0,
                  dateTime: DateTime.now().add(Duration(
                      hours: hourDifference,
                      minutes: minuteDifference,
                      seconds: -DateTime.now().second)),
                  assetAudioPath: 'assets/sounds/galaxy_alarm.mp3',
                  vibrate: true,
                  // notificationTitle: 'Time to wake up!',
                  // notificationBody: 'Press here to get your challenge!',
                  enableNotificationOnKill: true,
                  stopOnNotificationOpen: false,
                );
                //await Alarm.stop(alarmSettings.id);
                await Alarm.set(alarmSettings: alarmSettings);
                //allAlarms.addAlarm(AlarmData(alarmSettings));

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
