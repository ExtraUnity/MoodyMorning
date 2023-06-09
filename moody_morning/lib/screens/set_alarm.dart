import 'package:flutter/material.dart';
import 'package:moody_morning/widgets/scroll_wheel.dart';
import 'package:moody_morning/widgets/logo_app_bar.dart';

class SetAlarm extends StatefulWidget {
  const SetAlarm({super.key});

  @override
  State<SetAlarm> createState() => _SetAlarmState();
}

class _SetAlarmState extends State<SetAlarm> {
  ScrollWheel hours = const ScrollWheel(numberOfElements: 24);
  ScrollWheel minutes = const ScrollWheel(numberOfElements: 60);
  int selectedHour = 0;
  int selectedMinute = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF423E72),
      appBar: LogoAppBar(),
      body: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        hours,
        const Center(
            child: Text(
          ':',
          style: TextStyle(
              fontSize: 40, color: Colors.white, fontWeight: FontWeight.bold),
        )),
        minutes,
      ]),
    );
  }
}
