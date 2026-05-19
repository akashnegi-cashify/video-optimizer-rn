import 'package:flutter_trc/src/modules/rubbing/model/glass_change_fail_reason_response.dart';
import 'package:flutter_trc/src/modules/rubbing/model/rubbing_device_receive_response.dart';
import 'package:flutter_trc/src/modules/rubbing/resources/rubbing_module_role_type.dart';

import '../../model/rubbing_done_response.dart';

mixin ReceivedDevicesInteractor {

  Stream<RubbingDoneResponse?> markRubbing(String barcode, bool isDone,
      {RubbingModuleRoleType roleType = RubbingModuleRoleType.rubbing, String? partBarcode, String? selectedReason});

  Stream<RubbingDoneResponse?> attachBarcode(String barcode, String? partBarcode, RubbingModuleRoleType roleType);

  Stream<RubbingDeviceReceiveResponse?> receiveDeviceForRubbing(String barcode,
      {RubbingModuleRoleType roleType = RubbingModuleRoleType.rubbing});

  Stream<GlassChangeFailReasonResponse?> getFailReasonList(RubbingModuleRoleType roleType);
}
