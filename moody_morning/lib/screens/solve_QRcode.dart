import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:moody_morning/system/all_alarms.dart';
import 'package:moody_morning/widgets/logo_app_bar.dart';

const bgColor = Color(0xFF423E72);

class SolveQRCode extends StatelessWidget {
  final MobileScannerController cameraController = MobileScannerController();
  bool _screenOpened = false;

  SolveQRCode({super.key});

  // Flashlight
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
          backgroundColor: bgColor,
          appBar: LogoAppBar(),
          body: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            child: Column(children: [
              const Expanded(
                  child: SizedBox(
                    width: 380,
                    height: 75,
                    child: Card(
                       color: Color(0xFF8F8BBF),
                      child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.qr_code_2, color: Colors.white70, size: 40,),
                          SizedBox(width: 10,),
                          Text(
                            'Find a QR code and scan it',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Scanning will be started automatically',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white60,
                        ),
                      ),
                                    ],
                                  ),
                    ),
                  )),
              Expanded(
                flex: 4,
                child: Center(
                    child: Container(
                  height: 320,
                  width: 320,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(color: Color(0xFF8F8BBF), width: 10),
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
                                debugPrint(
                                    'Barcode found! ${barcode.rawValue}');
                                _foundBarcode(barcode, context);
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                )),
              ),
              Expanded(
                  child: Container(
                alignment: Alignment.center,
                child: const Text(
                  'MoodyMorning',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                    letterSpacing: 1,
                  ),
                ),
              )),
            ]),
          )),
    );
  }

  void _foundBarcode(Barcode barcode, BuildContext context) async {
    ///open screen
    if (!_screenOpened) {
      final String code = barcode.rawValue ?? "---";
      debugPrint('Barcode found! $code');
      _screenOpened = true;
      cameraController.stop();
      challengeSolved(context);
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
