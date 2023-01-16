import 'package:flutter_trc/src/modules/rubbing/model/rubbing_device_receive_response.dart';

import '../../model/rubbing_devices_response.dart';
import '../../model/rubbing_done_response.dart';

mixin ReceivedDevicesInteractor {
  Stream<RubbingDevicesResponse?> getData(int pageIndex, int pageSize, String? searchQuery);

  Stream<RubbingDoneResponse?> markRubbing(String barcode, bool rubbing);

  Stream<RubbingDeviceReceiveResponse?> receiveDeviceForRubbing(String barcode);
}
