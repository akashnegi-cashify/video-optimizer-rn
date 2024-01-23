import 'dart:convert';

import 'package:flutter_trc/qc/modules/warehouse_audit/resources/ongoing_audit_response.dart';
import 'package:flutter_trc/qc/modules/warehouse_audit/resources/scan_device_response.dart';
import 'package:flutter_trc/src/services/qc_service.dart';

class WarehouseAuditService {
  static Stream<OnGoingAuditResponse?> getOngoingAuditList() {
    // String value = '{"success":true,"r_id":"c0286ca8-704d-4e56-bdd6-0a2c9d4fcb94","pm":353,"dt":[{"r_id":"c0286ca8-704d-4e56-bdd6-0a2c9d4fcb94","aid":1,"fn":"Dummy 0","s":1,"std":"Audit in Progres","rm":"Audit for facility 0","sd":1705862456092,"ed":1705948199092},{"r_id":"c0286ca8-704d-4e56-bdd6-0a2c9d4fcb94","aid":2,"fn":"Dummy 2","s":1,"std":"Audit in Progres","rm":"Audit for facility 0","sd":1705862456092,"ed":1705948199092},{"r_id":"c0286ca8-704d-4e56-bdd6-0a2c9d4fcb94","aid":3,"fn":"Dummy 3","s":1,"std":"Audit in Progres","rm":"Audit for facility 0","sd":1705862456092,"ed":1705948199092}],"tc":8,"s":true}';
    // return Stream.value(OnGoingAuditResponse.fromJson(jsonDecode(value)));
    return QcService().get("/warehouse-audit/list", OnGoingAuditResponse.fromJson);
  }

  static Stream<ScanDeviceResponse?> scanDeviceForAudit(int auditId, String deviceBarcode,
      {Map<String, String>? imagesListMap}) {
    Map<String, dynamic> req = {
      "qc": deviceBarcode,
      if (imagesListMap != null) "mm": imagesListMap,
    };
    String endPoint = imagesListMap == null ? "/warehouse-audit/scan/$auditId" : "/warehouse-audit/scan/$auditId/media";

    return QcService().post(endPoint, ScanDeviceResponse.fromJson, body: jsonEncode(req));
  }
}
