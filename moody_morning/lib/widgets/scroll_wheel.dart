import 'package:flutter/material.dart';
import 'package:moody_morning/system/scroll_wheel_functions.dart';
import 'package:moody_morning/screens/set_alarm.dart';

class ScrollWheel extends StatefulWidget {
  final int numberOfElements;
  final Function(int) onNumberSelected;

  const ScrollWheel(
      {super.key,
      required this.numberOfElements,
      required this.onNumberSelected});

  @override
  State<ScrollWheel> createState() => _ScrollWheelState();
}

class _ScrollWheelState extends State<ScrollWheel> {
  int selectedNumber = 0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 70,
        height: 160,
        child: ListWheelScrollView.useDelegate(
            onSelectedItemChanged: (value) {
              widget.onNumberSelected(value);
            },
            itemExtent: 50,
            perspective: 0.01,
            diameterRatio: 2.0,
            physics: const FixedExtentScrollPhysics(),
            childDelegate: ListWheelChildLoopingListDelegate(
                children: getScrollWheelNumbers(widget.numberOfElements))));
  }
}
