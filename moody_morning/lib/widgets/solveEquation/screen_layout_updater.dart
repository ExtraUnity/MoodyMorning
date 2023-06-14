// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'alarm_display.dart';
import 'equation&answer_display.dart';
import 'numpad.dart';

class EquationScreenLayout extends StatefulWidget {
  const EquationScreenLayout({super.key});

  @override
  _EquationScreenLayoutState createState() => _EquationScreenLayoutState();
}

class _EquationScreenLayoutState extends State<EquationScreenLayout> {
  String equation = "24 x 4";
  String inputAnswer = "";
  int solution = -999;

  // Method for specific button functions: "Clear" and "Evaluate (Right-Arrow)":
  void numpadPressedButton(int value) {
    setState(() {
      if (value == -1) {
        // Clear answer when pressed
        inputAnswer = "";
      } else if (value == 10) {
        fetchSolution();

        // Perform evaluation when (Right-Arrow) is pressed
        if (inputAnswer as int == solution) {
          inputAnswer = checkAnswer(equation, inputAnswer);
          print("correct");
        } else {
          print("wrong");
        }
      } else {
        displayPressedNumber(value);
      }
    });
  }

  int fetchSolution() {
 
    return 0;
  }

  // Displays any number pressed from 0-9 in Answer Box (limited to max 5 digits)
  void displayPressedNumber(int value) {
    if (inputAnswer.length < 5) {
      inputAnswer += value.toString();
    } else {
      throw Exception("Max digits is 5. Please press the clear button");
    }
  }

  // Compare input answer with the evaluated True answer of equation:
  String checkAnswer(String equation, String inputAnswer) {
    return inputAnswer;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        const AlarmDisplay(),
        const SizedBox(height: 15),
        EquationDisplay(
            equation: equation,
            answer: inputAnswer), // Pass the equation and answer
        const SizedBox(height: 5),
        NumPad(
            numpadPressedButton:
                numpadPressedButton) // Pass the evaluateAnswer method
      ],
    );
  }
}
