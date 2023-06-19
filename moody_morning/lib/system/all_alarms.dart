import 'dart:convert';
import 'package:alarm/alarm.dart';
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:moody_morning/system/alarm_callback.dart';
import 'package:volume_controller/volume_controller.dart';

class AlarmData implements Comparable {
  bool active = true;
  late AlarmSettings alarmsetting;
  final String payload;
  final int id;
  final int hours;
  final int minutes;
  AlarmData(this.alarmsetting, this.hours, this.minutes, this.id,
      {required this.payload});

  AlarmData.createAlarmData(this.hours, this.minutes, this.payload, this.id) {
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

  Future<void> setAlarm() async {
    alarmsetting = determineAlarmSettings();
    debugPrint(
        "Alarm set at: $hours:$minutes, the timedate is ${alarmsetting.dateTime} with challenge $payload");
    await Alarm.set(alarmSettings: alarmsetting);
  }

  AlarmSettings determineAlarmSettings() {
    TimeDifference timeDifference = getTimeDifference();
    return AlarmSettings(
      id: id,
      dateTime: DateTime.now().add(Duration(
        days: timeDifference.hours < 0 ||
                (timeDifference.hours == 0 && timeDifference.minutes <= 0)
            ? 1
            : 0,
        hours: timeDifference.hours,
        minutes: timeDifference.minutes,
        seconds: -DateTime.now().second,
      )),
      assetAudioPath: 'assets/sounds/galaxy_alarm.mp3',
      vibrate: true,
      enableNotificationOnKill: true,
      stopOnNotificationOpen: false,
    );
  }

  TimeDifference getTimeDifference() {
    int hoursDifference = (hours - DateTime.now().hour);
    int minutesDifference = (minutes - DateTime.now().minute);
    return TimeDifference(hoursDifference, minutesDifference);
  }

  @override
  int compareTo(other) {
    if (alarmsetting.dateTime.hour > other.alarmsetting.dateTime.hour) {
      return 1;
    } else if (alarmsetting.dateTime.hour == other.alarmsetting.dateTime.hour) {
      return (alarmsetting.dateTime.minute - other.alarmsetting.dateTime.minute)
          as int;
    }
    return -1;
  }

  static int calcID() {
    return AllAlarms.alarms.isNotEmpty ? AllAlarms.findMaxID() + 1 : 0;
  }

  Map toJson() => {
        'hours': hours,
        'minutes': minutes,
        'payload': payload,
        'active': active,
        'id': id,
      };
}

class AllAlarms extends ChangeNotifier {
  static List<AlarmData> alarms = <AlarmData>[];
  static late LocalStorage storage;

  static Future<void> addAlarm(AlarmData alarm) async {
    alarms.add(alarm);
    alarms.sort();
    await alarm.setAlarm();
    await saveJson();
    // Alarm.set(alarmSettings: alarm.alarmsetting);
  }

  static Future<void> deleteAlarm(int id) async {
    for (int i = 0; i < alarms.length; i++) {
      if (alarms.elementAt(i).alarmsetting.id == id) {
        alarms.removeAt(i);
        Alarm.stop(id);
        break;
      }
    }
    await saveJson();
  }

  static Future<void> saveJson() async {
    await storage.setItem(
        "savedAlarms", jsonEncode({'alarms': AllAlarms.alarms}));
  }

  static Future<void> loadJson() async {
    List<AlarmData> loadedAlarms = <AlarmData>[];
    if (await storage.getItem('savedAlarms') != null) {
      var tagObjsJson = jsonDecode(storage.getItem('savedAlarms'));

      var oldAlarms = tagObjsJson['alarms'] as List;
      for (int i = 0; i < oldAlarms.length; i++) {
        debugPrint(
            'Loading alarm with id ${oldAlarms[i]['id']} with time ${oldAlarms[i]['hours']}:${oldAlarms[i]['minutes']} and challenge ${oldAlarms[i]['payload']}');
        loadedAlarms.add(AlarmData.createAlarmData(
          oldAlarms[i]['hours'],
          oldAlarms[i]['minutes'],
          oldAlarms[i]['payload'],
          oldAlarms[i]['id'],
        ));
        loadedAlarms[i].active = oldAlarms[i]['active'];
        if (loadedAlarms[i].active) {
          Alarm.set(alarmSettings: loadedAlarms[i].alarmsetting);
        }
        try {
          Alarm.ringStream.stream
              .listen((activeAlarm) => handleAlarm(activeAlarm));
        } catch (_) {
          debugPrint("Already listening");
        }
      }
      alarms = loadedAlarms;
    }
  }

  static int findMaxID() {
    if (alarms.isEmpty) {
      return 0;
    }
    int max = alarms.elementAt(0).id;
    for (AlarmData alarm in alarms) {
      if (alarm.id > max) {
        max = alarm.id;
      }
    }
    return max;
  }
}

class TimeDifference {
  int hours;
  int minutes;
  TimeDifference(this.hours, this.minutes);
}

void challengeSolved(BuildContext context) {
  AlarmData alarm = getRingingAlarm(context);
  alarm.stopStartAlarm();
  VolumeController().removeListener();
  VolumeController().showSystemUI = true;
  if (context.mounted) Navigator.pushReplacementNamed(context, '/');
}

AlarmData getRingingAlarm(BuildContext context) {
  final alarmID = ModalRoute.of(context)!.settings.arguments as int;
  return AllAlarms.alarms
      .firstWhere((alarm) => alarm.alarmsetting.id == alarmID);
}
