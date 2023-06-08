import 'package:flutter/material.dart';
import 'package:moody_morning/screens/minutes.dart';
import 'package:moody_morning/screens/tile.dart';
import 'package:moody_morning/screens/hours.dart';
import 'package:moody_morning/system/scroll_wheel_functions.dart';

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
        body: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Container(
              width: 70,
              child: ListWheelScrollView.useDelegate(
                  itemExtent: 50,
                  perspective: 0.01,
                  diameterRatio: 2.0,
                  physics: FixedExtentScrollPhysics(),
                  childDelegate: ListWheelChildLoopingListDelegate(
                      children: getScrollWheelHours()))),
          const Center(
              child: Text(
            ':',
            style: TextStyle(
                fontSize: 40, color: Colors.white, fontWeight: FontWeight.bold),
          )),
          Container(
              width: 70,
              child: ListWheelScrollView.useDelegate(
                itemExtent: 50,
                perspective: 0.01,
                diameterRatio: 2.0,
                physics: FixedExtentScrollPhysics(),
                childDelegate: ListWheelChildLoopingListDelegate(
                    children: getScrollWheelMinutes()),
              )),
        ]));
  }
}
