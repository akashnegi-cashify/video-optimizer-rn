import 'package:flutter_trc/src/libraries/analytics/analytic_event_keys.dart';
import 'package:flutter_trc/src/libraries/analytics/events/common_events.dart';

class CalculatorPageViewEvent extends CommonEvents {
  final int pageNo;
  final Map<String, List<int>> questionAnswerIds;

  CalculatorPageViewEvent(this.pageNo, this.questionAnswerIds);

  @override
  String getKey() {
    return "${AnalyticEventKeys.LOGIN}$pageNo";
  }

  @override
  Future<Map<String, dynamic>?> getArguments() async {
    var arguments = await super.getArguments();
    // arguments[] = questionAnswerIds;

    return arguments;
  }

}
