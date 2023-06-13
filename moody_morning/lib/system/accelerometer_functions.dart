
class Accelerometer {
  double _x = 0.0;
  double _y = 0.0;
  double _z = 0.0;


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
  set x(double val) => _x = val;
  set y(double val) => _y = val;
  set z(double val) => _z = val;
  double get x => _x;
  double get y => _y;
  double get z => _z;
}
