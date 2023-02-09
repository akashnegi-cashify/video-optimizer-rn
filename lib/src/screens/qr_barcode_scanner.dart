import 'dart:io';

import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QrBarcodeScanner extends StatefulWidget {
  final Function(String) onResultantCallback;

  const   QrBarcodeScanner({
    Key? key,
    required this.onResultantCallback,
  }) : super(key: key);

  @override
  State<QrBarcodeScanner> createState() => _QrBarcodeScannerState();
}

class _QrBarcodeScannerState extends State<QrBarcodeScanner> {
  final GlobalKey _qrKey = GlobalKey(debugLabel: "qr");
  QRViewController? _controller;

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      _controller!.pauseCamera();
    } else if (Platform.isIOS) {
      _controller!.resumeCamera();
    }
  }

  @override
  Widget build(BuildContext context) {
    return QRView(
      key: _qrKey,
      onQRViewCreated: (QRViewController controller) {
        setState(() {
          _controller = controller;
        });

        _controller?.scannedDataStream.listen(
          (scanData) async {
            if (mounted && !Validator.isNullOrEmpty(scanData.code)) {
              widget.onResultantCallback(scanData.code!);
              _controller?.dispose();
            }
          },
        );
      },
      overlay: QrScannerOverlayShape(borderRadius: 12),
      formatsAllowed: const [
        BarcodeFormat.code39,
        BarcodeFormat.code128,
        BarcodeFormat.code93,
        BarcodeFormat.qrcode,
      ],
    );
  }
}
