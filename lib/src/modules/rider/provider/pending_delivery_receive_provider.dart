import 'dart:async';

import 'package:core/core.dart';
import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/modules/rider/resources/rider_service.dart';
import 'package:provider/provider.dart';

class PendingDeliveryReceiveProvider extends CshChangeNotifier {
  static PendingDeliveryReceiveProvider of(BuildContext context, {bool listen = true}) {
    return Provider.of<PendingDeliveryReceiveProvider>(context, listen: listen);
  }

  Future<void> onDeviceScanned(String barcode) async {
    var completer = Completer<void>();

    RiderService.receiveDevice(barcode).listen((event) {
      if (event != null) {
        completer.complete(event);
      } else {
        completer.completeError("No data found");
      }
    }, onError: (error) {
      var message = ApiErrorHelper.getErrorMessage(error);
      completer.completeError(message.toString());
    });

    return completer.future;
  }

}
