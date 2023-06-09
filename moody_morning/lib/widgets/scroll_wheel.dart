import 'package:flutter/material.dart';
import 'package:moody_morning/system/scroll_wheel_functions.dart';

class ScrollWheel extends StatelessWidget {
  final int numberOfElements;

  const ScrollWheel({super.key, required this.numberOfElements});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 70,
        child: ListWheelScrollView.useDelegate(
            itemExtent: 50,
            perspective: 0.01,
            diameterRatio: 2.0,
            physics: const FixedExtentScrollPhysics(),
            childDelegate: ListWheelChildLoopingListDelegate(
                children: getScrollWheelNumbers(numberOfElements))));
  }
}
