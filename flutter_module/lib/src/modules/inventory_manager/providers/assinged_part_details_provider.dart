import 'dart:async';

import 'package:core/core.dart';
import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/assigned_part_details_response.dart';
import '../models/part_available_quantity_response.dart';
import '../resources/inventory_manager_service.dart';

class AssignedPartDetailsProvider extends CshChangeNotifier {
  static AssignedPartDetailsProvider of(BuildContext context, {bool listen = true}) {
    return Provider.of<AssignedPartDetailsProvider>(context, listen: listen);
  }

  int? prid;
  bool isDataLoading = false;
  String errorMessage = "";
  AssignedPartsDetails? assignedPartsDetails;
  PartAvailableQuantityResponse? partAvailableQuantityResponse;

  AssignedPartDetailsProvider(this.prid) {
    _fetchDetailsData();
  }

  _fetchDetailsData() {
    InventoryService.getAssignedPartDetails(prid!).listen((event) {
      if (event != null) {
        assignedPartsDetails = event;
      }
    }, onError: (error) {
      String errMessage = ApiErrorHelper.getErrorMessage(error) ?? "Something went wrong";
      Logger.debug('mydebug------AssignedPartDetailsProvider._fetchDetailsData', [errMessage]);
      errorMessage = errMessage;
    }, onDone: () {
      isDataLoading = false;
      notifyListeners();
    });
  }

  Future<bool> getAssignedPartQuantity() {
    var completer = Completer<bool>();
    try {
      InventoryService.getAsssignedPartQuantity(prid!).listen((event) {
        if (event != null) {
          partAvailableQuantityResponse = event;
          completer.complete(true);
        } else {
          completer.completeError("Something went wrong");
        }
      }, onError: (error) {
        String em = ApiErrorHelper.getErrorMessage(error) ?? "Something went wrong";
        Logger.debug('mydebug------AssignedPartDetailsProvider.getAssingedPartQuantity', [em]);
        completer.completeError(em);
      }, onDone: () {
        notifyListeners();
      });
    } catch (e) {
      completer.completeError(e.toString());
    }
    return completer.future;
  }

  Future<bool> cancelAssignedPart() {
    var completer = Completer<bool>();
    try {
      InventoryService.cancelAssignedPart(prid!).listen((event) {
        if (event != null) {
          completer.complete(true);
        } else {
          completer.completeError("Something went wrong");
        }
      }, onError: (error) {
        String erMessage = ApiErrorHelper.getErrorMessage(error) ?? "Something went wrong";
        Logger.debug('mydebug------AssignedPartDetailsProvider.cancelAssginedPart', [erMessage]);
        completer.completeError(erMessage);
      }, onDone: () {
        notifyListeners();
      });
    } catch (e) {
      completer.completeError(e.toString());
    }

    return completer.future;
  }

  Future<bool> unlinkPartBarcode() {
    var completer = Completer<bool>();
    try {
      InventoryService.unlinkPartBarcode(prid!).listen((event) {
        if (event != null) {
          completer.complete(true);
        } else {
          completer.completeError("Something went wrong");
        }
      }, onError: (error) {
        String em = ApiErrorHelper.getErrorMessage(error) ?? "Something went wrong";
        Logger.debug('mydebug------AssignedPartDetailsProvider.unlinkPartBarcode', [em]);
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
