import 'package:flutter/material.dart';

class ChallengeIconButton extends ElevatedButton {
  final Icon icon;
  final String? path;
  final Function(String?) buttonPressed;
  final double borderWidth;
  final double size;
  ChallengeIconButton(
      {super.key,
      required this.icon,
      required this.buttonPressed,
      required this.borderWidth,
      required this.size,
      this.path})
      : super(
          onPressed: () {
            buttonPressed(path);
          },
          style: ElevatedButton.styleFrom(
            elevation: 20,
            shape: (CircleBorder(
                side: BorderSide(color: Colors.white, width: borderWidth))),
            backgroundColor: (Colors.deepPurple.shade300),
            padding: (EdgeInsets.all(size)),
          ),
          child: icon,
        );
}
