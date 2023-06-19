import 'package:flutter/material.dart';
import 'package:moody_morning/widgets/logo_app_bar.dart';
import 'package:moody_morning/system/random_equation_generator.dart';
import 'package:moody_morning/widgets/solveEquation/alarm_display.dart';
import 'package:moody_morning/widgets/solveEquation/equation_and_answer_display.dart';
import 'package:moody_morning/widgets/solveEquation/numpad.dart';
import 'package:moody_morning/system/all_alarms.dart';

class SolveEquation extends StatelessWidget {
  const SolveEquation({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: const Color(0xFF423E72),
        appBar: LogoAppBar(), //AppBar
        body: const EquationScreenLayout(),
      ),
    );
  }
}

class EquationScreenLayout extends StatefulWidget {
  const EquationScreenLayout({super.key});

  @override
  EquationScreenLayoutState createState() => EquationScreenLayoutState();
}

class EquationScreenLayoutState extends State<EquationScreenLayout> {
  String _equation = "";
  String _inputAnswer = "";
  int _solution = -99;

  @override
  void initState() {
    super.initState();
    // Initialization tasks here:
    _equation = randomEquationGenerator();
  }

  // Method for specific button functions: "Clear" and "Evaluate (Right-Arrow)":
  void _numpadPressedButton(int value) {
    setState(() {
      if (value == -1) {
        // Clear answer when "Clear" is pressed
        _inputAnswer = "";
      } else if (value == 10) {
        _fetchSolution();
        _compareAnswerWithSolution();
      } else {
        _displayPressedNumber(value);
      }
    });
  }

  // Perform evaluation and fetches equation solution
  void _fetchSolution() {
    List<String> splitEquation =
        _equation.split(' '); //filter the string into chars
    List<int> numbers = <int>[];

    // Fills numbers (list) with integers from equation
    for (int n = 0; n < splitEquation.length; n += 2) {
      numbers.add(int.parse(splitEquation[n]));
    }

    _calculateSolution(splitEquation, numbers);
  }

  // Compares user input answer with true solution
  void _compareAnswerWithSolution() {
    if (int.parse(_inputAnswer) == _solution) {
      challengeSolved(context);
    } else {
      throw Exception("User's answer to equation was not correct");
    }
  }

  // Makes sure it follows math Precedence under calculation:
  void _calculateSolution(List<String> splitEquation, List<int> numbers) {
    if (splitEquation[3] == "x" && splitEquation[1] == "+") {
      _solution = numbers[0] + (numbers[1] * numbers[2]);
    } else if (splitEquation[1] == "x" && splitEquation[3] == "+") {
      _solution = (numbers[0] * numbers[1] + numbers[2]);
    } else if (!splitEquation.contains("x")) {
      _solution = numbers[0] + numbers[1] + numbers[2];
    } else if (!splitEquation.contains("+")) {
      _solution = numbers[0] * numbers[1] * numbers[2];
    }
  }

  // Displays any number pressed from 0-9 in Answer Box (limited to max 5 digits)
  void _displayPressedNumber(int value) {
    if (_inputAnswer.length < 5) {
      _inputAnswer += value.toString();
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
            equation: _equation,
            answer: _inputAnswer), // Pass the equation and answer
        NumPad(
            numpadPressedButton:
                _numpadPressedButton) // Pass the evaluateAnswer method
      ],
    );
  }
}
