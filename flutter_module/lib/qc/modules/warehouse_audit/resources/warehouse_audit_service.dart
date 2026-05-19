import 'dart:convert';

import 'package:flutter_trc/qc/modules/warehouse_audit/resources/scan_device_response.dart';
import 'package:flutter_trc/src/services/qc_service.dart';

class WarehouseAuditService {
  static Stream<ScanDeviceData?> scanDeviceForAudit(int auditId, String deviceBarcode,
      {Map<String, String>? imagesListMap, bool isManualEntry = false}) {
    Map<String, dynamic> req = {
      "qrCode": deviceBarcode,
      "manualEntry": isManualEntry,
      if (imagesListMap != null) "mediaMap": imagesListMap,
    };
    String endPoint = imagesListMap == null ? "/warehouse-audit/app/scan/$auditId" : "/warehouse-audit/app/scan/$auditId/media";

    return QcService().post(endPoint, ScanDeviceData.fromJson, body: jsonEncode(req));
  }
}
