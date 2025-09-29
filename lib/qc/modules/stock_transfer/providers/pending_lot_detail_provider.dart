import 'dart:async';

import 'package:core/core.dart';
import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/qc/modules/stock_transfer/resources/pending_lot_detail_response.dart';
import 'package:flutter_trc/qc/modules/stock_transfer/resources/scanned_device_detail_response.dart';
import 'package:flutter_trc/qc/modules/stock_transfer/resources/stock_transfer_service.dart';
import 'package:provider/provider.dart';

class PendingLotDetailProvider extends CshChangeNotifier {
  int? lotId;
  String? _searchQuery;
  ScannedDeviceDetailResponse? scannedDeviceDetailResponse;

  PendingLotDetailResponse? pendingLotDetailResponse;

  static PendingLotDetailProvider of(BuildContext context, {bool listen = true}) {
    return Provider.of<PendingLotDetailProvider>(context, listen: listen);
  }

  PendingLotDetailProvider(this.lotId);

  Future<List<PendingLotDeviceListData>> getDeviceList({int offset = 1, int pageSize = 10}) {
    var completer = Completer<List<PendingLotDeviceListData>>();
    StockTransferService.getPendingLotDetails(lotId, pageSize, offset, _searchQuery).listen((event) {
      pendingLotDetailResponse = event;
      if (Validator.isListNullOrEmpty(pendingLotDetailResponse?.deviceList)) {
        completer.completeError("No data found");
      } else {
        completer.complete(pendingLotDetailResponse?.deviceList!);
      }
      notifyListeners();
    }, onError: (error) {
      completer.completeError(ApiErrorHelper.getErrorMessage(error).toString());
    });
    return completer.future;
  }

  void setQuery(String query) {
    _searchQuery = query;
  }

  Future<void> removeDeviceFromLot(String? deviceBarcode) {
    var completer = Completer<void>();
    StockTransferService.removeDeviceFromLot(lotId, deviceBarcode).listen((event) {
      completer.complete();
    }, onError: (error) {
      completer.completeError(ApiErrorHelper.getErrorMessage(error).toString());
    });
    return completer.future;
  }

  Future<void> getScannedDeviceDetail(String? deviceBarcode) {
    var completer = Completer<void>();
    StockTransferService.getScannedDeviceDetails(deviceBarcode).listen((event) {
      scannedDeviceDetailResponse = event;
      completer.complete();
    }, onError: (error) {
      completer.completeError(ApiErrorHelper.getErrorMessage(error).toString());
    });
    return completer.future;
  }

  Future<void> addDeviceInLot(String? scannedDevice) {
    var completer = Completer<void>();
    StockTransferService.addDevice(scannedDevice, lotId, null, null).listen((event) {
      completer.complete();
    }, onError: (error) {
      completer.completeError(ApiErrorHelper.getErrorMessage(error).toString());
    });
    return completer.future;
  }

  resetScannedDeviceDetail() {
    scannedDeviceDetailResponse = null;
  }
}
