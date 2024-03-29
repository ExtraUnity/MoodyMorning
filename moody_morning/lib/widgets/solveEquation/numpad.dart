import 'package:flutter/material.dart';

class NumPad extends StatelessWidget {
  final Function(int) numpadPressedButton;

  const NumPad({
    Key? key,
    required this.numpadPressedButton,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 520,
      child: GridView.count(
        padding: const EdgeInsets.all(30),
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        crossAxisCount: 3,
        children: numButtons(),
      ),
    );
  }

  List<Widget> numButtons() {
    List<NumButton> buttonList = [];
    for (int i = 1; i < 10; i++) {
      NumButton button = NumButton(
          style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF8F8BBF), // Background color
  ),
        onPressed: () {
          numpadPressedButton(i);
        },
        value: i,
        child: Text("$i", style: const TextStyle(fontSize: 30)),
      );
      buttonList.add(button);
    }

    NumButton button0 = NumButton(
       style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF8F8BBF), // Background color
  ),
      onPressed: () {
        numpadPressedButton(0);
      },
      value: 0,
      child: const Text("0", style: TextStyle(fontSize: 30)),
    );

    NumButton buttonBack = NumButton(
       style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF8F8BBF), // Background color
  ),
      onPressed: () {
        numpadPressedButton(-1);
      },
      value: -1,
      child: const Text("Clear", style: TextStyle(fontSize: 25)),
    );

    NumButton buttonEnter = NumButton(
       style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF8F8BBF), // Background color
  ),
      onPressed: () {
        numpadPressedButton(10);
      },
      value: 10,
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.arrow_circle_right_outlined,
            size: 50,
          ),
        ],
      ),
    );

    buttonList.addAll([buttonBack, button0, buttonEnter]);

    return buttonList;
  }
}

class NumButton extends ElevatedButton {
  final int value;

  const NumButton({
    Key? key,
    required VoidCallback? onPressed,
    required Widget? child,
    required this.value,
    ButtonStyle? style,
  }) : super(
          key: key,
          onPressed: onPressed,
          child: child,
          style: style,
        );
}


