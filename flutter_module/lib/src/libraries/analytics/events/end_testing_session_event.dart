import 'package:flutter_trc/src/libraries/analytics/analytic_event_keys.dart';
import 'package:flutter_trc/src/libraries/analytics/analytic_event_params.dart';
import 'package:flutter_trc/src/libraries/analytics/events/common_events.dart';

class EndTestingSessionEvent extends CommonEvents {
  final String? barcode;
  final String? deviceGrade;

  EndTestingSessionEvent(this.barcode, this.deviceGrade);

  @override
  String getSubordinateKey() {
    return AnalyticEventKeys.manualTesting.endTestingSession;
  }

  @override
  String getEventKey() {
    return AnalyticEventKeys.manualTesting.parentEventKey;
  }

  @override
  Future<Map<String, dynamic>?> getArguments() async {
    var arg = await super.getArguments();
    arg?[AnalyticEventParams.deviceBarcode] = barcode;
    arg?[AnalyticEventParams.deviceGrade] = deviceGrade;
    return arg;
  }
}
