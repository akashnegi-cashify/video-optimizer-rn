import 'dart:async';

import 'package:core/core.dart';
import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/qc/modules/stock_transfer/resources/st_lot_details_response.dart';
import 'package:flutter_trc/qc/modules/stock_transfer/resources/stock_transfer_service.dart';
import 'package:flutter_trc/src/common/searchable.dart';
import 'package:provider/provider.dart';

class StorageDeviceListProvider extends CshChangeNotifier with Searchable {
  final int lotId;

  StorageDeviceListProvider(this.lotId);

  static StorageDeviceListProvider of(BuildContext context, {bool listen = true}) {
    return Provider.of<StorageDeviceListProvider>(context, listen: listen);
  }

  Future<List<StLotDetailResponse>> getDeviceList(int pageSize, int offset) {
    var completer = Completer<List<StLotDetailResponse>>();
    StockTransferService.getStorageDeviceList(lotId, pageSize: pageSize, offset: offset, deviceBarcode: searchQuery)
        .listen((event) {
      if (!Validator.isListNullOrEmpty(event?.deviceList)) {
        completer.complete(event?.deviceList);
      } else {
        completer.completeError("No data found");
      }
    }, onError: (error) {
      completer.completeError(ApiErrorHelper.getErrorMessage(error).toString());
    });
    return completer.future;
  }
}
