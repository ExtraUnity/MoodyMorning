import 'package:alarm/alarm.dart';
import 'package:flutter/material.dart';
import 'package:moody_morning/screens/alarms_screen.dart';
import 'package:moody_morning/system/all_alarms.dart';
import 'package:provider/provider.dart';

void handleAlarm(BuildContext context, AlarmSettings activeAlarm) async {
  var allAlarms = context.watch<AllAlarms>();
  AlarmData alarmData = getAlarmData(activeAlarm.id, allAlarms.alarms)!;
  await showNotification();
}

AlarmData? getAlarmData(int alarmID, List<AlarmData> allAlarms) {
  for (AlarmData alarm in allAlarms) {
    if (alarm.alarmsetting.id == alarmID) {
      return alarm;
    }
  }
  return null;
}
