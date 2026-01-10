import 'dart:async';

import 'package:core/core.dart';
import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/qc/modules/warehouse_audit/resources/scan_device_response.dart';
import 'package:flutter_trc/qc/modules/warehouse_audit/resources/warehouse_audit_service.dart';
import 'package:provider/provider.dart';

class WarehouseAuditPerformProvider extends CshChangeNotifier {
  final int auditId;

  WarehouseAuditPerformProvider(this.auditId);

  static WarehouseAuditPerformProvider of(BuildContext context, {bool listen = true}) {
    return Provider.of<WarehouseAuditPerformProvider>(context, listen: listen);
  }

  Future<ScanDeviceData?> scanDevice(String deviceBarcode,
      {Map<String, String>? imagesListMap, bool isManualEntry = false}) {
    var completer = Completer<ScanDeviceData?>();
    WarehouseAuditService.scanDeviceForAudit(auditId, deviceBarcode,
            imagesListMap: imagesListMap, isManualEntry: isManualEntry)
        .listen((event) {
      completer.complete(event);
    }, onError: (error) {
      completer.completeError(ApiErrorHelper.getErrorMessage(error).toString());
    });

    return completer.future;
  }
}
