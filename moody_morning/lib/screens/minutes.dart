import 'package:flutter/material.dart';

class MyMinutes extends StatelessWidget {
  int minutes;

  MyMinutes({super.key, required this.minutes});

  @override
  Widget build(BuildContext context) {
    return Container(child: Center(child: Text('$minutes')));
  }
}
