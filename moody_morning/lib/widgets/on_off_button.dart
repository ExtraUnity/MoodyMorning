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
    return Transform.scale(
      scale: 1.5,
      child: Switch(
          activeColor: const Color(0xFF8F8BBF),
          activeTrackColor: Colors.white60,
          inactiveThumbColor: const Color(0xFF8F8BBF),
          value: widget.alarm.active,
          onChanged: (bool value) {
            setState(() async {
              await widget.alarm.stopStartAlarm();
            });
          }),
    );
  }
}
