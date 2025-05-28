import 'package:flutter_trc/src/modules/rubbing/model/glass_change_fail_reason_response.dart';
import 'package:flutter_trc/src/modules/rubbing/model/rubbing_device_receive_response.dart';

import '../../model/rubbing_devices_response.dart';
import '../../model/rubbing_done_response.dart';

mixin ReceivedDevicesInteractor {
  Stream<RubbingDevicesResponse?> getData(int pageIndex, int pageSize, String? query, {bool isGlassChange = false});

  Stream<RubbingDoneResponse?> markRubbing(String barcode, bool isDone,
      {bool isGlassChangeRole = false, String? partBarcode, String? selectedReason});

  Stream<RubbingDoneResponse?> attachBarcode(String barcode, String? partBarcode);

  Stream<RubbingDeviceReceiveResponse?> receiveDeviceForRubbing(String barcode, {bool isGlassChange = false});

  Stream<GlassChangeFailReasonResponse?> getGlassChangeFailReasonList();
}
