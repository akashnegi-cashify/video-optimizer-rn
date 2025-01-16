import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/qc/modules/qc_tester/calculator/models/calculator_data_holder_model.dart';
import 'package:flutter_trc/qc/modules/qc_tester/calculator/providers/calculator_scanner_provider.dart';
import 'package:flutter_trc/qc/modules/qc_tester/calculator/screens/calculation_screen.dart';
import 'package:flutter_trc/qc/modules/qc_tester/lob_devices/screens/color_selection_screen.dart';
import 'package:flutter_trc/src/common/widgets/trc_scanner_widget.dart';
import 'package:ml_barcode_scanner/widgets/ml_barcode_scanner_widget.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
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
        scanFormatList: _isDeviceBarcodeScanned ? [BarcodeFormat.qrCode] : [BarcodeFormat.code128],
        onScanDetected: (scannedData, controller, {isManualEntry}) {
          if (!_isDeviceBarcodeScanned) {
            _onDeviceBarcodeScanned(scannedData);
          } else {
            var provider = CalculatorScannerProvider.of(builderContext, listen: false);
            _onPQuoteScanned(scannedData, provider, controller);
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

  void _onPQuoteScanned(String scannedData, CalculatorScannerProvider provider, MlScannerController? controller) {
    _pQuote = scannedData;
    controller?.stop();
    CshLoading().showLoading(context);
    provider.getCalculatorRequest(_pQuote, _deviceBarcode).then((value) {
      if (mounted) {
        CshLoading().hideLoading(context);
        CalculatorDataHolderModel().startCalculatorJourney(value, _deviceBarcode);

        ColorSelectionScreen.navigateTo(context, value.productId, _deviceBarcode, (color) {
          Navigator.pop(context); // Dismiss color selection screen
          CalculatorDataHolderModel().setSelectedColor(color);
          Navigator.pushReplacementNamed(context, CalculationScreen.route);
        });
      }
    }, onError: (error) {
      if (mounted) {
        controller?.start();
        CshLoading().hideLoading(context);
        CshSnackBar.error(context: context, message: error);
      }
    });
  }
}
