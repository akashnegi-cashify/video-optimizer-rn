import 'package:flutter_trc/src/services/qc_service.dart';

import '../../../../src/common/resources/device_dead_repair_reason_list_response.dart';

class QcActionServices {
  static Stream<DeviceDeadRepairReasonListResponse?> fetchRepairReasonList() {
    return QcService().get(
      '/repair/device/mark-repair/remark',
      DeviceDeadRepairReasonListResponse.fromJson,
    );
  }
}
