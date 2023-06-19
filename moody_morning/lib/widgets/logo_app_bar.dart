import 'package:flutter/material.dart';

///The standard app bar to be used in all screens
class LogoAppBar extends AppBar {
  LogoAppBar({super.key})
      : super(
            automaticallyImplyLeading: false,
            title: Image.asset('assets/images/logoFull.png'),
            centerTitle: true,
            backgroundColor: const Color(0xFF423E72));
}
