import 'dart:async';

import 'package:core/core.dart';
import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/qc/modules/qc_tester/calculator/resources/calculator_service.dart';
import 'package:provider/provider.dart';

class ColorSelectionProvider extends CalculatorServiceInitProvider {
  final int? _productId;

  static ColorSelectionProvider of(BuildContext context, {bool listen = true}) {
    return Provider.of<ColorSelectionProvider>(context, listen: listen);
  }

  ColorSelectionProvider(this._productId);

  Future<List<String>?> getDeviceColors() {
    var completer = Completer<List<String>?>();
    service.getDeviceColors(_productId).listen((event) {
      if (!Validator.isListNullOrEmpty(event?.deviceColorList)) {
        completer.complete(event!.deviceColorList);
      } else {
        completer.completeError("Colour not found, please contact service desk");
      }
    }, onError: (error) {
      completer.completeError(ApiErrorHelper.getErrorMessage(error).toString());
    });
    return completer.future;
  }
}
