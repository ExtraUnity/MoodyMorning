import 'package:flutter/material.dart';
import 'package:moody_morning/system/all_alarms.dart';
import 'package:moody_morning/widgets/logo_app_bar.dart';
import 'package:provider/provider.dart';
import '../widgets/navigation_bar.dart';
import 'package:alarm/alarm.dart';

class AlarmScreen extends StatefulWidget {
  @override
  State<AlarmScreen> createState() => _AlarmScreenState();
}

class _AlarmScreenState extends State<AlarmScreen> {
  bool show = false;

  void showDelete() {
      setState(() {
        show = !show;
      });
    }

  @override
  Widget build(BuildContext context) {
    var allAlarms = context.watch<AllAlarms>();

    return Scaffold(
      backgroundColor: Colors.purple.shade700,
      appBar: LogoAppBar(),
      bottomNavigationBar: Navigation(),
      body: ListView(
        children: [
          FloatingActionButton(onPressed: () {
              showDelete();
            }),
          for (AlarmData alarms in allAlarms.alarms)
            AlarmCard(alarm: alarms, show: show),
        ],
      ),
    );
  }
}

class AlarmCard extends StatelessWidget {
  const AlarmCard({
    super.key,
    required this.alarm, required this.show,
  });
  final bool show;
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
          Row(
            children: [
              OnOff(alarm : alarm),
              DeleteBotton(id : alarm.alarmsetting.id, show: show),
            ],
          ),
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

class DeleteBotton extends StatefulWidget {
  const DeleteBotton({super.key, required this.id, required this.show});
  final int id;
  final bool show;
  @override
  State<DeleteBotton> createState() => _DeleteBottonState();
}

class _DeleteBottonState extends State<DeleteBotton> {
  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: widget.show,
      child: IconButton(
        onPressed: () {
          print(widget.id);
        },
        icon: const Icon(Icons.remove_circle_outline, color: Colors.red,)
      ),
    );
  }
}
