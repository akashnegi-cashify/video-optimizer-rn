import 'dart:async';

import 'package:core/core.dart';
import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/qc/modules/re_qc/models/device_accessories_list_response.dart';
import 'package:flutter_trc/qc/modules/re_qc/models/device_report_list_response.dart';
import 'package:flutter_trc/qc/modules/re_qc/models/lot_device_list_response.dart';
import 'package:flutter_trc/qc/modules/re_qc/models/re_qc_list_response.dart';
import 'package:flutter_trc/qc/modules/re_qc/resources/re_qc_service.dart';
import 'package:provider/provider.dart';

class ReQcDetailProvider extends CshChangeNotifier {
  ReQcListData reQcListData;
  List<LotDeviceListData>? deviceList;
  String? errorMessage;
  String? scannedDeviceBarcode;
  List<DeviceReportListData>? deviceReportList;
  bool isLoading = true;

  ReQcDetailProvider(this.reQcListData) {
    getDeviceList();
  }

  String get lotName => reQcListData.lotGroupName ?? "";

  static ReQcDetailProvider of(BuildContext context, {bool listen = true}) {
    return Provider.of<ReQcDetailProvider>(context, listen: listen);
  }

  String? getDoneStatusCount() {
    if (Validator.isListNullOrEmpty(deviceList)) {
      return null;
    }
    var pendingCount = deviceList!.where((element) => element.status == 0).toList().length;
    var totalCount = deviceList!.length;
    return "${totalCount - pendingCount}/$totalCount";
  }

  Future<bool> getDeviceList() {
    var completer = Completer<bool>();
    try {
      ReQcService.getLotDeviceList(lotName).listen((event) {
        if (Validator.isListNullOrEmpty(event?.deviceList)) {
          errorMessage = "Device list is not present";
          completer.completeError("Device list is not present");
        } else {
          deviceList = event?.deviceList;
          completer.complete(true);
        }
      }, onError: (e) {
        errorMessage = ApiErrorHelper.getErrorMessage(e);
        completer.completeError(errorMessage.toString());
      }, onDone: () {
        isLoading = false;
        notifyListeners();
      });
    } catch (e) {
      errorMessage = e.toString();
      completer.completeError(errorMessage.toString());
    }

    return completer.future;
  }

  LotDeviceListData? getLotListData() {
    var index =
        deviceList?.indexWhere((element) => scannedDeviceBarcode?.toLowerCase() == element.qrCode?.toLowerCase());
    if (index != null && index > -1) {
      return deviceList![index];
    } else {
      return null;
    }
  }

  Future<bool> getDeviceReportList(String scannedData) {
    var index = deviceList?.indexWhere((element) => scannedData.toLowerCase() == element.qrCode?.toLowerCase());
    if (index == null || index < 0) {
      return Future.error("Device not found in this lot");
    }
    var completer = Completer<bool>();
    ReQcService.getDeviceReportList(deviceList![index].deviceId).listen((event) {
      scannedDeviceBarcode = scannedData;
      if (Validator.isListNullOrEmpty(event?.deviceReportList)) {
        completer.completeError("Device Report list is not found");
      } else {
        deviceReportList = event?.deviceReportList;
        completer.complete(true);
      }
    }, onError: (e) {
      errorMessage = ApiErrorHelper.getErrorMessage(e);
      completer.completeError(errorMessage.toString());
    }, onDone: () {
      notifyListeners();
    });
    return completer.future;
  }

  Future<List<DeviceAccessoriesListData>?> getDeviceAccessories(int? deviceId) {
    var completer = Completer<List<DeviceAccessoriesListData>?>();
    ReQcService.getDeviceAccessories(deviceId).listen((event) {
      if (Validator.isListNullOrEmpty(event?.accessoriesList)) {
        completer.completeError("Accessories not found");
      } else {
        completer.complete(event?.accessoriesList);
      }
    }, onError: (e) {
      completer.completeError(ApiErrorHelper.getErrorMessage(e).toString());
      errorMessage = ApiErrorHelper.getErrorMessage(e);
    });
    return completer.future;
  }

  bool isAllDeviceReQcComplete() {
    for (var device in deviceList ?? []) {
      if (device.status == 0) {
        return false;
      }
    }
    return true;
  }

  Future<List<String>> completeReQc() {
    var completer = Completer<List<String>>();
    ReQcService.completeReQc(reQcListData.lotGroupName).listen((event) {
      if (Validator.isTrue(event?.isSuccess)) {
        List<String> deviceList = [];
        if (!Validator.isListNullOrEmpty(event?.d2cLotDeviceList)) {
          deviceList = event!.d2cLotDeviceList!.map((e) => e.deviceBarcode ?? "").toList();
        }
        completer.complete(deviceList);
      } else {
        completer.completeError(event?.errorMsg ?? "Something went wrong");
      }
    }, onError: (e) {
      errorMessage = ApiErrorHelper.getErrorMessage(e);
      completer.completeError(errorMessage.toString());
    });
    return completer.future;
  }
}
