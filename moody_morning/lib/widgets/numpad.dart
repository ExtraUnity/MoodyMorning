import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NumPad extends StatelessWidget {
  const NumPad({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      primary: false,
      padding: const EdgeInsets.all(10),
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      crossAxisCount: 3,
      children: numButtonList(),
    );
  }
}

List<Widget> numButtonList() {
  List<Widget> completeButtonList = [];
  //Creates numberButtons from 1-9 and adds to list:
  for (int i = 1; i < 10; i++) {
    NumButton button = NumButton(
      onPressed: () {
        print("$i");
      },
      child: Text("$i"),
      numValue: i,
    );
    completeButtonList.add(button);
  }

  //Creates the last 3 "functional" buttons (back- & enter button and 0):
  NumButton button0 = NumButton(
      onPressed: () {
        print("0");
      },
      child: Text("0"),
      numValue: 0);

  NumButton buttonBack = NumButton(
      onPressed: () {
        print("pressed Back...");
      },
      child: Text("Back"),
      numValue: 10);

  NumButton buttonEnter = NumButton(
      onPressed: () {
        print("pressed Enter...");
      },
      child: Text("Enter"),
      numValue: 12);

  completeButtonList.addAll([buttonBack, button0, buttonEnter]);

  return completeButtonList;
}

class NumButton extends ElevatedButton {
  final int numValue;

  const NumButton({
    super.key,
    required super.onPressed,
    required super.child,
    required this.numValue,
    ButtonStyle? super.style,
  });
}
