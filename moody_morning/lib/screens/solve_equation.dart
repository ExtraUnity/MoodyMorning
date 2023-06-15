// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:moody_morning/widgets/logo_app_bar.dart';

import '../system/numpad_reader.dart';

class SolveEquation extends StatelessWidget {
  const SolveEquation({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: Color(0xFF423E72),
        appBar: LogoAppBar(), //AppBar
        body: EquationScreenLayout(),
      ),
    );
  }
}
