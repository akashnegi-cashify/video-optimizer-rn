import 'package:flutter_trc/src/libraries/analytics/analytic_event_keys.dart';
import 'package:flutter_trc/src/libraries/analytics/analytic_event_params.dart';
import 'package:flutter_trc/src/libraries/analytics/events/common_events.dart';

class ProductSearchClickedEvent extends CommonEvents {
  final String barcode;
  final String? deviceCategory;
  final String? productName;
  final int? productId;

  ProductSearchClickedEvent({required this.barcode, this.deviceCategory, this.productName, this.productId});

  @override
  String getKey() {
    return AnalyticEventKeys.manualTesting.productSearchClicked;
  }

  @override
  String getSubordinateKey() {
    return AnalyticEventKeys.manualTesting.subOrdinateKey;
  }

  @override
  Future<Map<String, dynamic>?> getArguments() async {
    var arg = await super.getArguments();
    arg?[AnalyticEventParams.deviceBarcode] = barcode;
    arg?[AnalyticEventParams.deviceCategory] = deviceCategory;
    arg?[AnalyticEventParams.productName] = productName;
    arg?[AnalyticEventParams.productId] = productId;
    return arg;
  }
}
