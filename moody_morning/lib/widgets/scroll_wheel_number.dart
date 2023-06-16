import 'package:flutter/material.dart';

class ScrollWheelNumber extends StatelessWidget {
  final int number;

  const ScrollWheelNumber({super.key, required this.number});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Text(
      number.toString().padLeft(2, "0"),
      style: const TextStyle(
          fontSize: 40, color: Colors.white, fontWeight: FontWeight.bold),
    ));
  }
}
