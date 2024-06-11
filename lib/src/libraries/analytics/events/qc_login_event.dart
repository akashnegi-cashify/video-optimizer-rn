import 'package:flutter_trc/src/libraries/analytics/analytic_event_keys.dart';
import 'package:flutter_trc/src/libraries/analytics/events/common_events.dart';

class QcLoginEvent extends CommonEvents {
  @override
  String getSubordinateKey() {
    return AnalyticEventKeys.common.qcLogin;
  }

  @override
  String getEventKey() {
    return AnalyticEventKeys.common.login;
  }
}
