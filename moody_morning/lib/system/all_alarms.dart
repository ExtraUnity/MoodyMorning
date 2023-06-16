import 'package:alarm/alarm.dart';
import 'package:flutter/material.dart';
import 'package:moody_morning/system/alarm_data.dart';

class AllAlarms extends ChangeNotifier {
  static List<AlarmData> alarms = <AlarmData>[];

  static void addAlarm(AlarmData alarm) {
    alarms.add(alarm);
    alarms.sort();
    debugPrint(
        "Alarm set at: ${alarm.hours}:${alarm.minutes}, the timedate is ${alarm.alarmsetting.dateTime}");
    alarm.setAlarm();
    // Alarm.set(alarmSettings: alarm.alarmsetting);
  }

  static void deleteAlarm(int id) {
    int num = 0;
    for (var current in alarms) {
      if (current.alarmsetting.id == id) {
        alarms.removeAt(num);
        Alarm.stop(id);
        break;
      }
      num++;
    }
  }

  static AlarmData getRingingAlarm(BuildContext context) {
    final alarmID = ModalRoute.of(context)!.settings.arguments as int;
    return alarms.firstWhere((alarm) => alarm.alarmsetting.id == alarmID);
  }
}

class TimeDifference {
  int hours;
  int minutes;
  TimeDifference(this.hours, this.minutes);
}

void challengeSolved(BuildContext context) {
  AlarmData alarm = AllAlarms.getRingingAlarm(context);
  alarm.stopStartAlarm();
  if (context.mounted) Navigator.pushReplacementNamed(context, '/');
}
