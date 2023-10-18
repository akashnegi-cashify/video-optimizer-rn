import 'dart:async';

import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/qc/modules/gaurd/models/collected_order_list_response.dart';
import 'package:flutter_trc/qc/modules/gaurd/resources/guard_service.dart';
import 'package:provider/provider.dart';

class GuardDeviceCountingListProvider extends CshChangeNotifier {
  List<String>? deliveryAgentList;

  static GuardDeviceCountingListProvider of(BuildContext context, {bool listen = true}) {
    return Provider.of<GuardDeviceCountingListProvider>(context, listen: listen);
  }

  Future<List<CollectedOrderListData>?> getCollectedOrdersList() {
    var completer = Completer<List<CollectedOrderListData>?>();
    GuardService.getCollectedOrderList().listen((event) {
      deliveryAgentList = event?.deliveryAgentList;
      completer.complete(event?.collectedOrderList);
    }, onError: (e) {
      completer.completeError(ApiErrorHelper.getErrorMessage(e).toString());
    });
    return completer.future;
  }
}
