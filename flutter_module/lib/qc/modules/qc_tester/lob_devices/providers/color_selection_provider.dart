import 'package:core/core.dart';
import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/qc/modules/qc_tester/calculator/resources/calculator_service.dart';
import 'package:provider/provider.dart';

class ColorSelectionProvider extends CalculatorServiceInitProvider {
  final int? _productId;
  List<String>? deviceColors;

  /*
  Strap color has 3 conditions, null, empty and not empty-
  null means - Category is not smart watch, so we can proceed
  empty means - Category is smart watch but strap color not available, need to block user to proceed
  not empty means - Category is smart watch and strap color available
   */
  List<String>? strapColors;
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
        strapColors = event.strapColorList;
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
