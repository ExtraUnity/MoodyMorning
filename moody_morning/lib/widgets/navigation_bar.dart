import 'package:flutter/material.dart';

class Navigation extends StatefulWidget {
  final int startingIndex;
  const Navigation({super.key, required this.startingIndex});

  @override
  State<Navigation> createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  var _currentIndex = 0;
  @override
  void initState() {
    _currentIndex = widget.startingIndex;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: _currentIndex,
      onTap: (index) async {
        if (index == _currentIndex) {
          return;
        }
        setState(() {
          _currentIndex = index;
        });

        switch (index) {
          case 0:
            await Navigator.pushReplacementNamed(context, '/');
            break;
          case 1:
            await Navigator.pushReplacementNamed(context, '/setAlarm');
        }
      },
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Oversigt',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.alarm),
          label: 'Alarm',
        ),
      ],
    );
  }
}
