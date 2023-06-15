import 'package:flutter/material.dart';
import 'package:moody_morning/system/all_alarms.dart';

class OnOff extends StatefulWidget {
  const OnOff({super.key, required this.alarm});
  final AlarmData alarm;
  @override
  State<OnOff> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<OnOff> {
  @override
  Widget build(BuildContext context) {
    return Switch(
        value: widget.alarm.active,
        onChanged: (bool value) {
          setState(() {
            widget.alarm.stopStartAlarm();
          });
        });
  }
}
