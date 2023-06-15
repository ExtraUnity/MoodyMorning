// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:moody_morning/system/random_equation_generator.dart';
import '../widgets/solveEquation/alarm_display.dart';
import '../widgets/solveEquation/equation&answer_display.dart';
import '../widgets/solveEquation/numpad.dart';
import 'all_alarms.dart';

class EquationScreenLayout extends StatefulWidget {
  const EquationScreenLayout({super.key});

  @override
  _EquationScreenLayoutState createState() => _EquationScreenLayoutState();
}

class _EquationScreenLayoutState extends State<EquationScreenLayout> {
  String equation = "";
  String inputAnswer = "";
  int solution = -99;

  @override
  void initState() {
    super.initState();
    // Initialization tasks here:
    equation = randomEquationGenerator();
  }

  // Method for specific button functions: "Clear" and "Evaluate (Right-Arrow)":
  void numpadPressedButton(int value) {
    setState(() {
      if (value == -1) {
        // Clear answer when "Clear" is pressed
        inputAnswer = "";
      } else if (value == 10) {
        fetchSolution();
        compareAnswerWithSolution();
      } else {
        displayPressedNumber(value);
      }
    });
  }

  // Perform evaluation and fetches equation solution
  void fetchSolution() {
    List<String> splitEquation =
        equation.split(' '); //filter the string into chars
    List<int> numbers = <int>[];

    // Fills numbers (list) with integers from equation
    for (int n = 0; n < splitEquation.length; n += 2) {
      numbers.add(int.parse(splitEquation[n]));
    }

    calculateSolution(splitEquation, numbers);
  }

  // Compares user input answer with true solution
  void compareAnswerWithSolution() {
    print(inputAnswer);
    print(solution);

    if (int.parse(inputAnswer) == solution) {
      challengeSolved(context);
    } else {
      throw Exception("User's answer to equation was not correct");
    }
  }

  // Makes sure it follows math Precedence under calculation:
  void calculateSolution(List<String> splitEquation, List<int> numbers) {
    if (splitEquation[3] == "x" && splitEquation[1] == "+") {
      solution = numbers[0] + (numbers[1] * numbers[2]);
    } else if (splitEquation[1] == "x" && splitEquation[3] == "+") {
      solution = (numbers[0] * numbers[1] + numbers[2]);
    } else if (!splitEquation.contains("x")) {
      solution = numbers[0] + numbers[1] + numbers[2];
    } else if (!splitEquation.contains("+")) {
      solution = numbers[0] * numbers[1] * numbers[2];
    }
  }

  // Displays any number pressed from 0-9 in Answer Box (limited to max 5 digits)
  void displayPressedNumber(int value) {
    if (inputAnswer.length < 5) {
      inputAnswer += value.toString();
    } else {
      throw Exception("Max digits is 5. Please press the clear button");
    }
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
