import 'dart:async';

import 'package:core/core.dart';
import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/shipex/modules/packaging/resouces/packaging_status_type.dart';
import 'package:provider/provider.dart';

import '../models/group_lot_list_repsonse.dart';
import '../resouces/packing_service.dart';

class GroupListProvider extends CshChangeNotifier {
  static GroupListProvider of(BuildContext context, {bool listen = true}) {
    return Provider.of<GroupListProvider>(context, listen: listen);
  }

  Future<List<GroupLotListData>?> fetchNewDataListData(
      PackagingStatusType type, int pageNumber, String? lotName, String? awbNumber) {
    var completer = Completer<List<GroupLotListData>?>();
    try {
      Map<String, dynamic> filterMap = {"s": type.value};
      if (!Validator.isNullOrEmpty(lotName)) {
        filterMap["gn"] = lotName;
      }
      if (!Validator.isNullOrEmpty(awbNumber)) {
        filterMap["awb"] = awbNumber;
      }

      PackingService.getGroupNewDataList(pageNumber, filter: filterMap).listen((event) {
        if (event != null && !Validator.isListNullOrEmpty(event.groupLotList)) {
          completer.complete(event.groupLotList);
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
