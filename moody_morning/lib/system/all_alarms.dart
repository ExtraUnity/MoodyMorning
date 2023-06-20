import 'dart:convert';
import 'package:alarm/alarm.dart';
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:moody_morning/system/alarm_callback.dart';
import 'package:volume_controller/volume_controller.dart';

class AlarmData implements Comparable {
  bool _active = true;
  late AlarmSettings _alarmsetting;
  final String _payload;
  final int _id;
  final int _hours;
  final int _minutes;

  AlarmData.createAlarmData(
    this._hours,
    this._minutes,
    this._payload,
    this._id,
  ) {
    _alarmsetting = _determineAlarmSettings();
  }

  bool get isActive => _active;

  AlarmSettings get alarmsetting => _alarmsetting;

  String get payload => _payload;

  void stopStartAlarm() {
    if (_active) {
      Alarm.stop(alarmsetting.id);
      _active = false;
    } else {
      setAlarm();
      _active = true;
    }
  }

  Future<void> setAlarm() async {
    _alarmsetting = _determineAlarmSettings();
    await Alarm.set(alarmSettings: alarmsetting);
  }

  AlarmSettings _determineAlarmSettings() {
    TimeDifference timeDifference = _getTimeDifference();
    return AlarmSettings(
      id: _id,
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

  TimeDifference _getTimeDifference() {
    int hoursDifference = (_hours - DateTime.now().hour);
    int minutesDifference = (_minutes - DateTime.now().minute);
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
        'hours': _hours,
        'minutes': _minutes,
        '_payload': _payload,
        'active': _active,
        'id': _id,
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
        loadedAlarms.add(AlarmData.createAlarmData(
          oldAlarms[i]['hours'],
          oldAlarms[i]['minutes'],
          oldAlarms[i]['_payload'],
          oldAlarms[i]['id'],
        ));
        loadedAlarms[i]._active = oldAlarms[i]['active'];
        if (loadedAlarms[i]._active) {
          Alarm.set(alarmSettings: loadedAlarms[i].alarmsetting);
          try {
            Alarm.ringStream.stream
                .listen((activeAlarm) => handleAlarm(activeAlarm));
          } catch (_) {
            debugPrint("Already listening");
          }
        }
      }
      alarms = loadedAlarms;
    }
  }

  static int findMaxID() {
    if (alarms.isEmpty) {
      return 0;
    }
    int max = alarms.elementAt(0)._id;
    for (AlarmData alarm in alarms) {
      if (alarm._id > max) {
        max = alarm._id;
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
