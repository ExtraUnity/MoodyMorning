
import 'package:flutter/material.dart';
import 'package:moody_morning/system/accelerometer_functions.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'dart:math';
import 'package:moody_morning/system/defines_exercise.dart';


  

class SolveExercises extends StatefulWidget {
  const SolveExercises({super.key});

  @override
  State<SolveExercises> createState() => _SolveExercisesState();
}

class _SolveExercisesState extends State<SolveExercises> {
  UserAccelerometerEvent? eve;
  Accelerometer accel = Accelerometer();
  int exercisesDone = 0;
  bool isUp = false;
  bool isDown = false;
  String instruction = 'Not supposed to be seen!';
  @override
  void initState(){
    exercisesDone = 0;
    isUp = false;
    isDown = false;
    instruction = 'Not supposed to be seen!';
    userAccelerometerEvents.listen((UserAccelerometerEvent event) {
      setState(() {
        eve = event;
        accel.x = event.x;
        accel.y = event.y;
        accel.z = event.z;
        exerciseHandler();
      });
     });
    super.initState();
    }
    @override
  
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
              Text("$instruction"),
              Text("Amount of ${CURRENT_EXERCISE}: ${exercisesDone}/$AMOUNT_EXERCISE " ),
              //Text('X: ${eve?.x.toStringAsFixed(3)} '),
              Text('Y: ${eve?.y.toStringAsFixed(3)}'),
              //Text('Z: ${eve?.z.toStringAsFixed(3)}'),
              //Text('magnitude: ${accel.toMagnitude(accel.x,accel.y,accel.z)}')
            ],
          ),
        ),
      ),
    );
  }
  
  void exerciseHandler() {
    if(exercisesDone > AMOUNT_EXERCISE){
      instruction = 'Finished!';
      //afslut alarm
    }
    
    else if(exercisesDone%2==0){
      instruction = 'Down!';
    }
    else {
      instruction = 'Up!';
    }
    if(exercisesDone%2==0){ //for Down!
      if(!isDown && accel.y < ACCELERATION_SIZE_NEG){ //down movement = -y acceleration
        isDown = true;
      }
      else if(isDown && !isUp && (accel.y > ACCELERATION_SIZE)) { //up movement = +y acceleration
        isUp = true;
      }
      else if(isDown && isUp && (accel.y.abs()<ACCELERATION_SIZE)){
        isDown = false;
        isUp = false;
        exercisesDone++;
      } //vi har set at bruger er accelereret ned,så decelereret, og nu stop telefon
    }
    else{ //for Up!
      if(!isUp && accel.y > ACCELERATION_SIZE){ //up movement = +y acceleration
        isUp = true;
      }
      else if(isUp && !isDown && (accel.y < ACCELERATION_SIZE_NEG)) { //down movement = -y acceleration
        isDown = true;
      }
      else if(isDown && isUp && (accel.y.abs()<ACCELERATION_SIZE)){
        isDown = false;
        isUp = false;
        exercisesDone++;
      } //vi har set at bruger er accelereret ned,så decelereret, og nu stop telefon
    }
    



  }
}
