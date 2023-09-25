import 'dart:async';

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
    _getDeviceList();
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

  void _getDeviceList() {
    ReQcService.getLotDeviceList(lotName).listen((event) {
      deviceList = event?.deviceList;
      if (Validator.isListNullOrEmpty(deviceList)) {
        errorMessage = "Device list is not present";
      }
    }, onError: (e) {
      errorMessage = ApiErrorHelper.getErrorMessage(e);
    }, onDone: () {
      isLoading = false;
      notifyListeners();
    });
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
}
