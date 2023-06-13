import 'package:alarm/alarm.dart';
import 'package:flutter/material.dart';
import 'package:moody_morning/screens/alarms_screen.dart';
import 'package:moody_morning/main.dart';
import 'package:external_app_launcher/external_app_launcher.dart';
import 'package:moody_morning/screens/solve_QRcode.dart';

void handleAlarm(BuildContext context, AlarmSettings activeAlarm) async {
  print("ALARM IS RINGING AND THIS FUNCTION HAS JUST BEEN CALLED");
  //TODO:
  //Handle different selection of challenges
  //Redirect to correct page

  // await LaunchApp.openApp(
  //     androidPackageName: 'com.example.moody_morning',
  //     // iosUrlScheme: 'pulsesecure://',
  //     // appStoreLink: 'itms-apps://itunes.apple.com/us/app/pulse-secure/id945832041',
  //     openStore: false);
}
