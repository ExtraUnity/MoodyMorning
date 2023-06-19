import 'package:alarm/alarm.dart';
import 'package:moody_morning/system/all_alarms.dart';
import 'package:moody_morning/system/notification_service.dart';

///find active AlarmData and show notification
void handleAlarm(AlarmSettings activeAlarm) async {
  //get AlarmData that matches activeAlarm
  AlarmData alarmData = AllAlarms.alarms
      .firstWhere((alarm) => alarm.alarmsetting.id == activeAlarm.id);

  await NotificationService.showNotification(
      '${alarmData.payload} ${activeAlarm.id}');
}
