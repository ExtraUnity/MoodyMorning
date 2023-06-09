import 'package:flutter/material.dart';
import 'package:moody_morning/widgets/scroll_wheel_number.dart';
import 'package:moody_morning/screens/set_alarm.dart';

List<Widget> getScrollWheelNumbers(int n) {
  var numbers = <Widget>[];
  for (int i = 0; i < n; i++) {
    numbers.add(ScrollWheelNumber(number: i));
  }
  return numbers;
}

void sendScrollWheelData(int hours, int minutes) {}
