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
      color: Colors.white,
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
                  textScaleFactor: 2,
                ),
              ),
            ],
          ),
          OnOff(alarm: alarm),
        ],
      ),
    );
  }
}
