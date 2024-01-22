import 'package:flutter_trc/src/libraries/analytics/analytic_event_keys.dart';
import 'package:flutter_trc/src/libraries/analytics/analytic_event_params.dart';
import 'package:flutter_trc/src/libraries/analytics/events/common_events.dart';

class AdditionalQuestionsSelectedEvent extends CommonEvents {
  final String? barcode;
  final List<String?>? selectedAdditionalQuestions;

  AdditionalQuestionsSelectedEvent(this.barcode, this.selectedAdditionalQuestions);

  @override
  String getKey() {
    return AnalyticEventKeys.manualTesting.additionalQuestionSelected;
  }

  @override
  String getSubordinateKey() {
    return AnalyticEventKeys.manualTesting.subOrdinateKey;
  }

  @override
  Future<Map<String, dynamic>?> getArguments() async {
    var arg = await super.getArguments();
    arg?[AnalyticEventParams.deviceBarcode] = barcode;
    arg?[AnalyticEventParams.additionalQuestions] = selectedAdditionalQuestions;
    return arg;
  }
}
