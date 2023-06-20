import 'package:flutter/material.dart';
import 'package:moody_morning/system/all_alarms.dart';
import 'package:moody_morning/system/notification_service.dart';
import 'package:moody_morning/widgets/alarm_card.dart';
import 'package:moody_morning/widgets/challenge_icon_button.dart';
import 'package:moody_morning/widgets/logo_app_bar.dart';
import 'package:moody_morning/widgets/navigation_bar.dart';

class AlarmScreen extends StatefulWidget {
  const AlarmScreen({super.key});

  @override
  State<AlarmScreen> createState() => _AlarmScreenState();
}

class _AlarmScreenState extends State<AlarmScreen> {
  bool _show = false;
  @override
  void initState() {
    super.initState();
    () async {
      await AllAlarms.loadJson();
      setState(() {});
    }();
    NotificationService.configureSelectNotificationSubject();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _showDelete() {
    setState(() {
      _show = !_show;
    });
  }

  void _updateScreen() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF423E72),
      appBar: LogoAppBar(),
      bottomNavigationBar: const Navigation(
        startingIndex: 0,
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        child: ListView(
          children: [
            Container(
              alignment: Alignment.topRight,
              margin: const EdgeInsets.symmetric(vertical: 10.0),
              child: ChallengeIconButton(
                icon: const Icon(Icons.edit),
                buttonPressed: (_) => _showDelete(),
                borderWidth: 1.0,
                size: 15,
              ),
            ),
            for (AlarmData alarms in AllAlarms.alarms)
              Column(
                children: [
                  SizedBox(
                      height: 100,
                      child: AlarmCard(
                        alarm: alarms,
                        show: _show,
                        callBack: _updateScreen,
                      )),
                  const Divider(
                    height: 10,
                  )
                ],
              ),
          ],
        ),
      ),
    );
  }
}
