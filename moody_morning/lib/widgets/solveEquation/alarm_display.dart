import 'package:flutter/material.dart';

class AlarmDisplay extends StatelessWidget {
  const AlarmDisplay({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 85,
      width: 380,
      child: Card(
          color: Color(0xFF8F8BBF),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.alarm,
                color: Colors.white,
                size: 60,
              ),
              SizedBox(
                width: 10,
              ),
              Text("(Alarm)",
                  style: TextStyle(
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  )),
            ],
          )),
    );
  }
}
