import 'package:core/core.dart';
import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/modules/inventory_manager/resources/inventory_manager_service.dart';
import 'package:provider/provider.dart';

import '../models/assigned_device_details.dart';
import '../models/device_alloted_parts_response.dart';

class AssignedDeviceDetailsProvider extends CshChangeNotifier {
  static AssignedDeviceDetailsProvider of(BuildContext context, {bool listen = true}) {
    return Provider.of<AssignedDeviceDetailsProvider>(context, listen: listen);
  }

  int? did;
  AssignedDeviceDetails? assignedDeviceDetails;
  bool isDataLoading = true;
  String errMessage = "";
  DeviceAllottedPartsResponse? deviceAllottedPartsResponse;
  bool isListDataLoading = true;
  String listErrorMessage = "";

  AssignedDeviceDetailsProvider(this.did) {
    _getDeviceDetailsData();
    _getAllottedPartsList();
  }

  _getDeviceDetailsData() {
    InventoryService.getAssignedItemDeviceDetails(did!).listen((event) {
      if (event != null) {
        assignedDeviceDetails = event;
      }
    }, onError: (error) {
      String em = ApiErrorHelper.getErrorMessage(error) ?? "Something went wrong";
      Logger.debug('mydebug------AssignedDeviceDetailsProvider._getDeviceDetailsData', [em]);
      errMessage = em;
    }, onDone: () {
      isDataLoading = false;
      notifyListeners();
    });
  }

  _getAllottedPartsList() {
    InventoryService.getDeviceAllottedList(did!).listen((event) {
      if (event != null) {
        deviceAllottedPartsResponse = event;
      }
    }, onError: (error) {
      String em = ApiErrorHelper.getErrorMessage(error) ?? "Something went wrong";
      Logger.debug('mydebug------AssignedDeviceDetailsProvider._getAllottedPartsList', [em]);
      listErrorMessage = em;
    }, onDone: () {
      isListDataLoading = false;
      notifyListeners();
    });
  }

  refreshDataOnPage() {
    isDataLoading = true;
    isListDataLoading = true;
    notifyListeners();
    _getDeviceDetailsData();
    _getAllottedPartsList();
  }
}
