import 'package:flutter/material.dart';
import 'package:moody_morning/system/all_alarms.dart';
import 'package:moody_morning/widgets/logo_app_bar.dart';
import 'package:provider/provider.dart';
import '../widgets/navigation_bar.dart';
import 'package:alarm/alarm.dart';

class AlarmScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    var allAlarms = context.watch<AllAlarms>();

    return Scaffold(
      backgroundColor: Colors.purple.shade700,
      appBar: LogoAppBar(),
      bottomNavigationBar: Navigation(
        startingIndex: 0,
      ),
      body: ListView(
        children: [
          for (AlarmData alarms in allAlarms.alarms)
            AlarmCard(alarm: alarms,),
        ],
      ),
    );
  }
}

class AlarmCard extends StatelessWidget {
  const AlarmCard({
    super.key,
    required this.alarm,
  });

  final AlarmData alarm;

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
              "${alarm.alarmsetting.dateTime.hour.toString().padLeft(2,"0")} : ${alarm.alarmsetting.dateTime.minute.toString().padLeft(2,"0")}" ,
              textScaleFactor: 2,
            ),
          ),
          OnOff(alarm : alarm),
        ],
      ),
    );
  }
}

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
