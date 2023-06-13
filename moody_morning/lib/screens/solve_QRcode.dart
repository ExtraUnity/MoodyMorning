import 'dart:math';
import 'dart:typed_data';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
//import 'package:moody_morning/widgets/logo_app_bar.dart';
import 'dart:collection';
import 'package:mobile_scanner/mobile_scanner.dart';


class MyHomePageState extends StatelessWidget {
  MobileScannerController cameraController = MobileScannerController();
  bool _screenOpened = false;

  // Flashlight
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mobile Scanner'),
        actions: [
          /*
          IconButton(
            color: Colors.blue,
            icon: ValueListenableBuilder(
              valueListenable: cameraController.torchState,
              builder: (context, state, child) {
                switch (state as TorchState) {
                  case TorchState.off:
                    return const Icon(Icons.flash_off, color: Colors.grey);
                  case TorchState.on:
                    return const Icon(Icons.flash_on, color: Colors.yellow);
                }
              },
            ),
            iconSize: 32.0,
            onPressed: () => cameraController.toggleTorch(),
          ),*/
          IconButton(
            //front or back camera
            color: Colors.white,
            icon: ValueListenableBuilder(
              valueListenable: cameraController.cameraFacingState,
              builder: (context, state, child) {
                switch (state as CameraFacing) {
                  case CameraFacing.front:
                    return const Icon(Icons.camera_front);
                  case CameraFacing.back:
                    return const Icon(Icons.camera_rear);
                }
              },
            ),
            iconSize: 32.0,
            onPressed: () => cameraController.switchCamera(),
          ),
        ],
      ),
      body: MobileScanner(
        // fit: BoxFit.contain,
        onDetect: (capture) {
          final List<Barcode> barcodes = capture.barcodes;
          //final Uint8List? image = capture.image;
          for (final barcode in barcodes) {
            debugPrint('Barcode found! ${barcode.rawValue}');
            _foundBarcode(barcode, context);
          }
        },
      ),
    );
  }

  void _foundBarcode(Barcode barcode, BuildContext context) {
    ///open screen
    if (!_screenOpened) {
      final String code = barcode.rawValue ?? "---";
      debugPrint('Barcode found! $code');
      _screenOpened = true;
      Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) =>
                FoundCodeScreen(screemClosed: _screenWasClosed, value: code),
          ));
    }
  }

  void _screenWasClosed() {
    _screenOpened = false;
  }
}

class FoundCodeScreen extends StatefulWidget {
  final String value;
  final Function() screemClosed;
  const FoundCodeScreen({
    Key? key,
    required this.value,
    required this.screemClosed,
  }) : super(key: key);

  @override
  State<FoundCodeScreen> createState() => _FoundCodeScreen();
}

class _FoundCodeScreen extends State<FoundCodeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Found Code'),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            //widget._screenClosed();
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_outlined,
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "scanned Code:",
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              widget.value,
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
