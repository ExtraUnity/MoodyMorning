// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:moody_morning/widgets/logo_app_bar.dart';

import '../widgets/solveEquation/screen_layout_updater.dart';

class SolveEquation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
  //TODO:
  //wrap in WillPopScope
    return Scaffold(
      backgroundColor: Color(0xFF423E72),
      appBar: LogoAppBar(), //AppBar
      body: EquationScreenLayout(),
    );
  }
}
