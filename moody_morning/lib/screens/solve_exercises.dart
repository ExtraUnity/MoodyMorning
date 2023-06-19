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
  final Accelerometer _accel = Accelerometer();
  final _streamSubscriptions = <StreamSubscription<dynamic>>[];
  int _exercisesDone = 0;
  bool _isUp = false;
  bool _isDown = false;
  String _instruction = 'Not supposed to be seen!';
  bool _isFinished = false;
  final String _notDone = 'Not Done!';
  final String _done = 'Stop Alarm!';
  @override
  void dispose() {
    super.dispose();
    for (final subscription in _streamSubscriptions) {
      subscription.cancel();
    }
  }

  @override
  void initState() {
    _exercisesDone = 0;
    _isUp = false;
    _isDown = false;
    _isFinished = false;
    _streamSubscriptions
        .add(userAccelerometerEvents.listen((UserAccelerometerEvent event) {
      setState(() {
        _accel.x = event.x;
        _accel.y = event.y;
        _accel.z = event.z;
        _exerciseHandler();
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
              Text(_instruction,
                  style: const TextStyle(fontSize: 40, color: Colors.white)),
              Text(
                  "Amount of $currentExercise: ${(_exercisesDone / 2).floor()}/${(amountExercise / 2).floor()} ",
                  style: const TextStyle(color: Colors.white)),
              //Text('X: ${eve?.x.toStringAsFixed(3)} '),
              //Text('Y: ${eve?.y.toStringAsFixed(3)}'),
              //Text('Z: ${eve?.z.toStringAsFixed(3)}'),
              //Text('magnitude: ${accel.toMagnitude(accel.x,accel.y,accel.z)}')
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      _isFinished ? const Color(0xFF8F8BBF) : Colors.grey[400],
                  textStyle: TextStyle(
                      color: _isFinished ? Colors.white : Colors.grey[700]),
                ),
                onPressed: () => {
                  //stop alarm
                  if (_isFinished) {challengeSolved(context), dispose()}
                },
                child: Text(_isFinished ? _done : _notDone),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _exerciseHandler() {
    if (_exercisesDone >= amountExercise) {
      _instruction = 'Finished!';
      _isFinished = true;
    } else if (_exercisesDone % 2 == 0) {
      _instruction = 'Down!';
    } else {
      _instruction = 'Up!';
    }
    if (_exercisesDone % 2 == 0) {
      //for Down!
      if (!_isDown && _accel.y < accelerationSizeNeg) {
        //down movement = -y acceleration
        _isDown = true;
      } else if (_isDown && !_isUp && (_accel.y > accelerationSize)) {
        //up movement = +y acceleration
        _isUp = true;
      } else if (_isDown && _isUp && (_accel.y.abs() < accelerationSize)) {
        _isDown = false;
        _isUp = false;
        _exercisesDone++;
      } //vi har set at bruger er accelereret ned,så decelereret, og nu stop telefon
    } else {
      //for Up!
      if (!_isUp && _accel.y > accelerationSize) {
        //up movement = +y acceleration
        _isUp = true;
      } else if (_isUp && !_isDown && (_accel.y < accelerationSizeNeg)) {
        //down movement = -y acceleration
        _isDown = true;
      } else if (_isDown && _isUp && (_accel.y.abs() < accelerationSize)) {
        _isDown = false;
        _isUp = false;
        _exercisesDone++;
      } //vi har set at bruger er accelereret ned,så decelereret, og nu stop telefon
    }
  }
}
