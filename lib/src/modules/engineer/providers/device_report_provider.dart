import 'dart:async';
import 'dart:convert';

import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/modules/engineer/models/device_report_response.dart';
import 'package:provider/provider.dart';

class DeviceReportProvider extends CshChangeNotifier {
  static DeviceReportProvider of(BuildContext context, {bool listen = true}) {
    return Provider.of<DeviceReportProvider>(context, listen: listen);
  }

  String? deviceId;

  DeviceReportProvider(this.deviceId);

  Future<DeviceReportData> getDeviceReport() {
    DeviceReportResponse value = DeviceReportResponse.fromJson(jsonDecode(
        '{"r_id":"83799d40-8517-4c71-8723-9abb8970a940","dt":{"dr":[{"pn":"SIM Tray","vn":"Sim Tray Available","id":4622,"isFail":true},{"pn":"FC Image Blurred?","vn":"FC Image is Not Blurred","id":4635,"isFail":true},{"pn":" S Pen","vn":"S Pen Not Available","id":4640,"isFail":true},{"pn":"Battery Health","vn":"Battery health above 80%","id":4649,"isFail":true}],"tr":"test123"},"s":true}'));
    return Future.value(value.deviceReportData);
  }
//   Future<DeviceReportData> getDeviceReport() {
//   var completer = Completer<DeviceReportData>();
//   EngineerAPIService.getDeviceReport(deviceId).listen((event) {
//     if (event?.deviceReportData == null) {
//       completer.completeError("No data found");
//       return;
//     }
//     completer.complete(event!.deviceReportData);
//   }, onError: (error) {
//     completer.completeError(ApiErrorHelper.getErrorMessage(error).toString());
//   });
//   return completer.future;
// }
}
