import 'dart:async';

import 'package:core/core.dart';
import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/qc/modules/data_wipe/resources/data_wipe_list_response.dart';
import 'package:flutter_trc/qc/modules/data_wipe/resources/data_wipe_service.dart';
import 'package:provider/provider.dart';

class DataWipeDetailProvider extends CshChangeNotifier {
  final String _deviceBarcode;
  DataWipeListItem? data;
  bool isLoading = true;
  bool forceHideInitiateButton = false;

  DataWipeDetailProvider(this._deviceBarcode);

  static DataWipeDetailProvider of(BuildContext context, {bool listen = true}) {
    return Provider.of<DataWipeDetailProvider>(context, listen: listen);
  }

  void getDeviceWipeStatus({Function(String errorMessage)? onError}) {
    DataWipeService.getDataWipeDetails(_deviceBarcode).listen((event) {
      data = event;
    }, onError: (error) {
      String? errorMessage = ApiErrorHelper.getErrorMessage(error);
      onError?.call(errorMessage.toString());
    }, onDone: () {
      isLoading = false;
      notifyListeners();
    });
  }

  Future<bool> initiateDataWipe() {
    var completer = Completer<bool>();
    DataWipeService.initiateDataWipe(data!.id!).listen((_) {
      getDeviceWipeStatus();
      forceHideInitiateButton = true;
      completer.complete(true);
    }, onError: (error) {
      String? errorMessage = ApiErrorHelper.getErrorMessage(error);
      completer.completeError(errorMessage.toString());
    });
    return completer.future;
  }
}
