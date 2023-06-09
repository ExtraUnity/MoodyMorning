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
  for (int i = 1; i < 10; i++) {
    //Creates button, assign a value and add to list:
    NumButton button = NumButton(
        onPressed: () {
          print("$i");
        },
        child: Text("$i"),
        numValue: i);
    completeButtonList.add(button);
  }
  return completeButtonList;
}

class NumButton extends ElevatedButton {
  final int numValue;
  const NumButton(
      {super.key,
      required super.onPressed,
      required super.child,
      required this.numValue}); //Separate button-instances by value
}
