import 'package:alarm/alarm.dart';
import 'package:flutter/material.dart';

class AlarmData implements Comparable{
  bool active = true;
  late AlarmSettings alarmsetting;
  final String payload;
  final int id = calcID();
  final int hours;
  final int minutes;
  AlarmData(this.alarmsetting, this.hours, this.minutes, {required this.payload});

  AlarmData.createAlarmData(this.hours, this.minutes, this.payload) {
    alarmsetting = determineAlarmSettings();
  }
  void stopStartAlarm() {
    if (active) {
      Alarm.stop(alarmsetting.id);
      active = false;
    } else {
      setAlarm();
      active = true;
    }
  }

  void setAlarm() {
    alarmsetting = determineAlarmSettings();
    Alarm.set(alarmSettings: alarmsetting);
  }


  AlarmSettings determineAlarmSettings() {
    
    TimeDifference timeDifference = getTimeDifference();
    return AlarmSettings(
      id: id, 
      dateTime: DateTime.now().add(Duration(hours: timeDifference.hours, minutes: timeDifference.minutes)), 
      assetAudioPath: 'assets/sounds/galaxy_alarm.mp3',
      vibrate: true,
      enableNotificationOnKill: true,
      stopOnNotificationOpen: false,
    );
  }

  TimeDifference getTimeDifference() {
    int hoursDifference = (hours - DateTime.now().hour) % 24; 
    int minutesDifference = (minutes - DateTime.now().minute);
    return TimeDifference(hoursDifference, minutesDifference);
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
  
  static int calcID() {
    var sortedAlarms = AllAlarms.alarms
                  ..sort((a, b) => b.alarmsetting.id
                      .compareTo(a.alarmsetting.id)); //get highest id
    return sortedAlarms.isNotEmpty
                      ? sortedAlarms.elementAt(0).alarmsetting.id + 1
                      : 0;
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
}

class TimeDifference {
  int hours;
  int minutes;
  TimeDifference(this.hours, this.minutes);
}