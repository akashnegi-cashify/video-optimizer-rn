import 'dart:async';

import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/qc/modules/stock_transfer/models/st_lot_details_response.dart';
import 'package:flutter_trc/qc/modules/stock_transfer/resources/stock_transfer_service.dart';
import 'package:provider/provider.dart';

class StStoreOutProvider extends CshChangeNotifier {
  static StStoreOutProvider of(BuildContext context, {bool listen = true}) {
    return Provider.of<StStoreOutProvider>(context, listen: listen);
  }

  StreamController<StLotDetailResponse?> _lotDetailsStreamController =
      StreamController<StLotDetailResponse?>.broadcast();

  Stream<StLotDetailResponse?> get lotDetailsStream => _lotDetailsStreamController.stream;

  int? lotId;
  StLotDetailResponse? lotDetails;

  StStoreOutProvider(this.lotId) {
    getLotDetailsStream();
  }

  void getLotDetailsStream() {
    _lotDetailsStreamController.sink.addStream(StockTransferService.getStockTransferLotDetails(lotId));
  }

  void setData(StLotDetailResponse? data) {
    lotDetails = data;
  }

  Future<void> removeDevice() {
    var completer = Completer<void>();
    StockTransferService.removeDeviceFromLot(lotId, lotDetails?.barcode).listen((event) {
      if (Validator.isTrue(event?.isSuccess)) {
        completer.complete();
      } else {
        completer.completeError(event?.errorMsg ?? "Something went wrong");
      }
    }, onError: (error) {
      completer.completeError(ApiErrorHelper.getErrorMessage(error).toString());
    });
    return completer.future;
  }

  bool isMoreDevicesAvailable() {
    return (lotDetails?.deviceCount ?? 0) > (lotDetails?.scanCount ?? 0) + 1;
  }
}
