import 'dart:async';

import 'package:core/core.dart';
import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../resources/index.dart';

class DeadDeviceProvider extends CshChangeNotifier {
  int? roleType;

  DeadDeviceProvider({this.roleType});

  static DeadDeviceProvider of(BuildContext context, {bool listen = true}) {
    return Provider.of<DeadDeviceProvider>(context, listen: listen);
  }

  Future<List<String>> fetchReasonList() {
    var completer = Completer<List<String>>();
    DeviceDeadRepairServices.fetchReasonList().listen((event) {
      if (event?.isValid() == true) {
        completer.complete(ArrayUtil.removeNullItems(event?.data ?? []));
      } else {
        completer.completeError(event?.message ?? "Something Went Wrong.");
      }
      notifyListeners();
    }, onError: (error, stackTrace) {
      var errorMsg = ApiErrorHelper.getErrorMessage(error) ?? "Something Went Wrong.";
      completer.completeError(errorMsg);
      Logger.debug('DeadDeviceProvider._fetchReasonList', [errorMsg]);
      notifyListeners();
    });

    return completer.future;
  }

  Future<DeadMarkUpdateResponse> fetchScanDeviceDetail(String scanValue) {
    var completer = Completer<DeadMarkUpdateResponse>();
    DeviceDeadRepairServices.getScanDeviceDetail(scanValue).listen((event) {
      completer.complete(event);
      notifyListeners();
    }, onError: (error, stackTrace) {
      var errorMsg = ApiErrorHelper.getErrorMessage(error) ?? "Something Went Wrong.";
      completer.completeError(errorMsg);
      Logger.debug('DeadDeviceProvider._fetchReasonList', [errorMsg]);
      notifyListeners();
    });

    return completer.future;
  }
}
