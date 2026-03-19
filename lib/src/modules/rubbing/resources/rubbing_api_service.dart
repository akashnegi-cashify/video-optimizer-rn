import 'dart:convert';

import 'package:core_widgets/core_widgets.dart';
import 'package:flutter_trc/src/modules/rubbing/model/glass_change_fail_reason_response.dart';
import 'package:flutter_trc/src/modules/rubbing/model/rubbing_done_response.dart';
import 'package:flutter_trc/src/modules/rubbing/resources/rubbing_module_role_type.dart';

import '../../../services/trc_service.dart';
import '../model/rubbing_device_receive_response.dart';

class RubbingAPIService {
  static String _getPrefix(RubbingModuleRoleType roleType) {
    switch (roleType) {
      case RubbingModuleRoleType.rubbing:
        return "/rubbing";
      case RubbingModuleRoleType.glassChange:
        return "/glass-change";
      case RubbingModuleRoleType.cameraCleaning:
        return "/camera-cleaning";
    }
  }

  static Stream<RubbingDoneResponse?> markRubbing(
      String scannedBarcode, bool rubbingDone, RubbingModuleRoleType roleType, String? selectedReason) {
    Map<String, List<String>> paramData = {
      "dbr": [scannedBarcode],
      "isrd": [rubbingDone.toString()],
      if (!Validator.isNullOrEmpty(selectedReason)) "rsnid": [selectedReason.toString()]
    };
    return TrcService().post("${_getPrefix(roleType)}/device/done", RubbingDoneResponse.fromJson, params: paramData);
  }

  static Stream<RubbingDeviceReceiveResponse?> scanDevice(String scannedBarcode, RubbingModuleRoleType roleType) {
    Map<String, List<String>> paramData = {
      "dbr": [scannedBarcode],
    };
    return TrcService()
        .post("${_getPrefix(roleType)}/device/scan", RubbingDeviceReceiveResponse.fromJson, params: paramData);
  }

  static Stream<RubbingDoneResponse?> attachPartBarcode(
      String deviceBarcode, String? partBarcode, RubbingModuleRoleType roleType) {
    Map<String, String?> req = {"dbr": deviceBarcode, "pbr": partBarcode};
    return TrcService()
        .post("${_getPrefix(roleType)}/device/attach/barcode", RubbingDoneResponse.fromJson, body: jsonEncode(req));
  }

  static Stream<GlassChangeFailReasonResponse?> getFailReasonList(RubbingModuleRoleType roleType) {
    return TrcService().get("${_getPrefix(roleType)}/fail/reason/list", GlassChangeFailReasonResponse.fromJson);
  }
}
