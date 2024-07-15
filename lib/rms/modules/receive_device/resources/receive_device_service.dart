import 'dart:convert';

import 'package:flutter_trc/rms/modules/receive_device/barcode_types.dart';
import 'package:flutter_trc/rms/modules/receive_device/resources/receive_device_detail_response.dart';
import 'package:flutter_trc/src/services/rms_service.dart';
import 'package:flutter_trc/src/common/model/base_action_response.dart';

class ReceiveDeviceService {
  static Stream<BaseActionResponse?> receiveDevice(String barcode, BarcodeTypes barcodeType) {
    Map<String, dynamic> req = {"v": barcode, "vt": barcodeType.value};

    return RmsService().post("/app/receive/device", BaseActionResponse.fromJsonWithInt, body: jsonEncode(req));
  }

  static Stream<ReceiveDeviceDetailResponse?> getDeviceDetails(String barcode, BarcodeTypes barcodeType) {
    Map<String, dynamic> req = {"v": barcode, "vt": barcodeType.value};

    return RmsService().post("/app/receive/device/detail", ReceiveDeviceDetailResponse.fromJson, body: jsonEncode(req));
  }

  static Stream<BaseActionResponse?> saveVideo(
      String barcode, BarcodeTypes barcodeType, int receiveType, String videoUrl) {
    Map<String, dynamic> req = {"v": barcode, "vt": barcodeType.value, "rt": receiveType, "vu": videoUrl};

    return RmsService()
        .post("/app/receive/device/video/save", BaseActionResponse.fromJsonWithInt, body: jsonEncode(req));
  }
}
