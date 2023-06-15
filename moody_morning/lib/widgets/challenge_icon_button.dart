import 'package:flutter/material.dart';

class ChallengeIconButton extends ElevatedButton {
  final Icon icon;
  final String path;
  final BuildContext context;
  final Function(String) buttonPressed;
  ChallengeIconButton({
    super.key,
    required this.icon,
    required this.path,
    required this.context,
    required this.buttonPressed,
  }) : super(
          onPressed: () {
            buttonPressed(path);
            //Navigator.pushNamed(context, path);
          },
          style: ButtonStyle(
            shape: MaterialStateProperty.all(const CircleBorder()),
            backgroundColor:
                MaterialStateProperty.all(Colors.deepPurple.shade300),
            padding: MaterialStateProperty.all(const EdgeInsets.all(20)),
          ),
          child: icon,
        );
}
