import 'package:flutter_trc/src/modules/rubbing/model/glass_change_fail_reason_response.dart';
import 'package:flutter_trc/src/modules/rubbing/model/rubbing_device_receive_response.dart';
import 'package:flutter_trc/src/modules/rubbing/model/rubbing_devices_request.dart';
import 'package:flutter_trc/src/modules/rubbing/model/rubbing_devices_response.dart';
import 'package:flutter_trc/src/modules/rubbing/model/rubbing_done_response.dart';
import 'package:flutter_trc/src/modules/rubbing/resources/domain/received_devices_interactor.dart';
import 'package:flutter_trc/src/modules/rubbing/resources/rubbing_api_service.dart';

import '../../model/search_query.dart';

class ReceivedDevicesInteractorImpl implements ReceivedDevicesInteractor {

  @override
  Stream<RubbingDoneResponse?> markRubbing(String barcode, bool isDone,
      {bool isGlassChangeRole = false, String? partBarcode, String? selectedReason}) {
    return RubbingAPIService.markRubbing(barcode, isDone, isGlassChangeRole, selectedReason);
  }

  @override
  Stream<RubbingDeviceReceiveResponse?> receiveDeviceForRubbing(String barcode, {bool isGlassChange = false}) {
    return RubbingAPIService.scanDevice(barcode, isGlassChange);
  }

  @override
  Stream<RubbingDoneResponse?> attachBarcode(String barcode, String? partBarcode) {
    return RubbingAPIService.attachPartBarcode(barcode, partBarcode);
  }

  @override
  Stream<GlassChangeFailReasonResponse?> getGlassChangeFailReasonList() {
    return RubbingAPIService.getGlassFailReasonList();
  }
}
