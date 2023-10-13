import 'dart:convert';

import 'package:core_widgets/core_widgets.dart';
import 'package:flutter_trc/qc/modules/stock_transfer/models/box_charger_tracking_response.dart';
import 'package:flutter_trc/qc/modules/stock_transfer/models/pending_lot_detail_response.dart';
import 'package:flutter_trc/qc/modules/stock_transfer/models/scanned_device_detail_response.dart';
import 'package:flutter_trc/qc/modules/stock_transfer/models/st_lot_details_response.dart';
import 'package:flutter_trc/qc/modules/stock_transfer/models/stock_transfer_list_response.dart';
import 'package:flutter_trc/src/common/model/base_action_response.dart';
import 'package:flutter_trc/src/services/qc_service.dart';

class StockTransferService {
  static Stream<StockTransferListResponse?> getStockTransferList({bool? isStoreOut = false}) {
    return QcService().get("/transfer-lot/list-lots?isStoreOut=$isStoreOut", StockTransferListResponse.fromJson);
  }

  static Stream<StLotDetailResponse?> getStockTransferLotDetails(int? lotId) {
    return QcService().get("/transfer-lot/fetch-store-out-device?lotId=$lotId", StLotDetailResponse.fromJson);
  }

  static Stream<BaseActionResponse?> removeDeviceFromLot(int? lotId, String? qrCode) {
    Map<String, List<String>> params = {
      "lotId": [lotId.toString()],
      "qrCode": [qrCode.toString()],
    };
    return QcService().post("/transfer-lot/remove-device", BaseActionResponse.fromJsonWithInt, params: params);
  }

  static Stream<BoxChargerTrackingResponse?> checkBoxChargerTracking(String? qrCode) {
    return QcService().get("/box-charger-tracking/getQcTracking/$qrCode", BoxChargerTrackingResponse.fromJson);
  }

  static Stream<BaseResponse?> addDevice(String? qrCode, int? lotId, bool? isBoxAvailable, bool? isChargerAvailable) {
    Map<String, dynamic> body = {};
    if (isBoxAvailable != null && isChargerAvailable != null) {
      body = {
        "qr": qrCode,
        "a": "Transfer Lot",
        "hb": Validator.isTrue(isBoxAvailable) ? 1 : 0,
        "hc": Validator.isTrue(isChargerAvailable) ? 1 : 0,
      };
    }

    Map<String, List<String>> params = {
      "qrCode": [qrCode.toString()],
      "lotId": [lotId.toString()],
    };
    return QcService().post("/transfer-lot/add-device", BaseResponse.fromJson, params: params, body: jsonEncode(body));
  }

  static Stream<PendingLotDetailResponse?> getPendingLotDetails(int? lotId) {
    Map<String, List<String>> params = {
      "lotId": [lotId.toString()],
      "page_size": ["20"],
      "page_offset": ["0"],
    };
    return QcService().get("/transfer-lot/list-devices", PendingLotDetailResponse.fromJson, params: params);
  }

  static Stream<ScannedDeviceDetailResponse?> getScannedDeviceDetails(String? scannedBarcode) {
    return QcService().get("/transfer-lot/scan-device?qrCode=$scannedBarcode", ScannedDeviceDetailResponse.fromJson);
  }

  static Stream<BaseResponse?> completePendingDispatch(String invoiceNo, String awbNo, String invoiceUrl) {
    Map<String, dynamic> body = {
      "invoiceNo": invoiceNo,
      "wbn": awbNo,
      "img": invoiceUrl,
    };
    return QcService().post("/transfer-lot/dispatch-lot-v2", BaseResponse.fromJson, body: jsonEncode(body));
  }
}
