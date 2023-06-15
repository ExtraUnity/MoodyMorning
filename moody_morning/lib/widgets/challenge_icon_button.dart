import 'package:flutter/material.dart';

class ChallengeIconButton extends ElevatedButton {
  final Icon icon;
  final String path;
  final BuildContext context;
  final Function(String) buttonPressed;
  final double width;
  final double size;
  ChallengeIconButton({
    super.key,
    required this.icon,
    required this.path,
    required this.context,
    required this.buttonPressed,
    required this.width,
    required this.size,
  }) : super(
          onPressed: () {
            buttonPressed(path);
            //Navigator.pushNamed(context, path);
          },
          style: ButtonStyle(
            shape: MaterialStateProperty.all(CircleBorder(
                side: BorderSide(color: Colors.white, width: width))),
            backgroundColor:
                MaterialStateProperty.all(Colors.deepPurple.shade300),
            padding: MaterialStateProperty.all(EdgeInsets.all(size)),
          ),
          child: icon,
        );
}
