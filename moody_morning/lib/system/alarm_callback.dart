import 'package:alarm/alarm.dart';
import 'package:flutter/material.dart';
import 'package:moody_morning/screens/alarms_screen.dart';
import 'package:moody_morning/system/all_alarms.dart';

void handleAlarm(AlarmSettings activeAlarm) async {
  //get AlarmData that matches activeAlarm
  for (AlarmData alarm in AllAlarms.alarms) {
    debugPrint("Alarm with id ${alarm.id}");
  }
  AlarmData alarmData = AllAlarms.alarms
      .firstWhere((alarm) => alarm.alarmsetting.id == activeAlarm.id);

  debugPrint("Alarm going off - Expected challenge: ${alarmData.payload}");
  await showNotification('${alarmData.payload} ${activeAlarm.id}');
}
