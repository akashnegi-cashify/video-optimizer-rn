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

  DataWipeDetailProvider(this._deviceBarcode);

  static DataWipeDetailProvider of(BuildContext context, {bool listen = true}) {
    return Provider.of<DataWipeDetailProvider>(context, listen: listen);
  }

  Future<void> getDeviceWipeStatus() {
    var completer = Completer<void>();
    DataWipeService.getDataWipeDetails(_deviceBarcode).listen((event) {
      isLoading = false;
      data = event.dataWipeDetail;
      notifyListeners();
      completer.complete();
    }, onError: (error) {
      isLoading = false;
      String? errorMessage = ApiErrorHelper.getErrorMessage(error);
      completer.completeError(errorMessage.toString());
    });
    return completer.future;
  }
}
