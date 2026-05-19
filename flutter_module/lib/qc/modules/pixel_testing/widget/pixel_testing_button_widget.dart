import 'package:core/core.dart';
import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/qc/modules/pixel_testing/screens/pixel_testing_screen.dart';
import 'package:flutter_trc/qc/modules/qc_tester/calculator/models/calculator_data_holder_model.dart';
import 'package:flutter_trc/qc/modules/qc_tester/calculator/resources/qc_calculator_service.dart';
import 'package:flutter_trc/src/common/utils/csh_ml_scanner_util.dart';

import '../l10n.dart';

class PixelTestingButtonWidget extends StatelessWidget {
  const PixelTestingButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var l10n = L10n(context);
    return CshBigButton(
      text: l10n.pixelTesting,
      onPressed: () {
        CshMlScannerUtil().openScanner(
          context,
          onScanned: (scannedData, controller) {
            if (!Validator.isNullOrEmpty(scannedData)) {
              _getCalculator(context, scannedData);
            }
          },
        );
      },
    );
  }

  _getCalculator(BuildContext context, String deviceBarcode) {
    CshLoading().showLoading(context);
    QcCalculatorService().getPixelCalculator(deviceBarcode).listen((event) {
      CshLoading().hideLoading(context);
      Navigator.pop(context); // pop scanner screen
      CalculatorDataHolderModel().startCalculatorJourney(event, deviceBarcode);
      PixelTestingScreen.navigate(context, deviceBarcode);
    }, onError: (error) {
      CshLoading().hideLoading(context);
      var errorMessage = ApiErrorHelper.getErrorMessage(error).toString();
      CshSnackBar.error(context: context, message: errorMessage);
    });
  }
}
