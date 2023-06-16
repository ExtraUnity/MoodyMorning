import 'package:flutter/material.dart';

class LogoAppBar extends AppBar {
  LogoAppBar({super.key})
      : super(
            automaticallyImplyLeading: false,
            title: Image.asset('assets/images/logoFull.png'),
            centerTitle: true,
            backgroundColor: const Color(0xFF423E72));
}
