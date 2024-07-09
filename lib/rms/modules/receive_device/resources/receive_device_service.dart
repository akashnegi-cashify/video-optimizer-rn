import 'dart:convert';

import 'package:flutter_trc/rms/modules/receive_device/barcode_types.dart';
import 'package:flutter_trc/rms/rms_service.dart';
import 'package:flutter_trc/src/common/model/base_action_response.dart';

class ReceiveDeviceService {
  static Stream<BaseActionResponse?> receiveDevice(String barcode, BarcodeTypes barcodeType) {
    Map<String, dynamic> req = {"v": barcode, "vt": barcodeType.value};

    return RmsService().post("/app/receive/device", BaseActionResponse.fromJson, body: jsonEncode(req));
  }
}
