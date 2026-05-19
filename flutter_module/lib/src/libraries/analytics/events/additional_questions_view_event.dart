import 'package:flutter_trc/src/libraries/analytics/analytic_event_keys.dart';
import 'package:flutter_trc/src/libraries/analytics/analytic_event_params.dart';
import 'package:flutter_trc/src/libraries/analytics/events/common_events.dart';

class AdditionalQuestionsViewEvent extends CommonEvents {
  final String? barcode;

  AdditionalQuestionsViewEvent(this.barcode);

  @override
  String getSubordinateKey() {
    return AnalyticEventKeys.manualTesting.additionalQuestionView;
  }

  @override
  String getEventKey() {
    return AnalyticEventKeys.manualTesting.parentEventKey;
  }

  @override
  Future<Map<String, dynamic>?> getArguments() async {
    var arg = await super.getArguments();
    arg?[AnalyticEventParams.deviceBarcode] = barcode;
    return arg;
  }
}
