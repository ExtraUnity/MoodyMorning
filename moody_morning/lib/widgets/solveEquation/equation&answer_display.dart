// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class EquationDisplay extends StatelessWidget {
  final String equation;
  final String answer;

  const EquationDisplay({
    Key? key,
    required this.equation,
    required this.answer,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      width: 380,
      child: Card(
        color: Colors.blue,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.calculate,
              color: Colors.white,
              size: 60,
            ),
            SizedBox(width: 5),
            Text(
              " $equation = ",
              style: const TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(width: 5),
            SizedBox(
              width: 100,
              height: 45,
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Colors.white),
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(answer, style: const TextStyle(fontSize: 30)),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
