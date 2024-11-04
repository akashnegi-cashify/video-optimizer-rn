import 'dart:convert';

import 'package:core_widgets/core_widgets.dart';
import 'package:flutter_trc/src/modules/trc_executive/models/device_receive_response.dart';
import 'package:flutter_trc/src/modules/trc_executive/models/tl_list_response.dart';
import 'package:flutter_trc/src/services/trc_service.dart';

class DeviceScannerService {
  static Stream<DeviceReceiveResponse?> receiveDevice(String deviceBarcode, int tlId) {
    Map<String, String> data = {"dbr": deviceBarcode, "asgnusrid": tlId.toString()};
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
}
