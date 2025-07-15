import 'package:fieldbook/app_widgets.dart';
import 'package:fieldbook/com/fieldbook/tracker/pigeon/navigation_api.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class ScannerActivity extends StatefulWidget {
  const ScannerActivity({Key? key}) : super(key: key);

  @override
  State<ScannerActivity> createState() => _ScannerActivityState();
}

class _ScannerActivityState extends State<ScannerActivity> {
  bool _scanned = false;

  void _onDetect(BarcodeCapture capture) async {
    if (_scanned) return;
    final barcode = capture.barcodes.firstOrNull?.rawValue;
    if (barcode != null) {
      setState(() => _scanned = true);
      await NavigationApi().onNavigatorPop(barcode);
      SystemNavigator.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          MobileScanner(
            onDetect: _onDetect,
          ),
          if (_scanned)
            const Center(child: CircularProgressIndicator()),
        ],
      ),
    );
  }
}
