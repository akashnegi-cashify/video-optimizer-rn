import 'dart:convert';

import 'package:core_widgets/core_widgets.dart';
import 'package:flutter_trc/qc/modules/stock_transfer/resources/box_charger_tracking_response.dart';
import 'package:flutter_trc/qc/modules/stock_transfer/resources/pending_lot_detail_response.dart';
import 'package:flutter_trc/qc/modules/stock_transfer/resources/scanned_device_detail_response.dart';
import 'package:flutter_trc/qc/modules/stock_transfer/resources/st_lot_details_response.dart';
import 'package:flutter_trc/qc/modules/stock_transfer/resources/stock_transfer_list_response.dart';
import 'package:flutter_trc/qc/modules/stock_transfer/resources/stock_transfer_status_filter_response.dart';
import 'package:flutter_trc/qc/modules/stock_transfer/resources/storage_device_list_response.dart';
import 'package:flutter_trc/src/common/model/base_action_response.dart';
import 'package:flutter_trc/src/services/qc_service.dart';

class StockTransferService {
  static Stream<StockTransferListResponse?> getStockTransferList(
      {required String tabType,
      required int offset,
      required int pageSize,
      String? searchQuery,
      List<int>? statusListFilter}) {
    Map<String, dynamic> req = {
      "pageSize": pageSize,
      "offset": offset,
    };
    Map<String, dynamic>? filterMap;
    if (!Validator.isNullOrEmpty(searchQuery)) {
      filterMap = {"na": searchQuery};
    }
    if (!Validator.isListNullOrEmpty(statusListFilter)) {
      filterMap ??= {};
      filterMap["stc"] = statusListFilter;
    }
    if (filterMap != null) {
      req["filterObjectMap"] = filterMap;
    }

    return QcService()
        .post("/transfer-lot/list-lots?requestTab=$tabType", StockTransferListResponse.fromJson, body: jsonEncode(req));
  }

  static Stream<StLotDetailResponse?> getStockTransferLotDetails(int? lotId,
      {String? lastLocationType, String? lastLocation}) {
    Map<String, List<String>> params = {
      "lotId": [lotId.toString()],
      if (!Validator.isNullOrEmpty(lastLocationType)) "lt": [lastLocationType.toString()],
      if (!Validator.isNullOrEmpty(lastLocation)) "lb": [lastLocation.toString()],
    };
    return QcService().get("/transfer-lot/fetch-store-out-device", StLotDetailResponse.fromJson, params: params);
  }

  static Stream<BaseActionResponse?> removeDeviceFromLot(int? lotId, String? qrCode) {
    Map<String, List<String>> params = {
      "lotId": [lotId.toString()],
      "qrCode": [qrCode.toString()],
    };
    return QcService().post("/transfer-lot/remove-device", BaseActionResponse.fromJsonWithInt, params: params);
  }

  static Stream<BaseActionResponse?> skipDeviceFromLot(int? lotId, String? qrCode) {
    Map<String, List<String>> params = {
      "lotId": [lotId.toString()],
      "qrCode": [qrCode.toString()],
    };
    return QcService().post("/transfer-lot/skip-device", BaseActionResponse.fromJsonWithInt, params: params);
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

  static Stream<StockTransferStatusFilterResponse?> getStatusFilterList(String tabType) {
    return QcService()
        .get("/transfer-lot/status-options?requestTab=$tabType", StockTransferStatusFilterResponse.fromJson);
  }

  static Stream<StorageDeviceListResponse?> getStorageDeviceList(int? lotId,
      {int? pageSize, int? offset, String? deviceBarcode}) {
    var req = {
      "pageSize": pageSize,
      "offset": offset,
      if (!Validator.isNullOrEmpty(deviceBarcode)) "filterObjectMap": {"qc": deviceBarcode}
    };
    return QcService()
        .post("/transfer-lot/list-devices/$lotId", StorageDeviceListResponse.fromJson, body: jsonEncode(req));
  }
}
