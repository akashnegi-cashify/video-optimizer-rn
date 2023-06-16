import 'dart:convert';

import 'package:flutter_trc/src/modules/trc_executive/models/device_receive_response.dart';
import 'package:flutter_trc/src/services/trc_service.dart';

class DeviceScannerService {
  static Stream<DeviceReceiveResponse?> receiveDevice(String deviceBarcode) {
    Map<String, String> data = {"dbr": deviceBarcode};
    var bodyData = jsonEncode(data);

    return TrcService().post("/device/transfer/receive", DeviceReceiveResponse.fromJson, body: bodyData);
  }
}
