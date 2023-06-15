

import 'dart:math';

String randomEquationGenerator() {
  var rn = Random();
  String o = "";
  String o2 = "";

  int a = rn.nextInt(100);
  int b = rn.nextInt(99);
  int c = rn.nextInt(10);

  int r = rn.nextInt(4);
  if (r == 1) {
    o = "+";
    o2 = "x";
  } else if (r == 2) {
    o = "x";
    o2 = "+";
  } else if (r == 3) {
    o = "x";
    o2 = "x";
  } else {
    o = "+";
    o2 = "+";
  }
  return "$a $o $b $o2 $c";
}
