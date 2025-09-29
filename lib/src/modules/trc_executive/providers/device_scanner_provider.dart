import 'dart:async';

import 'package:core/core.dart';
import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/modules/trc_executive/models/device_receive_response.dart';
import 'package:flutter_trc/src/modules/trc_executive/models/tl_list_response.dart';
import 'package:flutter_trc/src/modules/trc_executive/resources/device_scanner_service.dart';
import 'package:provider/provider.dart';

class DeviceScannerProvider extends CshChangeNotifier {
  TlListData? tlData;

  static DeviceScannerProvider of(BuildContext context, {bool listen = true}) {
    return Provider.of<DeviceScannerProvider>(context, listen: listen);
  }

  DeviceScannerProvider({this.tlData});

  Future<DeviceReceiveData> onDeviceScanned(String barcode) {
    var completer = Completer<DeviceReceiveData>();
    DeviceScannerService.receiveDevice(barcode, tlData!.id!).listen((event) {
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
