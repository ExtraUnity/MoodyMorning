import 'package:flutter/material.dart';

class MyMinutes extends StatelessWidget {
  final int minutes;

  const MyMinutes({super.key, required this.minutes});

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Center(
            child: Text(
      '$minutes',
      style: const TextStyle(
          fontSize: 40, color: Colors.white, fontWeight: FontWeight.bold),
    )));
  }
}
