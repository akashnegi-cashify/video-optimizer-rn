import 'dart:convert';

import 'package:flutter_trc/qc/modules/warehouse_audit/resources/ongoing_audit_response.dart';
import 'package:flutter_trc/qc/modules/warehouse_audit/resources/scan_device_response.dart';
import 'package:flutter_trc/src/services/qc_service.dart';

class WarehouseAuditService {
  static Stream<OnGoingAuditResponse?> getOngoingAuditList() {
    return QcService().get("/warehouse-audit/list", OnGoingAuditResponse.fromJson);
  }

  static Stream<ScanDeviceResponse?> scanDeviceForAudit(int auditId, String deviceBarcode,
      {Map<String, String>? imagesListMap, bool isManualEntry = false}) {
    Map<String, dynamic> req = {
      "qc": deviceBarcode,
      "me": isManualEntry,
      if (imagesListMap != null) "mm": imagesListMap,
    };
    String endPoint = imagesListMap == null ? "/warehouse-audit/scan/$auditId" : "/warehouse-audit/scan/$auditId/media";

    return QcService().post(endPoint, ScanDeviceResponse.fromJson, body: jsonEncode(req));
  }
}
