import 'package:alarm/alarm.dart';
import 'package:moody_morning/main.dart';
import 'package:moody_morning/system/all_alarms.dart';

///find active AlarmData and show notification
void handleAlarm(AlarmSettings activeAlarm) async {
  //get AlarmData that matches activeAlarm
  AlarmData alarmData = AllAlarms.alarms
      .firstWhere((alarm) => alarm.alarmsetting.id == activeAlarm.id);

  await notificationService
      .showNotification('${alarmData.payload} ${activeAlarm.id}');
}
