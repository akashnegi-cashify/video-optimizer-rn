import 'package:core/core.dart';
import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/qc/modules/qc_tester/calculator/resources/calculator_service.dart';
import 'package:provider/provider.dart';

class ColorSelectionProvider extends CalculatorServiceInitProvider {
  final int? _productId;
  List<String>? deviceColors;
  String? screenError;
  bool isLoading = true;

  static ColorSelectionProvider of(BuildContext context, {bool listen = true}) {
    return Provider.of<ColorSelectionProvider>(context, listen: listen);
  }

  ColorSelectionProvider(this._productId) : super() {
    _getDeviceColors();
  }

  void _getDeviceColors() {
    service.getDeviceColors(_productId).listen((event) {
      if (!Validator.isListNullOrEmpty(event?.deviceColorList)) {
        deviceColors = event!.deviceColorList;
        screenError = null;
      } else {
        screenError = "Colour not found, please contact service desk";
      }
    }, onError: (error) {
      screenError = ApiErrorHelper.getErrorMessage(error).toString();
    }, onDone: () {
      isLoading = false;
      notifyListeners();
    });
  }
}
