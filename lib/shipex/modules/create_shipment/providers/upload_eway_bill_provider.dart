import 'dart:async';

import 'package:core/core.dart';
import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../resources/create_shipment_service.dart';

class UploadEwayBillProvider extends CshChangeNotifier {
  static UploadEwayBillProvider of(BuildContext context, {bool listen = true}) {
    return Provider.of<UploadEwayBillProvider>(context, listen: listen);
  }

  Future<bool> uploadEwayBill(String awbNumber, String s3Url, int facilityId, String shipmentId) {
    var completer = Completer<bool>();
    try {
      CreateShipmentService.uploadEWayBill(
              facilityId: facilityId.toString(), shipmentId: shipmentId, eWayBillNumber: awbNumber, fileUrl: s3Url)
          .listen((event) {
        completer.complete(true);
      }, onError: (error) {
        String em = ApiErrorHelper.getErrorMessage(error) ?? "Something went wrong";
        Logger.debug('mydebug------UploadEwayBillProvider.uploadEwayBill', [em]);
        completer.completeError(em);
      }, onDone: () {
        notifyListeners();
      });
    } catch (e) {
      completer.completeError(e.toString());
    }
    return completer.future;
  }
}
