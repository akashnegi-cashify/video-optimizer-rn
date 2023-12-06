import 'package:flutter/material.dart';
import 'package:flutter_trc/qc/modules/qc_tester/disputed_image_capture/screens/disputed_image_capture_barcode_scanner_screen.dart';
import 'package:ml_barcode_scanner/resources/scan_formats.dart';
import 'package:ml_barcode_scanner/widgets/ml_barcode_scanner_widget.dart';

class CshMlScannerUtil {
  // create factory methods
  CshMlScannerUtil._private();

  static final CshMlScannerUtil _instance = CshMlScannerUtil._private();

  factory CshMlScannerUtil() {
    return _instance;
  }

  openScanner(
    BuildContext context, {
    required Function(String scannedData, MlScannerController? controller) onScanned,
    String header = "Scan Barcode",
    String hintText = "Scan Barcode",
    List<ScanFormats>? scanFormatList,
  }) {
    DisputedImageCaptureBarcodeScannerArguments args = DisputedImageCaptureBarcodeScannerArguments(
        onScanDetected: (String scannedData, MlScannerController? controller) {
          if (scannedData.isNotEmpty) {
            onScanned(scannedData, controller);
          }
        },
        header: header,
        hintText: hintText,
        scanFormatList: scanFormatList);
    Navigator.of(context).pushNamed(DisputedImageCaptureBarcodeScanner.route, arguments: args);
  }
}
