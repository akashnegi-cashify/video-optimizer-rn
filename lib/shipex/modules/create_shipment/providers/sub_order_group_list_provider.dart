import 'dart:async';

import 'package:core/core.dart';
import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/suborder_group_list_response.dart';
import '../resources/create_shipment_service.dart';

class SubOrderGroupListProvider extends CshChangeNotifier {
  static SubOrderGroupListProvider of(BuildContext context, {bool listen = true}) {
    return Provider.of<SubOrderGroupListProvider>(context, listen: listen);
  }

  Future<SubOrderGroupListResponse> getSubOrderGroupDataList(int pageSize, int pageNumber,
      {int shipmentStatus = 0, String? query}) {
    var completer = Completer<SubOrderGroupListResponse>();
    try {
      CreateShipmentService.getSubOrderGroupList(pageSize, pageNumber, shipmentStatus: shipmentStatus, query: query)
          .listen((event) {
        if (event != null && !Validator.isListNullOrEmpty(event.subOrderList)) {
          completer.complete(event);
        } else if (Validator.isListNullOrEmpty(event?.subOrderList)) {
          completer.completeError("No Data Found!!");
        }
      }, onError: (error) {
        String em = ApiErrorHelper.getErrorMessage(error) ?? "Something went wrong";
        Logger.debug('mydebug------SubOrderGroupListProvider.getSubOrderGroupDataList', [em]);
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
