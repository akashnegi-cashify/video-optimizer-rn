import 'dart:convert';

import 'package:flutter_trc/src/modules/rubbing/model/rubbing_devices_response.dart';
import 'package:flutter_trc/src/modules/rubbing/model/rubbing_done_response.dart';

import '../../../services/trc_service.dart';
import '../model/rubbing_device_receive_response.dart';
import '../model/rubbing_devices_request.dart';

class RubbingAPIService {
  static Stream<RubbingDevicesResponse?> getReceivedDeviceList(RubbingDeviceListRequest request, bool isGlassChange) {
    String startPoint = isGlassChange ? "/glass-change" : "/rubbing";
    return TrcService()
        .post("$startPoint/device/list", RubbingDevicesResponse.fromJson, body: jsonEncode(request.toJson()));
  }

  static Stream<RubbingDoneResponse?> markRubbing(String scannedBarcode, bool rubbingDone, bool isGlassChange) {
    Map<String, List<String>> paramData = {
      "dbr": [scannedBarcode],
      "isrd": [rubbingDone.toString()]
    };
    String startPoint = isGlassChange ? "/glass-change" : "/rubbing";
    return TrcService().post("$startPoint/device/done", RubbingDoneResponse.fromJson, params: paramData);
  }

  static Stream<RubbingDeviceReceiveResponse?> scanDevice(String scannedBarcode, bool isGlassChange) {
    String startPoint = isGlassChange ? "/glass-change" : "/rubbing";
    Map<String, List<String>> paramData = {
      "dbr": [scannedBarcode],
    };
    return TrcService().post("$startPoint/device/scan", RubbingDeviceReceiveResponse.fromJson, params: paramData);
  }
}
