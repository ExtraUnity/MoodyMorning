import 'package:flutter/material.dart';

class Navigation extends StatefulWidget {
  const Navigation ({super.key});

  @override
  State<Navigation> createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  var _currentIndex = 0;
  @override
  Widget build(BuildContext context) {

    return BottomNavigationBar(
      currentIndex: _currentIndex,
      onTap: (index) async {
        setState(() {
          _currentIndex = index;
        });

        switch (index) {
          case 0:
            await Navigator.pushNamed(context,'/');
            break;
          case 1:
            await Navigator.pushNamed(context,'/setAlarm');
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

      ],);
  }
}