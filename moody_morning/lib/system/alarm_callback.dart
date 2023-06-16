import 'package:alarm/alarm.dart';
import 'package:flutter/material.dart';
import 'package:moody_morning/main.dart';
import 'package:moody_morning/system/alarm_data.dart';
import 'package:moody_morning/system/all_alarms.dart';

void handleAlarm(AlarmSettings activeAlarm) async {
  //get AlarmData that matches activeAlarm
  AlarmData alarmData = AllAlarms.alarms
      .firstWhere((alarm) => alarm.alarmsetting.id == activeAlarm.id);
  debugPrint("Alarm going off - Expected challenge: ${alarmData.payload}");
  await notificationService
      .showNotification('${alarmData.payload} ${activeAlarm.id}');
}
