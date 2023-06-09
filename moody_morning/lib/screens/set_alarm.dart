import 'package:flutter/material.dart';
import 'package:moody_morning/widgets/scroll_wheel.dart';

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
      backgroundColor: Colors.purple.shade700,
      appBar: AppBar(
        title: Image.asset('assets/images/logoFull.png'),
        centerTitle: true,
        backgroundColor: Colors.purple.shade800,
      ),
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
