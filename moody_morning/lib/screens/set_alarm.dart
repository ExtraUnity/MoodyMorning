import 'package:flutter/material.dart';
import 'package:moody_morning/widgets/scroll_wheel.dart';
import 'package:moody_morning/widgets/logo_app_bar.dart';
import 'package:moody_morning/system/alarm_callback.dart';
import 'package:alarm/alarm.dart';

import '../widgets/navigation_bar.dart';

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
    return Scaffold(
      backgroundColor: Color(0xFF423E72),
      appBar: LogoAppBar(),
      bottomNavigationBar: Navigation(),
      body: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        hours,
        const Center(
            child: Text(
          ':',
          style: TextStyle(
              fontSize: 40, color: Colors.white, fontWeight: FontWeight.bold),
        )),
        minutes,
      ]),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          int hourDifference = (selectedHour - DateTime.now().hour) % 24;
          int minuteDifference = (selectedMinute - DateTime.now().minute) % 60;

          var sortedAlarms = Alarm.getAlarms()
            ..sort((a, b) => b.id.compareTo(a.id)); //get highest id

          final alarmSettings = AlarmSettings(
            //create alarm settings
            id: sortedAlarms.isNotEmpty ? sortedAlarms.elementAt(0).id + 1 : 0,
            dateTime: DateTime.now().add(Duration(
                hours: hourDifference,
                minutes: minuteDifference,
                seconds: -DateTime.now().second)),
            assetAudioPath: 'assets/sounds/galaxy_alarm.mp3',
            vibrate: true,
            notificationTitle: 'Time to wake up!',
            notificationBody: 'Press here to get your challenge!',
            enableNotificationOnKill: true,
            stopOnNotificationOpen: false,
          );

          Alarm.set(alarmSettings: alarmSettings);
          Alarm.ringStream.stream
              .listen((activeAlarm) => handleAlarm(activeAlarm));
        },
      ),
    );
  }
}
