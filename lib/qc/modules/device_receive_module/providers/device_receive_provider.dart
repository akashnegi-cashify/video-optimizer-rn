import 'dart:async';

import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/device_receive_response.dart';
import '../resources/device_receive_service.dart';

class DeviceReceiveProvider extends CshChangeNotifier {
  static DeviceReceiveProvider of(BuildContext context, {bool listen = true}) {
    return Provider.of<DeviceReceiveProvider>(context, listen: listen);
  }

  Future<DeviceReceiveData> onDeviceScanned(String barcode) async {
    var completer = Completer<DeviceReceiveData>();

    DeviceReceiveService.receiveDevice(barcode).listen((event) {
      if (event?.data != null) {
        completer.complete(event!.data);
      } else {
        completer.completeError(event?.errorMsg.toString() ?? "");
      }
    }, onError: (error) {
      var message = ApiErrorHelper.getErrorMessage(error);
      completer.completeError(message.toString());
    });

    return completer.future;
  }
}
