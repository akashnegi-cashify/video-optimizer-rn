import 'package:flutter_trc/src/libraries/analytics/analytic_event_keys.dart';
import 'package:flutter_trc/src/libraries/analytics/analytic_event_params.dart';
import 'package:flutter_trc/src/libraries/analytics/events/common_events.dart';

class ScanManualTestBarcodeEvent extends CommonEvents {
  final String barcode;

  ScanManualTestBarcodeEvent(this.barcode);

  @override
  String getKey() {
    return AnalyticEventKeys.manualTesting.scanManualTestBarcode;
  }

  @override
  String getSubordinateKey() {
    return AnalyticEventKeys.manualTesting.subOrdinateKey;
  }

  @override
  Future<Map<String, dynamic>?> getArguments() async {
    var arg = await super.getArguments();
    arg?[AnalyticEventParams.deviceBarcode] = barcode;
    return arg;
  }
}
