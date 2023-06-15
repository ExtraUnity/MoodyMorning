import 'package:flutter/material.dart';

class ChallengeIconButton extends ElevatedButton {
  final Icon icon;
  final String path;
  final BuildContext context;
  final Function(String) buttonPressed;
  final double borderWidth;
  ChallengeIconButton(
      {super.key,
      required this.icon,
      required this.path,
      required this.context,
      required this.buttonPressed,
      this.borderWidth = 1.0})
      : super(
          onPressed: () {
            buttonPressed(path);
            //Navigator.pushNamed(context, path);
          },
          style: ButtonStyle(
            shape: MaterialStateProperty.all(CircleBorder(
                side: BorderSide(color: Colors.white, width: borderWidth))),
            backgroundColor:
                MaterialStateProperty.all(Colors.deepPurple.shade300),
            padding: MaterialStateProperty.all(const EdgeInsets.all(20)),
          ),
          child: icon,
        );
}
