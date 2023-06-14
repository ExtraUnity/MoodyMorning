import 'dart:math';

class Accelerometer {
  num _x = 0.0;
  num _y = 0.0;
  num _z = 0.0;
  double velocity = 0.0;
  double magnitude = 0.0;

  /* void startListening() {
    _streamSubscription = accelerometerEvents.listen((AccelerometerEvent event) {
      _x = event.x;
      _y = event.y;
      _z = event.z;
    });
  }

  void stopListening() {
    _streamSubscription?.cancel();
    _streamSubscription = null;
  } */
  set x(num val) => _x = val;
  set y(num val) => _y = val;
  set z(num val) => _z = val;
  num get x => _x;
  num get y => _y;
  num get z => _z;
  double toMagnitude(num x, num y, num z) {
    magnitude = sqrt(x *  x + y * y + z * z);
    return magnitude;
  }
}
