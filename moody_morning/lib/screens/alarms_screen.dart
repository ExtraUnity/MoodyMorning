import 'package:flutter/material.dart';
import 'package:moody_morning/system/all_alarms.dart';
import 'package:moody_morning/widgets/logo_app_bar.dart';
import '../widgets/navigation_bar.dart';

class AlarmScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var currentAlarms = AllAlarms();
    currentAlarms.addAlarm(2, 24);
    currentAlarms.addAlarm(2, 24);

    return Scaffold(
      backgroundColor: Colors.purple.shade700,
      appBar: LogoAppBar(),
      bottomNavigationBar: Navigation(
        startingIndex: 0,
      ),
      body: ListView(
        children: [
          for (int i = 0; i < currentAlarms.alarms.length; i++)
            AlarmCard(alarm: currentAlarms.alarms[i], alarmNumb: i),
        ],
      ),
    );
  }
}

class AlarmCard extends StatelessWidget {
  const AlarmCard({
    super.key,
    required this.alarm,
    required this.alarmNumb,
  });

  final Timer alarm;
  final int alarmNumb;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: Text(
              "${alarm.hours} : ${alarm.minutes}",
              textScaleFactor: 2,
            ),
          ),
          OnOff(alarmNumb: alarmNumb),
        ],
      ),
    );
  }
}

class OnOff extends StatefulWidget {
  const OnOff({super.key, required this.alarmNumb});
  final int alarmNumb;
  @override
  State<OnOff> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<OnOff> {
  bool light = false;
  @override
  Widget build(BuildContext context) {
    return Switch(
        value: light,
        onChanged: (bool value) {
          setState(() {
            light = value;
          });
        });
  }
}
