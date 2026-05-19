import 'package:flutter_trc/src/libraries/analytics/analytic_event_keys.dart';
import 'package:flutter_trc/src/libraries/analytics/analytic_event_params.dart';
import 'package:flutter_trc/src/libraries/analytics/events/common_events.dart';

class DeviceVerifyPopupEvent extends CommonEvents {
  final String barcode;
  final int? deviceCategory;

  DeviceVerifyPopupEvent(this.barcode, this.deviceCategory);

  @override
  String getSubordinateKey() {
    return AnalyticEventKeys.manualTesting.deviceVerifyPopup;
  }

  @override
  String getEventKey() {
    return AnalyticEventKeys.manualTesting.parentEventKey;
  }

  @override
  Future<Map<String, dynamic>?> getArguments() async {
    var arg = await super.getArguments();
    arg?[AnalyticEventParams.deviceBarcode] = barcode;
    arg?[AnalyticEventParams.deviceCategory] = deviceCategory;
    return arg;
  }
}
