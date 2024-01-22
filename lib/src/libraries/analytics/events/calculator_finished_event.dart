import 'package:calculator/calculator.dart';
import 'package:flutter_trc/src/libraries/analytics/analytic_event_keys.dart';
import 'package:flutter_trc/src/libraries/analytics/analytic_event_params.dart';
import 'package:flutter_trc/src/libraries/analytics/events/common_events.dart';

class CalculatorFinishedEvent extends CommonEvents {
  final String deviceBarcode;
  final QuoteRequestData metaData;

  CalculatorFinishedEvent(this.deviceBarcode, this.metaData);

  @override
  String getKey() {
    return AnalyticEventKeys.manualTesting.calFinished;
  }

  @override
  Future<Map<String, dynamic>?> getArguments() async {
    var arguments = await super.getArguments();
    arguments?[AnalyticEventParams.metaData] = metaData.toJson();
    arguments?[AnalyticEventParams.deviceBarcode] = deviceBarcode;
    return arguments;
  }
}
