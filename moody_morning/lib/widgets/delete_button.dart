import 'package:flutter/material.dart';
import 'package:moody_morning/system/all_alarms.dart';

class DeleteBotton extends StatefulWidget {
  const DeleteBotton(
      {super.key,
      required this.id,
      required this.show,
      required this.callBack});
  final int id;
  final bool show;
  final Function() callBack;

  @override
  State<DeleteBotton> createState() => _DeleteBottonState();
}

class _DeleteBottonState extends State<DeleteBotton> {
  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: widget.show,
      child: IconButton(
          onPressed: () {
            setState(() {
              AllAlarms.deleteAlarm(widget.id);
              widget.callBack();
            });
          },
          icon: const Icon(
            Icons.remove_circle_outline,
            color: Colors.red,
          )),
    );
  }
}
