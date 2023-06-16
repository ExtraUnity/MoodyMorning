import'package:flutter/material.dart';

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
      width: 360,
      child: Card(
        color: Colors.blue,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.calculate,
              color: Colors.white,
              size: 50,
            ),
            Text(
              " $equation = ",
              style: textStyle,
              textAlign: TextAlign.center,
            ),
            const SizedBox(width: 5),
            SizedBox(
              width: 100,
              height: 45,
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Colors.white),
                  borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(answer, style: textStyle,
              textAlign: TextAlign.center,),
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

TextStyle textStyle = const TextStyle(
                fontSize: 27,
                fontWeight: FontWeight.bold,
                color: Colors.white,
  );