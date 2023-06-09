import 'package:flutter/material.dart';
import 'package:moody_morning/widgets/scroll_wheel.dart';

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
        body: const Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          ScrollWheel(numberOfElements: 24),
          Center(
              child: Text(
            ':',
            style: TextStyle(
                fontSize: 40, color: Colors.white, fontWeight: FontWeight.bold),
          )),
          ScrollWheel(numberOfElements: 60),
        ]));
  }
}
