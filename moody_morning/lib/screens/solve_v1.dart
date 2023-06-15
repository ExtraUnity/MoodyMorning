import 'dart:math';
import 'dart:typed_data';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
//import 'package:moody_morning/widgets/logo_app_bar.dart';
import 'dart:collection';
import 'package:mobile_scanner/mobile_scanner.dart';

const bgColor = Color(0xFF423E72);

class MyHomePageState1 extends StatelessWidget {
  MobileScannerController cameraController = MobileScannerController();
  bool _screenOpened = false;

  // Flashlight 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        centerTitle: true,
        title: const Text("QR Scanner", 
                  style: TextStyle(
                    color: Colors.black87, 
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1,
                  ),
                ),
        actions: [
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
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Place the QR code in the area',
                  style: TextStyle(
                    color: Colors.white70, 
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1,
                  ),
                  ),
                  SizedBox(
                    height: 10,
                    ),
                  Text('Scanning will be started automatically', style: TextStyle(
                    fontSize: 16,
                    color: Colors.white60,
                  ),),
                ],
              )),
            Expanded(
              flex: 4,
              child: Center(
                child: Container(
                  height: 320,
                  width: 320,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(
                      color: Colors.blue,
                      width: 10
                    ),
                  ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: SizedBox(
                    height: 300,
                    width: 300,
                    child: Stack(
                      children: [
                        MobileScanner(
          // fit: BoxFit.contain,
            onDetect: (capture) {
              final List<Barcode> barcodes = capture.barcodes;
              for (final barcode in barcodes) {
                debugPrint('Barcode found! ${barcode.rawValue}');
               _foundBarcode(barcode, context);
             }
            },
           ),
                      ],
                    ),
                  ),
                ),)),),
            Expanded(
              child: Container(
                alignment: Alignment.center,
                child: const Text('MoodyMorning',
                  style: TextStyle(
                    color: Colors.white70, 
                    fontSize: 14,
                    letterSpacing: 1,
                  ),
                  ),)),


          ]),
      )
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
        title: const Text('Found Code'),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            //widget._screenClosed();
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_outlined,
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              "scanned Code:",
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              widget.value,
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
