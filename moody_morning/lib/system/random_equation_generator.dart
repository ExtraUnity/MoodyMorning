import 'dart:math';

String randomEquationGenerator() {
  var rn = Random();
  String o = "";
  String o2 = "";

  int a = rn.nextInt(100);
  int b = rn.nextInt(20);
  int c = rn.nextInt(10);

  int r = rn.nextInt(4);
  o = rn.nextInt(1) > 0.5 ? "+" : "x";
  o2 = rn.nextInt(1) > 0.5 ? "+" : "x";

  return "$a $o $b $o2 $c";
}
