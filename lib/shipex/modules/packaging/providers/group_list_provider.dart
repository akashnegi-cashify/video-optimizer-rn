import 'dart:async';

import 'package:core/core.dart';
import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/group_lot_list_repsonse.dart';
import '../resouces/packing_service.dart';

class GroupListProvider extends CshChangeNotifier {
  static GroupListProvider of(BuildContext context, {bool listen = true}) {
    return Provider.of<GroupListProvider>(context, listen: listen);
  }

  Future<List<GroupLotListData>?> fetchPendingDataList(int pageNo, {String? query}) {
    var completer = Completer<List<GroupLotListData>?>();
    try {
      PackingService.getGroupPendingDataList(pageNo, query: query).listen((event) {
        if (!Validator.isListNullOrEmpty(event?.groupLotList)) {
          completer.complete(event?.groupLotList);
        } else {
          completer.completeError("No data found...");
        }
      }, onError: (error) {
        String em = ApiErrorHelper.getErrorMessage(error) ?? "Something went wrong";
        Logger.debug('mydebug------GroupListProvider.fetchPendingDataList', [em]);
        completer.completeError(em);
      });
    } catch (e) {
      completer.completeError(e.toString());
    }

    return completer.future;
  }

  Future<GroupLotListResponse> fetchNewDataListData(int pageNumber, {String? query}) {
    var completer = Completer<GroupLotListResponse>();
    try {
      PackingService.getGroupNewDataList(pageNumber, query: query).listen((event) {
        if (event != null && !Validator.isListNullOrEmpty(event.groupLotList)) {
          completer.complete(event);
        } else {
          completer.completeError("No data found...");
        }
      }, onError: (error) {
        String em = ApiErrorHelper.getErrorMessage(error) ?? "Something went wrong";
        Logger.debug('mydebug------GroupListProvider.fetchNewDataListData', [em]);
        completer.completeError(em);
      }, onDone: () {
        notifyListeners();
      });
    } catch (e) {
      completer.completeError(e.toString());
    }
    return completer.future;
  }

  Future<bool> addCCTVCameraBarcode(String cameraBarcode, String? awbNumber, bool? isSelectResetOption) async {
    var completer = Completer<bool>();

    if (Validator.isTrue(isSelectResetOption)) {
      await resetItemPackaging(awbNumber);
    }

    PackingService.addMonitoringCamera(cameraBarcode: cameraBarcode, packagingBarcode: awbNumber).listen((event) {
      completer.complete(true);
    }, onError: (error) {
      completer.completeError(ApiErrorHelper.getErrorMessage(error).toString());
    });

    return completer.future;
  }

  Future<bool> resetItemPackaging(String? packagingBarcode) {
    var completer = Completer<bool>();

    PackingService.resetItemPackaging(packagingBarcode).listen((event) {
      completer.complete(true);
    }, onError: (error) {
      completer.completeError(ApiErrorHelper.getErrorMessage(error).toString());
    });

    return completer.future;
  }
}
