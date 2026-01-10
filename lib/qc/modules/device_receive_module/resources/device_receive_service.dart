import 'dart:convert';


import '../../../../src/services/qc_service.dart';
import '../models/device_receive_response.dart';

class DeviceReceiveService {
  static Stream<DeviceReceiveData?> receiveDevice(String deviceBarcode) {
    Map<String, String> data = {"deviceBarcode": deviceBarcode};
    var bodyData = jsonEncode(data);

    return QcService().post("/device/repair/receive", DeviceReceiveData.fromJson, body: bodyData);
  }
}
