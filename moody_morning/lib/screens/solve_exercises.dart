import 'dart:async';

import 'package:flutter/material.dart';
import 'package:moody_morning/system/accelerometer_functions.dart';
import 'package:moody_morning/system/all_alarms.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'package:moody_morning/system/defines_exercise.dart';
import 'package:moody_morning/widgets/logo_app_bar.dart';
import 'package:moody_morning/widgets/solveEquation/alarm_display.dart';

class SolveExercises extends StatefulWidget {
  const SolveExercises({super.key});

  @override
  State<SolveExercises> createState() => _SolveExercisesState();
}

class _SolveExercisesState extends State<SolveExercises> {
  UserAccelerometerEvent? eve;
  Accelerometer accel = Accelerometer();
  final _streamSubscriptions = <StreamSubscription<dynamic>>[];
  int exercisesDone = 0;
  bool isUp = false;
  bool isDown = false;
  String instruction = 'Not supposed to be seen!';
  bool isFinished = false;
  String notDone = 'Not Done!';
  String done = 'Stop Alarm!';
  @override
  void dispose() {
    super.dispose();
    for (final subscription in _streamSubscriptions) {
      subscription.cancel();
    }
  }

  @override
  void initState() {
    exercisesDone = 0;
    isUp = false;
    isDown = false;
    isFinished = false;
    _streamSubscriptions
        .add(userAccelerometerEvents.listen((UserAccelerometerEvent event) {
      setState(() {
        eve = event;
        accel.x = event.x;
        accel.y = event.y;
        accel.z = event.z;
        exerciseHandler();
      });
    }));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: LogoAppBar(),
        backgroundColor: const Color(0xFF423E72),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const AlarmDisplay(),
              Text(instruction,
                  style: const TextStyle(fontSize: 40, color: Colors.white)),
              Text(
                  "Amount of $currentExercise: ${(exercisesDone / 2).floor()}/${(amountExercise / 2).floor()} ",
                  style: const TextStyle(color: Colors.white)),
              //Text('X: ${eve?.x.toStringAsFixed(3)} '),
              //Text('Y: ${eve?.y.toStringAsFixed(3)}'),
              //Text('Z: ${eve?.z.toStringAsFixed(3)}'),
              //Text('magnitude: ${accel.toMagnitude(accel.x,accel.y,accel.z)}')
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: isFinished ?  Color(0xFF8F8BBF) : Colors.grey[400],
                  textStyle: TextStyle(color: isFinished ? Colors.white : Colors.grey[700]),
                ),
                onPressed: () => {
                  //stop alarm
                  if (isFinished) {challengeSolved(context), dispose()}
                },
                child: Text(isFinished ? done : notDone),
              )
            ],
          ),
        ),
      ),
    );
  }

  void exerciseHandler() {
    if (exercisesDone >= amountExercise) {
      instruction = 'Finished!';
      isFinished = true;
    } else if (exercisesDone % 2 == 0) {
      instruction = 'Down!';
    } else {
      instruction = 'Up!';
    }
    if (exercisesDone % 2 == 0) {
      //for Down!
      if (!isDown && accel.y < accelerationSizeNeg) {
        //down movement = -y acceleration
        isDown = true;
      } else if (isDown && !isUp && (accel.y > accelerationSize)) {
        //up movement = +y acceleration
        isUp = true;
      } else if (isDown && isUp && (accel.y.abs() < accelerationSize)) {
        isDown = false;
        isUp = false;
        exercisesDone++;
      } //vi har set at bruger er accelereret ned,så decelereret, og nu stop telefon
    } else {
      //for Up!
      if (!isUp && accel.y > accelerationSize) {
        //up movement = +y acceleration
        isUp = true;
      } else if (isUp && !isDown && (accel.y < accelerationSizeNeg)) {
        //down movement = -y acceleration
        isDown = true;
      } else if (isDown && isUp && (accel.y.abs() < accelerationSize)) {
        isDown = false;
        isUp = false;
        exercisesDone++;
      } //vi har set at bruger er accelereret ned,så decelereret, og nu stop telefon
    }
  }
}
