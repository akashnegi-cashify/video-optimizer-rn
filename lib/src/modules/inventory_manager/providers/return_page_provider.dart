import 'dart:async';

import 'package:core/core.dart';
import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/modules/inventory_manager/resources/inventory_manager_service.dart';
import 'package:provider/provider.dart';

import '../models/list_receive_pending_part_response.dart';
import '../models/return_part_response.dart';

class ReturnProvider extends CshChangeNotifier {
  static ReturnProvider of(BuildContext context, {bool listen = true}) {
    return Provider.of<ReturnProvider>(context, listen: listen);
  }

  int offset = 10;
  String? barcode;
  ListReceivePendingPartResponse? listReceivePendingPartResponse;

  Future<ReturnPartResponse> fetchInventoryReturnPartList(int pageNum, {String? br}) {
    var completer = Completer<ReturnPartResponse>();
    try {
      InventoryService.inventoryReturnPartList(pageNum, offset, br: br).listen((event) {
        if (event != null && event.isSuccess == true) {
          completer.complete(event);
        } else {
          completer.completeError("Something went wrong");
        }
      }, onError: (error) {
        String er = ApiErrorHelper.getErrorMessage(error) ?? "Something went wrong";
        Logger.debug('mydebug------ReturnProvider.fetchInventoryReturnPartList', [er]);
        completer.completeError(er);
      }, onDone: () {
        notifyListeners();
      });
    } catch (e) {
      completer.completeError(e.toString());
    }
    return completer.future;
  }

  Future<bool> getListReceivePendingPart(String pbr) {
    var completer = Completer<bool>();
    try {
      InventoryService.getListReceivePendingPartList(pbr).listen((event) {
        if (event != null && event.isSuccess == true && !Validator.isListNullOrEmpty(event.dataList)) {
          listReceivePendingPartResponse = event;
          _putItemIntoReceivedList(event.dataList!.first.prid ?? -1);
          completer.complete(true);
        } else if (event != null && event.isSuccess == true && Validator.isListNullOrEmpty(event.dataList)) {
          completer.completeError("No Parts Available!!");
        } else {
          completer.completeError("Something went wrong");
        }
      }, onError: (error) {
        String em = ApiErrorHelper.getErrorMessage(error) ?? "Something went wrong";
        Logger.debug('mydebug------ReturnProvider.getListReceivePendingPart', [em]);
        completer.completeError(em);
      }, onDone: () {
        notifyListeners();
      });
    } catch (e) {
      completer.completeError(e.toString());
    }

    return completer.future;
  }

  _putItemIntoReceivedList(int prid) {
    InventoryService.addItemIntoReceiveList(prid).listen((event) {
      if (event != null) {
        Logger.debug('mydebug------ReturnProvider._putItemIntoReceivedList', ["Data Added"]);
      }
    }, onError: (error) {
      String er = ApiErrorHelper.getErrorMessage(error) ?? "Something went wrong";
      Logger.debug('mydebug------ReturnProvider._putItemIntoReceivedList', [er]);
    }, onDone: () {
      notifyListeners();
    });
  }
}
