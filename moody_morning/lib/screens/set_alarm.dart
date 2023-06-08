import 'package:flutter/material.dart';
import 'package:moody_morning/screens/minutes.dart';
import 'package:moody_morning/screens/tile.dart';

class SetAlarm extends StatefulWidget {
  const SetAlarm({super.key});

  @override
  State<SetAlarm> createState() => _SetAlarmState();
}

class _SetAlarmState extends State<SetAlarm> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.purple.shade700,
        appBar: AppBar(
          title: Image.asset('assets/images/logoFull.png'),
          centerTitle: true,
          backgroundColor: Colors.purple.shade800,
        ),
        body: Center(
          child: ListWheelScrollView.useDelegate(
            itemExtent: 60,
            physics: FixedExtentScrollPhysics(),
            childDelegate: ListWheelChildBuilderDelegate(
                childCount: 60,
                builder: (context, index) => MyMinutes(minutes: index)),
          ),
        ));
  }
}
