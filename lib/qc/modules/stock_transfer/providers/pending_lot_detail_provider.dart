import 'dart:async';

import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/qc/modules/stock_transfer/models/pending_lot_detail_response.dart';
import 'package:flutter_trc/qc/modules/stock_transfer/resources/stock_transfer_service.dart';
import 'package:provider/provider.dart';

class PendingLotDetailProvider extends CshChangeNotifier {
  int? lotId;
  String? _searchQuery;

  PendingLotDetailResponse? pendingLotDetailResponse;

  static PendingLotDetailProvider of(BuildContext context, {bool listen = true}) {
    return Provider.of<PendingLotDetailProvider>(context, listen: listen);
  }

  PendingLotDetailProvider(this.lotId) {
    _getDeviceList();
  }

  List<PendingLotDeviceListData>? get deviceList => Validator.isNullOrEmpty(_searchQuery)
      ? pendingLotDetailResponse?.deviceList
      : pendingLotDetailResponse?.deviceList
          ?.where((element) => element.qrCode!.toLowerCase().contains(_searchQuery!.toLowerCase()))
          .toList();

  _getDeviceList() {
    StockTransferService.getDeviceList(lotId).listen((event) {
      pendingLotDetailResponse = event;
      notifyListeners();
    }, onError: (error) {});
  }

  void setQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  Future<void> removeDeviceFromLot(String? deviceBarcode) {
    var completer = Completer<void>();
    StockTransferService.removeDeviceFromLot(lotId, deviceBarcode).listen((event) {
      _getDeviceList();
      completer.complete();
    }, onError: (error) {
      completer.completeError(ApiErrorHelper.getErrorMessage(error).toString());
    });
    return completer.future;
  }
}
