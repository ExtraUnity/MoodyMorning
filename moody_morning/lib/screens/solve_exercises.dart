import 'dart:async';

import 'package:flutter/material.dart';
import 'package:moody_morning/widgets/logo_app_bar.dart';
import 'package:moody_morning/system/accelerometer_functions.dart';
import 'package:sensors_plus/sensors_plus.dart';


  

class SolveExercises extends StatefulWidget {
  const SolveExercises({super.key});

  @override
  State<SolveExercises> createState() => _SolveExercisesState();
}

class _SolveExercisesState extends State<SolveExercises> {
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
