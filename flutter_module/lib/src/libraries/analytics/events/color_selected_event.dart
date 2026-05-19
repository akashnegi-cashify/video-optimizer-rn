import 'package:flutter_trc/src/libraries/analytics/analytic_event_keys.dart';
import 'package:flutter_trc/src/libraries/analytics/analytic_event_params.dart';
import 'package:flutter_trc/src/libraries/analytics/events/common_events.dart';

class ColorSelectedEvent extends CommonEvents {
  final String? barcode;
  final String? selectedColor;

  ColorSelectedEvent(this.barcode, this.selectedColor);

  @override
  String getSubordinateKey() {
    return AnalyticEventKeys.manualTesting.colorSelected;
  }

  @override
  String getEventKey() {
    return AnalyticEventKeys.manualTesting.parentEventKey;
  }

  @override
  Future<Map<String, dynamic>?> getArguments() async {
    var arg = await super.getArguments();
    arg?[AnalyticEventParams.deviceBarcode] = barcode;
    arg?[AnalyticEventParams.selectedColor] = selectedColor;
    return arg;
  }
}
