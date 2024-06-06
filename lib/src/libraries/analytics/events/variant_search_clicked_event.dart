import 'package:flutter_trc/src/libraries/analytics/analytic_event_keys.dart';
import 'package:flutter_trc/src/libraries/analytics/analytic_event_params.dart';
import 'package:flutter_trc/src/libraries/analytics/events/common_events.dart';

class VariantSearchClickedEvent extends CommonEvents {
  final String barcode;
  final String? deviceCategory;
  final String? productName;
  final int? variantId;

  VariantSearchClickedEvent({required this.barcode, this.deviceCategory, this.productName, this.variantId});

  @override
  String getSubordinateKey() {
    return AnalyticEventKeys.manualTesting.variantSearchClicked;
  }

  @override
  String getEventKey() {
    return AnalyticEventKeys.manualTesting.parentEventKey;
  }

  @override
  Future<Map<String, dynamic>?> getArguments() async {
    var arg = await super.getArguments();
    arg?[AnalyticEventParams.deviceBarcode] = barcode;
    arg?[AnalyticEventParams.deviceCategory] = deviceCategory;
    arg?[AnalyticEventParams.productName] = productName;
    arg?[AnalyticEventParams.variantId] = variantId;
    return arg;
  }
}
