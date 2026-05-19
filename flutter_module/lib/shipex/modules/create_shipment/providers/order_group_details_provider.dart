import 'package:core/core.dart';
import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/suborder_group_detail_response.dart';
import '../resources/create_shipment_service.dart';

class OrderGroupDetailsProvider extends CshChangeNotifier {
  bool isDataLoading = true;
  String? errorMessage;
  SubOrderGroupDetailResponse? responseData;

  static OrderGroupDetailsProvider of(BuildContext context, {bool listen = true}) {
    return Provider.of<OrderGroupDetailsProvider>(context, listen: listen);
  }

  OrderGroupDetailsProvider(String groupId) {
    _fetchGroupOrderDetails(groupId);
  }

  _fetchGroupOrderDetails(String groupId) {
    CreateShipmentService.getSubOrderGroupDetails(groupId).listen((event) {
      if (event != null) {
        responseData = event;
      }
    }, onError: (error) {
      String em = ApiErrorHelper.getErrorMessage(error) ?? "Something went wrong";
      Logger.debug('mydebug------OrderGroupDetailsProvider._fetchGroupOrderDetails', [em]);
      errorMessage = em;
    }, onDone: () {
      isDataLoading = false;
      notifyListeners();
    });
  }
}
