import 'package:flutter_trc/src/modules/rubbing/model/glass_change_fail_reason_response.dart';
import 'package:flutter_trc/src/modules/rubbing/model/rubbing_device_receive_response.dart';
import 'package:flutter_trc/src/modules/rubbing/model/rubbing_done_response.dart';
import 'package:flutter_trc/src/modules/rubbing/resources/domain/received_devices_interactor.dart';
import 'package:flutter_trc/src/modules/rubbing/resources/rubbing_api_service.dart';
import 'package:flutter_trc/src/modules/rubbing/resources/rubbing_module_role_type.dart';

class ReceivedDevicesInteractorImpl implements ReceivedDevicesInteractor {

  @override
  Stream<RubbingDoneResponse?> markRubbing(String barcode, bool isDone,
      {RubbingModuleRoleType roleType = RubbingModuleRoleType.rubbing, String? partBarcode, String? selectedReason}) {
    return RubbingAPIService.markRubbing(barcode, isDone, roleType, selectedReason);
  }

  @override
  Stream<RubbingDeviceReceiveResponse?> receiveDeviceForRubbing(String barcode,
      {RubbingModuleRoleType roleType = RubbingModuleRoleType.rubbing}) {
    return RubbingAPIService.scanDevice(barcode, roleType);
  }

  @override
  Stream<RubbingDoneResponse?> attachBarcode(String barcode, String? partBarcode, RubbingModuleRoleType roleType) {
    return RubbingAPIService.attachPartBarcode(barcode, partBarcode, roleType);
  }

  @override
  Stream<GlassChangeFailReasonResponse?> getFailReasonList(RubbingModuleRoleType roleType) {
    return RubbingAPIService.getFailReasonList(roleType);
  }
}
