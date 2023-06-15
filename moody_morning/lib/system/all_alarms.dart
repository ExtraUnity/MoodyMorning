import 'package:alarm/alarm.dart';
import 'package:flutter/material.dart';

class AlarmData {
  bool active = true;
  AlarmSettings alarmsetting;
  String payload;
  AlarmData(this.alarmsetting, {required this.payload});

  void stopStartAlarm() {
    if (active) {
      Alarm.stop(alarmsetting.id);
      active = !active;
    } else {
      Alarm.set(alarmSettings: alarmsetting);
      active = !active;
    }
  }
}

class AllAlarms extends ChangeNotifier {
  static List<AlarmData> alarms = <AlarmData>[];

  void addAlarm(AlarmData alarm) {
    int num = 0;
    for (var current in alarms) {
      if (compare(current, alarm)) {
        break;
      }
      num++;
    }
    alarms.insert(num, alarm);
    print("Setting alarm");
    Alarm.set(alarmSettings: alarm.alarmsetting);
    notifyListeners();
  }

  void deleteAlarm(AlarmData alarm) {}

  bool compare(AlarmData current, AlarmData alarm) {
    if (current.alarmsetting.dateTime.hour > alarm.alarmsetting.dateTime.hour) {
      return true;
    } else if (current.alarmsetting.dateTime.hour ==
        alarm.alarmsetting.dateTime.hour) {
      return current.alarmsetting.dateTime.minute >=
          alarm.alarmsetting.dateTime.minute;
    }
    return false;
  }
}

void challengeSolved(BuildContext context) {
  AlarmData alarm = getRingingAlarm(context);
  alarm.stopStartAlarm();
  if (context.mounted) Navigator.pushReplacementNamed(context, '/');
}

AlarmData getRingingAlarm(BuildContext context) {
  final alarmID = ModalRoute.of(context)!.settings.arguments as int;
  return AllAlarms.alarms
      .firstWhere((alarm) => alarm.alarmsetting.id == alarmID);
}
