import 'dart:async';

import 'package:core/core.dart';
import 'package:core_widgets/core_widgets.dart' hide ImageUtil;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/delivery_partner_list_response.dart';
import '../models/dispatch_awb_scan_response.dart';
import '../resources/dispatch_service.dart';

class ShipexDispatchProvider extends CshChangeNotifier {
  //Delivery Partner properties
  bool deliveryListLoading = false;
  String? deliveryListErrorMessage;
  List<DeliveryPartnerListData>? deliveryPartnerList;
  DeliveryPartnerListData? selectedDeliveryPartner;

  //AWB scanner properties
  List<String> scannedAwbList = [];

  static ShipexDispatchProvider of(BuildContext context, {bool listen = true}) {
    return Provider.of<ShipexDispatchProvider>(context, listen: listen);
  }

  fetchDeliveryPartnerListData() {
    deliveryListLoading = true;
    notifyListeners();
    DispatchService.getDeliveryPartnerList().listen((event) {
      if (!Validator.isListNullOrEmpty(event?.deliveryPartnerList)) {
        deliveryPartnerList = event!.deliveryPartnerList!;
      }
    }, onError: (error) {
      String em = ApiErrorHelper.getErrorMessage(error) ?? "Something went wrong";
      Logger.debug('mydebug------ShipexDispatchProvider.fetchDeliveryPartnerListData', [em]);
      deliveryListErrorMessage = em;
    }, onDone: () {
      deliveryListLoading = false;
      notifyListeners();
    });
  }

  onDeliveryPartnerChanged(DeliveryPartnerListData? partner) {
    selectedDeliveryPartner = partner;
    notifyListeners();
  }

  //Scan AWB number methods
  Future<DispatchAwbScanResponse> checkValidAWBNumber(String number) {
    var completer = Completer<DispatchAwbScanResponse>();
    try {
      DispatchService.validateAwbNumber(number, selectedDeliveryPartner?.key ?? "").listen((event) {
        if (event != null && Validator.isTrue(event.isValid)) {
          completer.complete(event);
          scannedAwbList.add(number);
        } else {
          completer.completeError("Shipment is not in a correct status for dispatch");
        }
      }, onError: (error) {
        String em = ApiErrorHelper.getErrorMessage(error) ?? "Something went wrong";
        Logger.debug('mydebug------ShipexDispatchProvider.checkValidAWBNumber', [em]);
        completer.completeError(em);
      }, onDone: () {
        notifyListeners();
      });
    } catch (e) {
      completer.completeError(e.toString());
    }
    return completer.future;
  }

  Future<void> partialDispatch() {
    var completer = Completer<void>();
    try {
      DispatchService.partialDispatch(scannedAwbList, selectedDeliveryPartner?.key).listen((event) {
        completer.complete();
      }, onError: (error) {
        completer.completeError(ApiErrorHelper.getErrorMessage(error).toString());
      });
    } catch (e) {
      completer.completeError(e.toString());
    }
    return completer.future;
  }
}
