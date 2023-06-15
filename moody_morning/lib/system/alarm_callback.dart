import 'package:alarm/alarm.dart';
import 'package:moody_morning/screens/alarms_screen.dart';
import 'package:moody_morning/system/all_alarms.dart';

void handleAlarm(AlarmSettings activeAlarm) async {
  //get AlarmData that matches activeAlarm
  AlarmData alarmData = AllAlarms.alarms
      .firstWhere((alarm) => alarm.alarmsetting.id == activeAlarm.id);
  print("Alarm going off - Expected challenge: ${alarmData.payload}");
  await showNotification('${alarmData.payload} ${activeAlarm.id}');
}
