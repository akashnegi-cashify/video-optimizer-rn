import 'dart:convert';

import 'package:flutter_trc/qc/modules/gaurd/models/collected_order_list_response.dart';
import 'package:flutter_trc/qc/modules/gaurd/models/guard_entry_scan_response.dart';
import 'package:flutter_trc/src/services/qc_service.dart';

class GuardService {
  static Stream<GuardEntryScanResponse?> entryScanData(String? scannedBarcode) {
    var req = {"et": scannedBarcode};

    return QcService().post("/vendor/wh/entry/scan", GuardEntryScanResponse.fromJson, body: jsonEncode(req));
  }

  static Stream<CollectedOrderListResponse?> getCollectedOrderList() {
    return QcService().get("/collect-order/collected-orders", CollectedOrderListResponse.fromJson);
  }
}
