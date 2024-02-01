import 'package:flutter_trc/src/libraries/analytics/analytic_event_keys.dart';
import 'package:flutter_trc/src/libraries/analytics/analytic_event_params.dart';
import 'package:flutter_trc/src/libraries/analytics/events/common_events.dart';

class AutoSearchButtonClickedEvent extends CommonEvents {
  final String barcode;
  final String? deviceCategory;

  AutoSearchButtonClickedEvent(this.barcode, this.deviceCategory);

  @override
  String getKey() {
    return AnalyticEventKeys.manualTesting.autoSearchButtonClicked;
  }

  @override
  String getSubordinateKey() {
    return AnalyticEventKeys.manualTesting.subOrdinateKey;
  }

  @override
  Future<Map<String, dynamic>?> getArguments() async {
    var arg = await super.getArguments();
    arg?[AnalyticEventParams.deviceBarcode] = barcode;
    arg?[AnalyticEventParams.deviceCategory] = deviceCategory;
    return arg;
  }
}
