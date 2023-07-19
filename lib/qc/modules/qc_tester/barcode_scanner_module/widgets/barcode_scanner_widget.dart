import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:ml_barcode_scanner/widgets/ml_barcode_scanner_widget.dart';

import 'barcode_field_widget.dart';

class BarcodeScannerWidget extends StatefulWidget {
  const BarcodeScannerWidget({Key? key}) : super(key: key);

  @override
  State<BarcodeScannerWidget> createState() => _BarcodeScannerWidgetState();
}

class _BarcodeScannerWidgetState extends State<BarcodeScannerWidget> {
  final GlobalKey<BarcodeFieldWidgetState> _barcodeFieldWidgetKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: MlBarcodeScannerWidget(
            onScannerDetected: (String value, MlScannerController controller) {
              if (mounted && !Validator.isNullOrEmpty(value)) {
                _barcodeFieldWidgetKey.currentState?.setScannedBarcodeData(value.trim());
              }
            },
          ),
        ),
        BarcodeFieldWidget(
          key: _barcodeFieldWidgetKey,
        ),
      ],
    );
  }
}
