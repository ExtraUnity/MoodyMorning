import 'package:flutter/material.dart';
import 'package:moody_morning/system/all_alarms.dart';
import 'package:moody_morning/widgets/logo_app_bar.dart';

class AlarmScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var currentAlarms = AllAlarms();
    currentAlarms.addAlarm(2, 24);
    currentAlarms.addAlarm(2, 24);

    return Scaffold(
      backgroundColor: Colors.purple.shade700,
      appBar: LogoAppBar(),
      body: ListView(
        children: [
          for(int i = 0; i < currentAlarms.alarms.length; i++) 
            Alarm(alarm: currentAlarms.alarms[i], numb: i),
        ],
      ),
    );
  }
}

class Alarm extends StatelessWidget {
  const Alarm({
    super.key,
    required this.alarm,
    required this.numb,
  });

  final Timer alarm;
  final int numb;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      child: Row(children: [
        Padding(
          padding: const EdgeInsets.all(10),
          child: Text(alarm.hours.toString() + " : " + alarm.minutes.toString(), textScaleFactor: 2,),
        ),
        SizedBox(width: 200,),
        OnOff(numb: numb),
      ],
      ),
    );
  }
}

class OnOff extends StatefulWidget {
  const OnOff({super.key, required this.numb});
  final int numb;
  @override
  State<OnOff> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<OnOff> {
  bool light = false;
  @override
  Widget build(BuildContext context) {
    return Switch(value: light, 
    onChanged: (bool value) {
       setState(() {
          light = value;
        });
        print(widget.numb);
    });
  }
}
