import 'dart:convert';

import 'package:core_widgets/core_widgets.dart';
import 'package:flutter_trc/qc/modules/stock_transfer/resources/add_device_response.dart';
import 'package:flutter_trc/qc/modules/stock_transfer/resources/box_charger_tracking_response.dart';
// import removed: pending_lot_detail_response.dart no longer used with v1 device list
import 'package:flutter_trc/qc/modules/stock_transfer/resources/scanned_device_detail_response.dart';
import 'package:flutter_trc/qc/modules/stock_transfer/resources/st_lot_details_response.dart';
import 'package:flutter_trc/qc/modules/stock_transfer/resources/stock_transfer_list_response.dart';
import 'package:flutter_trc/qc/modules/stock_transfer/resources/stock_transfer_status_filter_response.dart';
// import removed: storage_device_list_response.dart not used with v1 device list
import 'package:flutter_trc/qc/modules/stock_transfer/resources/transfer_lot_device_list_response.dart';
import 'package:flutter_trc/src/common/model/base_action_response.dart';
import 'package:flutter_trc/src/services/qc_transfer_service.dart';

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

    return QcTransferService()
        .post("/v1/transfer-lot/list-lots?requestTab=$tabType", StockTransferListResponse.fromJson, body: jsonEncode(req));
  }

  static Stream<StLotDetailResponse?> getStockTransferLotDetails(int? lotId,
      {String? lastLocationType, String? lastLocation}) {
    Map<String, List<String>> params = {
      "lotId": [lotId.toString()],
      if (!Validator.isNullOrEmpty(lastLocationType)) "lt": [lastLocationType.toString()],
      if (!Validator.isNullOrEmpty(lastLocation)) "lb": [lastLocation.toString()],
    };
    return QcTransferService().get("/v1/transfer-lot/fetch-store-out-device", StLotDetailResponse.fromJson, params: params);
  }

  static Stream<BaseActionResponse?> removeDeviceFromLot(int? lotId, String? qrCode) {
    Map<String, List<String>> params = {
      "lotId": [lotId.toString()],
      "qrCode": [qrCode.toString()],
    };
    return QcTransferService().post("/v1/transfer-lot/remove-device", BaseActionResponse.fromJsonWithInt, params: params);
  }

  static Stream<BaseActionResponse?> skipDeviceFromLot(int? lotId, String? qrCode) {
    Map<String, List<String>> params = {
      "lotId": [lotId.toString()],
      "qrCode": [qrCode.toString()],
    };
    return QcTransferService().post("/v1/transfer-lot/skip-device", BaseActionResponse.fromJsonWithInt, params: params);
  }

  static Stream<BoxChargerTrackingResponse?> checkBoxChargerTracking(String? qrCode) {
    return QcTransferService().get("/v1//box-charger-tracking/getQcTracking/$qrCode", BoxChargerTrackingResponse.fromJson);
  }

  static Stream<AddDeviceResponse?> addDevice(
      String? qrCode, int? lotId, bool? isBoxAvailable, bool? isChargerAvailable) {
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
    return QcTransferService()
        .post("/v1/transfer-lot/add-device", AddDeviceResponse.fromJson, params: params, body: jsonEncode(body));
  }

  static Stream<TransferLotDetailListResponse?> getPendingLotDetails(
      int? lotId, int? pageSize, int? offset, String? searchQuery) {
    final filters = [
      {
        "field": "transferLot.id",
        "type": "EQUALITY",
        "value": {"search": "${lotId ?? ""}"}
      }
    ];
    final params = <String, List<String>>{
      "pageSize": [pageSize?.toString() ?? ""],
      "offset": [offset?.toString() ?? ""],
      "filter": [jsonEncode(filters)],
      if (!Validator.isNullOrEmpty(searchQuery))
        "filterObjectMap": [jsonEncode({"br": searchQuery})],
    };
    return QcTransferService().get(
      "/v1/transfer-lot/device/list",
      TransferLotDetailListResponse.fromJson,
      params: params,
    );
  }

  static Stream<ScannedDeviceDetailResponse?> getScannedDeviceDetails(String? scannedBarcode) {
    return QcTransferService().get("/v1/transfer-lot/scan-device?qrCode=$scannedBarcode", ScannedDeviceDetailResponse.fromJson);
  }

  static Stream<BaseResponse?> completePendingDispatch(String invoiceNo, String awbNo, String invoiceUrl) {
    Map<String, dynamic> body = {
      "invoiceNo": invoiceNo,
      "wbn": awbNo,
      "img": invoiceUrl,
    };
    return QcTransferService().post("/v1/transfer-lot/dispatch", BaseResponse.fromJson, body: jsonEncode(body));
  }

  static Stream<StockTransferStatusFilterResponse?> getStatusFilterList(String tabType) {
    return QcTransferService()
        .get("/v1/transfer-lot/status-options?requestTab=$tabType", StockTransferStatusFilterResponse.fromJson);
  }

  static Stream<TransferLotDetailListResponse?> getStorageDeviceList(int? lotId,
      {int? pageSize, int? offset, String? deviceBarcode}) {
    final filters = [
      {
        "field": "transferLot.id",
        "type": "EQUALITY",
        "value": {"search": "${lotId ?? ""}"}
      }
    ];
    final params = <String, List<String>>{
      "pageSize": [pageSize?.toString() ?? ""],
      "offset": [offset?.toString() ?? ""],
      "filter": [jsonEncode(filters)],
      if (!Validator.isNullOrEmpty(deviceBarcode))
        "filterObjectMap": [jsonEncode({"qc": deviceBarcode})],
    };
    return QcTransferService().get(
      "/v1/transfer-lot/device/list",
      TransferLotDetailListResponse.fromJson,
      params: params,
    );
  }

  static Stream<BaseActionResponse?> resetStoreOutList(int? lotId) {
    return QcTransferService().post("/v1/transfer-lot/skip-device/reset?lotId=$lotId", BaseActionResponse.fromJsonWithInt);
  }
}
