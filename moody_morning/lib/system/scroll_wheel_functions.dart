import 'package:flutter/material.dart';
import 'package:moody_morning/screens/minutes.dart';
import 'package:moody_morning/screens/tile.dart';
import 'package:moody_morning/screens/hours.dart';

List<Widget> getScrollWheelHours() {
  var hours = <Widget>[];
  for (int i = 0; i < 24; i++) {
    hours.add(MyHours(hours: i));
  }
  return hours;
}

List<Widget> getScrollWheelMinutes() {
  var minutes = <Widget>[];
  for (int i = 0; i < 60; i++) {
    minutes.add(MyMinutes(minutes: i));
  }
  return minutes;
}
