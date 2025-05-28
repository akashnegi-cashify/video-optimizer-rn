import 'package:flutter/material.dart';
import 'package:flutter_trc/qc/modules/qc_tester/disputed_image_capture/screens/disputed_image_capture_barcode_scanner_screen.dart';
import 'package:flutter_trc/src/common/widgets/trc_scanner_widget.dart';
import 'package:ml_barcode_scanner/widgets/ml_barcode_scanner_widget.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

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
    List<BarcodeFormat>? scanFormatList,
    Widget? bottomView,
    VoidCallback? onDidPop,
    Function(ResetLastScannedBarcode resetController)? resetController,
  }) {
    DisputedImageCaptureBarcodeScannerArguments args = DisputedImageCaptureBarcodeScannerArguments(
      header: header,
      hintText: hintText,
      scanFormatList: scanFormatList,
      bottomView: bottomView,
      resetController: resetController,
      onScanDetected: (String scannedData, MlScannerController? controller, {isManualEntry}) {
        if (scannedData.isNotEmpty) {
          onScanned(scannedData, controller);
        }
      },
    );
    Navigator.of(context)
        .pushNamed(DisputedImageCaptureBarcodeScanner.route, arguments: args)
        .whenComplete(() => onDidPop?.call());
  }
}
