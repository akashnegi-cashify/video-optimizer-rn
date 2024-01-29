import 'dart:async';

import 'package:core/core.dart';
import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/qc/modules/stock_transfer/resources/st_lot_details_response.dart';
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
  StLotDetailResponse? _lastLotDetails;

  StStoreOutProvider(this.lotId) {
    getLotDetailsStream();
  }

  void getLotDetailsStream() {
    _lotDetailsStreamController.sink.addStream(StockTransferService.getStockTransferLotDetails(
      lotId,
      lastLocationType: _lastLotDetails?.storage,
      lastLocation: _lastLotDetails?.location,
    ));
  }

  void setData(StLotDetailResponse? data) {
    if (lotDetails == null) {
      lotDetails = data;
    } else {
      lotDetails?.setData(data);
    }
  }

  Future<void> skipDevice() {
    var completer = Completer<void>();
    StockTransferService.skipDeviceFromLot(lotId, lotDetails?.barcode).listen((event) {
      if (Validator.isTrue(event?.isSuccess)) {
        _lastLotDetails = lotDetails;
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

  @override
  void dispose() {
    _lotDetailsStreamController.close();
    super.dispose();
  }

  Future<bool> checkBoxChargerTracking() {
    var completer = Completer<bool>();
    StockTransferService.checkBoxChargerTracking(lotDetails?.barcode).listen((event) {
      if ((event?.boxChargerTrackingData?.hasBox ?? 0) > 0 || (event?.boxChargerTrackingData?.hasCharger ?? 0) > 0) {
        completer.complete(true);
      } else {
        completer.complete(false);
      }
    }, onError: (error) {
      completer.completeError(ApiErrorHelper.getErrorMessage(error).toString());
    });
    return completer.future;
  }

  Future<void> addDevice(bool? isBoxAvailable, bool? isChargerAvailable) {
    var completer = Completer<void>();
    StockTransferService.addDevice(lotDetails?.barcode, lotId, isBoxAvailable, isChargerAvailable).listen((event) {
      _lastLotDetails = lotDetails;
      completer.complete();
    }, onError: (error) {
      completer.completeError(ApiErrorHelper.getErrorMessage(error).toString());
    });
    return completer.future;
  }
}
