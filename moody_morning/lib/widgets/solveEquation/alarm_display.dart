import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AlarmDisplay extends StatelessWidget {
  const AlarmDisplay({super.key});

  @override
  Widget build(BuildContext context) {
    String currentTime = DateFormat("HH:mm").format(DateTime.now());

    return SizedBox(
      height: 85,
      width: 380,
      child: Card(
          color: Colors.blue,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.alarm,
                color: Colors.white,
                size: 60,
              ),
              const SizedBox(
                width: 10,
              ),
              Text("${currentTime}  ",
                  style: const TextStyle(
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  )),
            ],
          )),
    );
  }
}
