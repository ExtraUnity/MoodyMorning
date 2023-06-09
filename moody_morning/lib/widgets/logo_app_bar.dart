import 'package:flutter/material.dart';

class LogoAppBar extends AppBar {
  LogoAppBar({super.key})
      : super(
            title: Image.asset('assets/images/logoFull.png'),
            centerTitle: true,
            backgroundColor: Color(0xFF423E72));
}
