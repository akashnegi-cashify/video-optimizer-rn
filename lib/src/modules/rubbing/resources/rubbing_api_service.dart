import 'dart:convert';

import 'package:core_widgets/core_widgets.dart';
import 'package:flutter_trc/src/modules/rubbing/model/glass_change_fail_reason_response.dart';
import 'package:flutter_trc/src/modules/rubbing/model/rubbing_done_response.dart';

import '../../../services/trc_service.dart';
import '../model/rubbing_device_receive_response.dart';

class RubbingAPIService {
  // static Stream<RubbingDevicesResponse?> getReceivedDeviceList(RubbingDeviceListRequest request, bool isGlassChange) {
  //   String startPoint = isGlassChange ? "/glass-change" : "/rubbing";
  //   return TrcService()
  //       .post("$startPoint/device/list", RubbingDevicesResponse.fromJson, body: jsonEncode(request.toJson()));
  // }

  static Stream<RubbingDoneResponse?> markRubbing(
      String scannedBarcode, bool rubbingDone, bool isGlassChange, String? selectedReason) {
    Map<String, List<String>> paramData = {
      "dbr": [scannedBarcode],
      "isrd": [rubbingDone.toString()],
      if (!Validator.isNullOrEmpty(selectedReason)) "rsnid": [selectedReason.toString()]
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

  static Stream<RubbingDoneResponse?> attachPartBarcode(String deviceBarcode, String? partBarcode) {
    Map<String, String?> req = {"dbr": deviceBarcode, "pbr": partBarcode};
    return TrcService()
        .post("/glass-change/device/attach/barcode", RubbingDoneResponse.fromJson, body: jsonEncode(req));
  }

  static Stream<GlassChangeFailReasonResponse?> getGlassFailReasonList() {
    return TrcService().get("/glass-change/fail/reason/list", GlassChangeFailReasonResponse.fromJson);
  }
}
