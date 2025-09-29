import 'dart:async';

import 'package:core/core.dart';
import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/modules/inventory_manager/resources/inventory_manager_service.dart';
import 'package:flutter_trc/src/modules/inventory_manager/resources/part_status_enum.dart';
import 'package:provider/provider.dart';

import '../models/part_available_quantity_response.dart';
import '../models/parts_details_response.dart';
import '../models/recommended_part_response.dart';

class PendingPartDetailsProvider extends CshChangeNotifier {
  static PendingPartDetailsProvider of(BuildContext context, {bool listen = true}) {
    return Provider.of<PendingPartDetailsProvider>(context, listen: listen);
  }

  int? prid, statusCode;
  PartsDetailsResponse? partsDetailsResponse;
  bool isDataLoading = true;
  PartAvailableQuantityResponse? availableQuantityResponse;
  String errorMessage = "";
  List<RecommendedPartData>? recommendedPartList;
  bool showBottomButtons = true;

  PendingPartDetailsProvider(this.prid, this.statusCode) {
    _fetchPartsDetailsData();
    if (PartStatus.getEnumByValue(statusCode!) == PartStatus.AVAILABLE) {
      showBottomButtons = false;
      _getRecommendedPartList();
    }
  }

  _fetchPartsDetailsData() {
    InventoryService.getPendingPartDetails(prid!).listen((event) {
      if (event != null) {
        partsDetailsResponse = event;
        availableQuantityResponse = null;
      }
    }, onError: (error) {
      String errMessage = ApiErrorHelper.getErrorMessage(error) ?? "Something went Wrong";
      errorMessage = errorMessage;
      Logger.debug('mydebug------PendingPartDetailsProvider._fetchPartsDetailsData', [errMessage]);
    }, onDone: () {
      isDataLoading = false;
      notifyListeners();
    });
  }

  syncData() {
    isDataLoading = true;
    notifyListeners();
    _fetchPartsDetailsData();
  }

  syncPartRequest() {
    InventoryService.syncPartRequest(prid).listen((event) {
      Logger.debug('mydebug-----PendingPartDetailsProvider._syncPartRequest', [event]);
    }, onError: (error) {
      Logger.debug(
          'mydebug---error--PendingPartDetailsProvider._syncPartRequest', [ApiErrorHelper.getErrorMessage(error)]);
    }, onDone: () {
      syncData();
    });
  }

  Future<bool> fetchAvailableQuantity(int prid) {
    var completer = Completer<bool>();
    try {
      InventoryService.getPartAvailableQuantity(prid).listen((event) {
        if (event != null && event.isSuccess == true) {
          availableQuantityResponse = event;
          completer.complete(true);
        } else {
          completer.completeError("Something went Wrong");
        }
      }, onError: (error) {
        String errMessage = ApiErrorHelper.getErrorMessage(error) ?? "Something went wrong!!";
        Logger.debug('mydebug------PendingPartDetailsProvider.fetchAvailableQuantity', [errMessage]);
        completer.completeError(errMessage);
      }, onDone: () {
        notifyListeners();
      });
    } catch (e) {
      completer.completeError(e.toString());
    }
    return completer.future;
  }

  _getRecommendedPartList() {
    InventoryService.doRecommendedApiCall(prid!).listen(
      (event) {
        if (!Validator.isListNullOrEmpty(event?.dataList)) {
          recommendedPartList = event?.dataList;
        }
      },
      onError: (error) {
        String errMessage = ApiErrorHelper.getErrorMessage(error) ?? "Something went wrong";
        Logger.debug('mydebug------PendingPartDetailsProvider._getDoRecommendedPartApi', [errMessage]);
      },
      onDone: () {
        showBottomButtons = true;
        notifyListeners();
      },
    );
  }

  Future<bool> cancelPartItem(int prid) {
    var completer = Completer<bool>();
    try {
      InventoryService.cancelPartRequest(prid).listen((event) {
        if (event != null && event.isSuccess == true) {
          completer.complete(true);
          _fetchPartsDetailsData();
        } else {
          completer.completeError("Something went wrong");
        }
      }, onError: (error) {
        String errMessage = ApiErrorHelper.getErrorMessage(error) ?? "Something went wrong";
        Logger.debug('mydebug------PendingPartDetailsProvider.cancelPartItem', [errMessage]);
        completer.completeError(errMessage);
      }, onDone: () {
        notifyListeners();
      });
    } catch (e) {
      completer.completeError(e.toString());
    }
    return completer.future;
  }

  Future<bool> linkDeadPart(int prid) {
    var completer = Completer<bool>();
    try {
      InventoryService.linkDeadPart(prid).listen((event) {
        if (event != null && event.isSuccess == true) {
          completer.complete(true);
        } else {
          completer.completeError("Something went wrong");
        }
      }, onError: (error) {
        String er = ApiErrorHelper.getErrorMessage(error) ?? "Something went wrong";
        Logger.debug('mydebug------PendingPartDetailsProvider.linkDeadPart', [er]);
        completer.completeError(er);
      }, onDone: () {
        notifyListeners();
      });
    } catch (e) {
      completer.completeError(e.toString());
    }
    return completer.future;
  }
}
