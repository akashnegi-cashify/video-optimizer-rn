import 'dart:convert';

import 'package:core_widgets/core_widgets.dart';
import 'package:flutter_trc/qc/modules/store_in/resources/store_in_location_verify_response.dart';
import 'package:flutter_trc/src/modules/trc_executive/models/device_receive_response.dart';
import 'package:flutter_trc/src/modules/trc_executive/models/lot_device_list_response.dart';
import 'package:flutter_trc/src/modules/trc_executive/models/tl_list_response.dart';
import 'package:flutter_trc/src/services/trc_service.dart';

class DeviceScannerService {
  static Stream<DeviceReceiveResponse?> storeIn(String deviceBarcode, String? storageBarcode) {
    Map<String, String> data = {"dbr": deviceBarcode, "lcbr": storageBarcode.toString()};
    var bodyData = jsonEncode(data);

    return TrcService().post("/device/transfer/receive", DeviceReceiveResponse.fromJson, body: bodyData);
  }

  static Stream<TlListResponse?> getTlList(int pageNo, int pageSize, {String? searchQuery}) {
    Map<String, dynamic> data = {"offset": pageNo, "pageSize": pageSize};
    if (!Validator.isNullOrEmpty(searchQuery)) {
      data["frm"] = {"name": searchQuery};
    }
    var bodyData = jsonEncode(data);

    return TrcService().post("/role/tl/list", TlListResponse.fromJson, body: bodyData);
  }

  static Stream<StoreInLocationVerifyResponse?> getStorageDetails(String? barcode) {
    return TrcService().get("/storage/details?tbr=$barcode", StoreInLocationVerifyResponse.fromJson);
  }

  static Stream<LotDeviceListResponse?> getLotDeviceList(String lotName) {
    return TrcService().get(
      "/storage/lot/device/list",
      LotDeviceListResponse.fromJson,
      params: {"ln": [lotName]},
    );
  }

  static Stream<BaseResponse?> storeOut(String? barcode, int? tlId) {
    Map<String, dynamic> data = {"dbr": barcode, "asgnusrid": tlId};
    var bodyData = jsonEncode(data);
    return TrcService().post("/storage/store-out-v2", BaseResponse.fromJson, body: bodyData);
  }
}
