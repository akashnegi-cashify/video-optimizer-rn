import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/qc/modules/qc_tester/calculator/models/calculator_data_holder_model.dart';
import 'package:flutter_trc/qc/modules/qc_tester/calculator/providers/calculator_scanner_provider.dart';
import 'package:flutter_trc/qc/modules/qc_tester/calculator/screens/calculation_screen.dart';
import 'package:flutter_trc/src/common/widgets/trc_scanner_widget.dart';
import 'package:ml_barcode_scanner/ml_barcode_scanner.dart';
import 'package:provider/provider.dart';

import '../l10n.dart';

class CalculatorScannerWidget extends StatefulWidget {
  const CalculatorScannerWidget({super.key});

  @override
  State<CalculatorScannerWidget> createState() => _CalculatorScannerWidgetState();
}

class _CalculatorScannerWidgetState extends State<CalculatorScannerWidget> {
  String? _deviceBarcode;
  String? _pQuote;
  bool _isDeviceBarcodeScanned = false;
  bool _isShowScannerTransitionWidget = false;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CalculatorScannerProvider(),
      lazy: false,
      builder: (builderContext, _) {
        return _getBuildWidget(builderContext);
      },
    );
  }

  Widget _getBuildWidget(BuildContext builderContext) {
    var l10n = L10n(context);
    if (_isShowScannerTransitionWidget) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircularProgressIndicator(),
            const SizedBox(height: Dimens.space_16),
            CshTextNew.subTitle1(l10n.startScanningCdpQrCode),
          ],
        ),
      );
    } else {
      String key = _isDeviceBarcodeScanned ? "pQoute" : "deviceBarcode";
      return TRCScannerWidget(
        key: ValueKey(key),
        hintText: _isDeviceBarcodeScanned ? l10n.scanCdpQrCode : l10n.scanDeviceBarcode,
        scanFormatList: _isDeviceBarcodeScanned ? [ScanFormats.qrCode] : [ScanFormats.barcode],
        onScanDetected: (scannedData, controller) {
          if (!_isDeviceBarcodeScanned) {
            _onDeviceBarcodeScanned(scannedData);
          } else {
            var provider = CalculatorScannerProvider.of(builderContext, listen: false);
            _onPQuoteScanned(scannedData, provider);
          }
        },
      );
    }
  }

  _onDeviceBarcodeScanned(String scannedData) {
    _deviceBarcode = scannedData;
    setState(() {
      _isShowScannerTransitionWidget = true;
    });
    Future.delayed(
      const Duration(milliseconds: 1000),
      () {
        setState(() {
          _isShowScannerTransitionWidget = false;
          _isDeviceBarcodeScanned = true;
        });
      },
    );
  }

  void _onPQuoteScanned(String scannedData, CalculatorScannerProvider provider) {
    _pQuote = scannedData;
    CshLoading().showLoading(context);
    provider.getCalculatorRequest(_pQuote, _deviceBarcode).then((value) {
      CshLoading().hideLoading(context);
      CalculatorDataHolderModel().startCalculatorJourney(value, _deviceBarcode);
      Navigator.pushReplacementNamed(context, CalculationScreen.route);
    }, onError: (error) {
      CshLoading().hideLoading(context);
      CshSnackBar.error(context: context, message: error);
    });
  }
}
