// ignore_for_file: unnecessary_getters_setters

import 'dart:math';

class Accelerometer {
  num _x = 0.0;
  num _y = 0.0;
  num _z = 0.0;

  set x(num val) => _x = val;
  set y(num val) => _y = val;
  set z(num val) => _z = val;
  num get x => _x;
  num get y => _y;
  num get z => _z;

}
