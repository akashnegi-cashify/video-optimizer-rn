import 'package:flutter_trc/src/common/calculator_analytics/calculator_question_answer_request.dart';
import 'package:flutter_trc/src/libraries/analytics/analytic_event_keys.dart';
import 'package:flutter_trc/src/libraries/analytics/analytic_event_params.dart';
import 'package:flutter_trc/src/libraries/analytics/events/common_events.dart';

class CalculatorAnswerSelectedEvent extends CommonEvents {
  final String? barcode;
  final List<CalculatorQuestionAnswerRequest>? questionAnswerRequest;
  final int pageNo;

  CalculatorAnswerSelectedEvent(this.barcode, this.pageNo, this.questionAnswerRequest);

  @override
  String getSubordinateKey() {
    String eventName = "${AnalyticEventKeys.manualTesting.calWithPageNo}$pageNo";
    return eventName;
  }

  @override
  String getEventKey() {
    return AnalyticEventKeys.manualTesting.parentEventKey;
  }

  @override
  Future<Map<String, dynamic>?> getArguments() async {
    var arg = await super.getArguments();
    arg?[AnalyticEventParams.deviceBarcode] = barcode;
    arg?[AnalyticEventParams.metaData] = questionAnswerRequest;
    return arg;
  }
}
