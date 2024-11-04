import 'dart:async';

import 'package:core/core.dart';
import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/common/mpin/mpin_controller.dart';
import 'package:flutter_trc/src/common/mpin/mpin_service.dart';
import 'package:flutter_trc/src/common/mpin/mpin_validation_state.dart';
import 'package:flutter_trc/src/libraries/shared_prefrences/app_prefrences.dart';
import 'package:provider/provider.dart';

class MPinSetupProvider extends CshChangeNotifier {
  MPinValidationState consecutiveState = MPinValidationState.idle;
  MPinValidationState repetitive = MPinValidationState.idle;
  String? _mPin;
  String? _confirmMPin;

  static MPinSetupProvider of(BuildContext context, {bool listen = true}) {
    return Provider.of<MPinSetupProvider>(context, listen: listen);
  }

  onMPinChanged(String mPin) {
    _mPin = mPin;
    consecutiveState = MPinController.isConsecutive(mPin) ? MPinValidationState.error : MPinValidationState.success;
    repetitive = MPinController.isRepetitive(mPin) ? MPinValidationState.error : MPinValidationState.success;
    notifyListeners();
  }

  void onConfirmPinChanged(String mPin) {
    _confirmMPin = mPin;
  }

  bool isEnableSubmitButton() {
    return (consecutiveState == MPinValidationState.success && repetitive == MPinValidationState.success) &&
        !Validator.isNullOrEmpty(_confirmMPin);
  }

  Future<void> onSubmit() {
    if (_mPin != _confirmMPin) {
      return Future.error("Your MPIN don't match. Make sure to enter the correct one.");
    }

    var completer = Completer<void>();
    MPinService.submitMPin(_confirmMPin).listen((event) {
      AppPreferences().setQcMPin(_confirmMPin!);
      completer.complete();
    }, onError: (error) {
      completer.completeError(ApiErrorHelper.getErrorMessage(error).toString());
    });
    return completer.future;
  }
}
