import 'package:flutter_trc/src/libraries/analytics/analytic_event_keys.dart';
import 'package:flutter_trc/src/libraries/analytics/analytic_event_params.dart';
import 'package:flutter_trc/src/libraries/analytics/events/common_events.dart';

class CalculatorPageViewEvent extends CommonEvents {
  final int pageNo;
  final String deviceBarcode;
  final Map<String, List<int>> questionAnswerIds;

  CalculatorPageViewEvent(this.deviceBarcode, this.pageNo, this.questionAnswerIds);

  @override
  String getKey() {
    String eventName = "${AnalyticEventKeys.manualTesting.calWithPageNo}${pageNo}_view";
    return eventName;
  }

  @override
  Future<Map<String, dynamic>?> getArguments() async {
    var arguments = await super.getArguments();
    arguments?[AnalyticEventParams.metaData] = questionAnswerIds;
    arguments?[AnalyticEventParams.deviceBarcode] = deviceBarcode;
    return arguments;
  }
}
