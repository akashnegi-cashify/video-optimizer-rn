import 'dart:async';

import 'package:core/core.dart';
import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/pending_device_list_response.dart';
import '../resources/inventory_manager_service.dart';

class PendingDeliveryProvider extends CshChangeNotifier {
  static PendingDeliveryProvider of(BuildContext context, {bool listen = true}) {
    return Provider.of<PendingDeliveryProvider>(context, listen: listen);
  }

  int offsetLength = 10;
  int? eid;
  bool isUrgent = false;
  String barcode = "";

  PendingDeliveryProvider(this.eid);

  Future<PendingDeviceListResponse> getPendingDeviceList(int pageNo) {
    var completer = Completer<PendingDeviceListResponse>();
    try {
      InventoryService.getPendingDeviceList(eid!, pageNo, offsetLength, isUrgent: isUrgent, enteredOrScannedBr: barcode)
          .listen((event) {
        if (event != null && event.isSuccess == true) {
          completer.complete(event);
        } else {
          completer.completeError("Something Went Wrong!!");
        }
      }, onError: (error) {
        String errMessage = ApiErrorHelper.getErrorMessage(error) ?? "Something Went Wrong";
        Logger.debug('mydebug------PendingDeliveryProvider.getPendingDeviceList', [errMessage]);
        completer.completeError(errMessage);
      }, onDone: () {
        notifyListeners();
      });
    } catch (e) {
      completer.completeError(e.toString());
    }
    return completer.future;
  }
}
