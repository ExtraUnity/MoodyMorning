import 'package:flutter/material.dart';

class ChallengeIconButton extends ElevatedButton {
  final Icon icon;
  ChallengeIconButton({super.key, required this.icon})
      : super(
          onPressed: () {},
          style: ButtonStyle(
            shape: MaterialStateProperty.all(const CircleBorder()),
            backgroundColor:
                MaterialStateProperty.all(Colors.deepPurple.shade300),
            padding: MaterialStateProperty.all(const EdgeInsets.all(20)),
          ),
          child: icon,
        );
}
