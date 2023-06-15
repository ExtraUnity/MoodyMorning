import 'package:flutter/material.dart';
import 'package:moody_morning/system/all_alarms.dart';
import 'package:moody_morning/widgets/delete_button.dart';
import 'package:moody_morning/widgets/on_off_button.dart';

class AlarmCard extends StatelessWidget {
  const AlarmCard({
    super.key,
    required this.alarm,
    required this.show,
    required this.callBack,
  });
  final bool show;
  final AlarmData alarm;
  final Function() callBack;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20))),
      elevation: 3,
      color: const Color(0xFF8F8BBF),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              DeleteBotton(
                  id: alarm.alarmsetting.id, show: show, callBack: callBack),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Text(
                  "${alarm.alarmsetting.dateTime.hour.toString().padLeft(2, "0")} : ${alarm.alarmsetting.dateTime.minute.toString().padLeft(2, "0")}",
                  textScaleFactor: 3,
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
          Container(
              margin: const EdgeInsets.fromLTRB(0, 0, 10, 0),
              child: OnOff(alarm: alarm)),
        ],
      ),
    );
  }
}
