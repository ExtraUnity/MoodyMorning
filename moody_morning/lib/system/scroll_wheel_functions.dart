import 'package:flutter/material.dart';
import 'package:moody_morning/screens/minutes.dart';
import 'package:moody_morning/screens/tile.dart';
import 'package:moody_morning/screens/hours.dart';
import 'package:moody_morning/widgets/scroll_wheel_number.dart';

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

List<Widget> getScrollWheelNumbers(int n) {
  var numbers = <Widget>[];
  for (int i = 0; i < n; i++) {
    numbers.add(ScrollWheelNumber(number: i));
  }
  return numbers;
}
