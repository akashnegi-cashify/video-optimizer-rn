import 'dart:async';

import 'package:core/core.dart';
import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../engineer/models/retreived_part_required_list_reponse.dart';
import '../../engineer/my_devices/wip_devices/view_parts/models/order_engineer_part.dart';
import '../../engineer/resources/engineer_api_service.dart';
import '../models/retreived_parts_data_model.dart';

class RetrievedPartsDataProviders extends CshChangeNotifier {
  static RetrievedPartsDataProviders of(BuildContext context, {bool listen = true}) {
    return Provider.of<RetrievedPartsDataProviders>(context, listen: listen);
  }

  RetrievedPartRequiredResponse? dataModel;
  String? deviceBarcode;
  List<RetrievedPartListResponseData> partList = [];
  bool? isDeviceInProgress;
  List<OrderEngineerPart>? orderDataList;

  RetrievedPartsDataProviders(this.dataModel,
      {this.isDeviceInProgress = true, this.orderDataList, this.deviceBarcode}) {
    partList = dataModel?.data?.partList ?? [];
  }

  onS3UrlChange(int id, String url) {
    for (var element in partList) {
      if (element.partRequestId == id) {
        element.s3Url = url;
        break;
      }
    }
  }

  onReasonSelected(int id, String reason, int reasonId) {
    for (var element in partList) {
      if (element.partRequestId == id) {
        element.reasonId = reasonId;
        element.reasonLabel = reason;
        break;
      }
    }
  }

  onBarcodeChanged(int id, String barcode) {
    for (var element in partList) {
      if (element.partRequestId == id) {
        element.barcode = barcode;
        break;
      }
    }
  }

  onRemarkChanged(int id, String remark) {
    for (var element in partList) {
      if (element.partRequestId == id) {
        element.remark = remark;
        break;
      }
    }
  }

  Future<bool> sendDeviceToInProgress() {
    var completer = Completer<bool>();
    try {
      EngineerAPIService.sendToInProgress(deviceBarcode ?? "").listen((event) {
        if (Validator.isTrue(event?.isSuccess)) {
          completer.complete(true);
        } else {
          completer.completeError("Something went wrong");
        }
      }, onError: (error) {
        String err = ApiErrorHelper.getErrorMessage(error) ?? "Something went wrong";
        completer.completeError(err);
      }, onDone: () {
        notifyListeners();
      });
    } catch (e) {
      completer.completeError(e.toString());
    }
    return completer.future;
  }

  List<RetrievedPartsDataModel> getModelDataList() {
    List<RetrievedPartsDataModel> resDataList = [];
    for (var element in partList) {
      RetrievedPartsDataModel d = RetrievedPartsDataModel();
      if (element.partRequestId != null) {
        d.partRetrievedId = element.partRequestId;
      }
      if (element.categoryCode != null) {
        d.categoryCode = element.categoryCode;
      }
      d.retrievedPartsReasonId = element.reasonId;
      d.barcode = element.barcode;
      d.retrievedPartImages = [element.s3Url ?? ""];
      resDataList.add(d);
    }
    return resDataList;
  }

  List<Map<String, dynamic>> getBodyData() {
    List<RetrievedPartsDataModel> resDataList = [];
    for (var element in partList) {
      RetrievedPartsDataModel d = RetrievedPartsDataModel();
      if (element.partRequestId != null) {
        d.partRetrievedId = element.partRequestId;
      }
      if (element.categoryCode != null) {
        d.categoryCode = element.categoryCode;
      }
      d.retrievedPartsReasonId = element.reasonId;
      d.barcode = element.barcode;
      d.retrievedPartImages = [element.s3Url ?? ""];
      resDataList.add(d);
    }

    List<Map<String, dynamic>> dataList = [];
    for (var newElement in resDataList) {
      dataList.add(newElement.toJson());
    }
    return dataList;
  }

  Future<bool> updatePartsData(Map<String, dynamic> data) {
    var completer = Completer<bool>();
    try {
      EngineerAPIService.updateRetrievedParts(data).listen((event) {
        if (Validator.isTrue(event?.isSuccess)) {
          completer.complete(true);
        } else {
          completer.completeError("Something went wrong");
        }
      }, onError: (e) {
        String apiErr = ApiErrorHelper.getErrorMessage(e) ?? "Something went wrong";
        completer.completeError(apiErr);
      }, onDone: () {
        notifyListeners();
      });
    } catch (e) {
      completer.completeError(e.toString());
    }
    return completer.future;
  }

  Future<bool> orderPartsWithRetrievedData() {
    var completer = Completer<bool>();
    if (Validator.isListNullOrEmpty(orderDataList)) {
      completer.completeError("No Order data list found");
      return completer.future;
    }
    List<RetrievedPartsDataModel> dataList = getModelDataList();
    List<OrderEngineerPart> submitList = [];

    for (var master in orderDataList!) {
      if (master.partType != null && master.partType == 1 && master.categoryCode != null) {
        for (var slave in dataList) {
          if (master.categoryCode == slave.categoryCode) {
            master.retrievedPartData = slave.toJson();
            submitList.add(master);
            break;
          }
        }
      }
    }

    try {
      EngineerAPIService.orderDeviceParts(deviceBarcode, submitList).listen((event) {
        if (Validator.isTrue(event?.isSuccess)) {
          completer.complete(true);
        } else {
          completer.completeError("Something went wrong");
        }
      }, onError: (error) {
        String apiErr = ApiErrorHelper.getErrorMessage(error) ?? "Something went wrong";
        completer.completeError(apiErr);
      }, onDone: () {
        notifyListeners();
      });
    } catch (e) {
      completer.completeError(e.toString());
    }
    return completer.future;
  }
}
