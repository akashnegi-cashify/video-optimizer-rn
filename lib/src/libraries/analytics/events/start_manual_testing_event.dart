import 'package:flutter_trc/src/libraries/analytics/analytic_event_keys.dart';
import 'package:flutter_trc/src/libraries/analytics/events/common_events.dart';

class StartManualTestingEvent extends CommonEvents {
  StartManualTestingEvent();

  @override
  String getKey() {
    return AnalyticEventKeys.manualTesting.startManualTesting;
  }

  @override
  String getSubordinateKey() {
    return AnalyticEventKeys.manualTesting.subOrdinateKey;
  }
}
