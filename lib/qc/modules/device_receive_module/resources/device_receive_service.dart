import 'dart:convert';


import '../../../../src/services/qc_service.dart';
import '../models/device_receive_response.dart';

class DeviceReceiveService {
  static Stream<DeviceReceiveResponse?> receiveDevice(String deviceBarcode) {
    Map<String, String> data = {"dbr": deviceBarcode};
    var bodyData = jsonEncode(data);

    return QcService().post("/device/repair/receive", DeviceReceiveResponse.fromJson, body: bodyData);
  }
}
