import 'package:flutter/material.dart';

class AllAlarms extends ChangeNotifier{
  var alarms = <Timer>[];

  void addAlarm (int hours, int minutes) {
    alarms.add(Timer(hours, minutes));
    notifyListeners();
  }
}

class Timer {
  int hours;
  int minutes;
  Timer(this.hours, this.minutes);
}