import 'package:alarm/alarm.dart';
import 'package:flutter/material.dart';

class AlarmData implements Comparable{
  bool active = true;
  AlarmSettings alarmsetting;
  String payload;
  AlarmData(this.alarmsetting, {required this.payload});

  void stopStartAlarm() {
    if (active) {
      Alarm.stop(alarmsetting.id);
      active = false;
    } else {
      Alarm.set(alarmSettings: alarmsetting);
      active = true;
    }
  }
  
  @override
  int compareTo(other) {
    
        if (alarmsetting.dateTime.hour > other.alarmsetting.dateTime.hour) {
      return 1;
    } else if (alarmsetting.dateTime.hour ==
        other.alarmsetting.dateTime.hour) {
      return (alarmsetting.dateTime.minute - other.alarmsetting.dateTime.minute) as int;
    }
    return -1;
  }
}

class AllAlarms extends ChangeNotifier {
  static List<AlarmData> alarms = <AlarmData>[];
  static void addAlarm(AlarmData alarm) {
    
    alarms.add(alarm);
    alarms.sort();
    Alarm.set(alarmSettings: alarm.alarmsetting);
  }

  static void deleteAlarm(int id) {
    int num = 0;
    for(var current in alarms) {
      if (current.alarmsetting.id == id) {
        alarms.removeAt(num);
        Alarm.stop(id);
        break;
      }
      num++;
    }
  }

  static bool compare(AlarmData current, AlarmData alarm) {
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
