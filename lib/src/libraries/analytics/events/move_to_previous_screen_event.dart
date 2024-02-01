import 'package:flutter_trc/src/libraries/analytics/analytic_event_keys.dart';
import 'package:flutter_trc/src/libraries/analytics/analytic_event_params.dart';
import 'package:flutter_trc/src/libraries/analytics/events/common_events.dart';

class MoveToPreviousScreenEvent extends CommonEvents {
  final String deviceBarcode;

  MoveToPreviousScreenEvent(this.deviceBarcode);

  @override
  String getKey() {
    return AnalyticEventKeys.manualTesting.moveToPreviousScreen;
  }

  @override
  Future<Map<String, dynamic>?> getArguments() async {
    var arguments = await super.getArguments();
    arguments?[AnalyticEventParams.deviceBarcode] = deviceBarcode;
    return arguments;
  }
}
