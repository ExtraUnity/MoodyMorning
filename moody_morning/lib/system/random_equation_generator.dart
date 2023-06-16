import 'dart:math';

String randomEquationGenerator() {
  var rn = Random();
  String o = "";
  String o2 = "";

  int a = rn.nextInt(90)+9; // range 9-99
  int b = rn.nextInt(19)+1; // range: 1-20
  int c = rn.nextInt(9)+1;  // range: 1-10

  o = rn.nextInt(1) > 0.5 ? "+" : "x";
  o2 = rn.nextInt(1) > 0.5 ? "x" : "+";

  return "$a $o $b $o2 $c";
}
