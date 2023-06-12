import 'dart:async';

import 'package:flutter/material.dart';
import 'package:moody_morning/widgets/logo_app_bar.dart';
import 'package:moody_morning/system/accelerometer_functions.dart';
import 'package:sensors_plus/sensors_plus.dart';
class exerciseAlarm extends StatefulWidget {
  @override
  _solveExercises createState() => _solveExercises();
}


class _solveExercises extends State<exerciseAlarm> {
  UserAccelerometerEvent? eve;
  @override
  void initState(){
    userAccelerometerEvents.listen((UserAccelerometerEvent event) {
      setState(() {
        eve = event;
      });
     });
    super.initState();
    



    }
  

class SolveExercises extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Accelerometer Example'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('X: ${eve?.x.toStringAsFixed(3)} '),
              Text('Y: ${eve?.y.toStringAsFixed(3)}'),
              Text('Z: ${eve?.z.toStringAsFixed(3)}'),
            ],
          ),
        ),
      ),
    );
  }
}
