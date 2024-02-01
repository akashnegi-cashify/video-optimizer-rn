import 'package:flutter_trc/src/libraries/analytics/analytic_event_keys.dart';
import 'package:flutter_trc/src/libraries/analytics/analytic_event_params.dart';
import 'package:flutter_trc/src/libraries/analytics/events/common_events.dart';

class UpdateDeviceCategoryEvent extends CommonEvents {
  final String barcode;
  final String? previousDeviceCategory;
  final String? updatedDeviceCategory;

  UpdateDeviceCategoryEvent(this.barcode, this.previousDeviceCategory, this.updatedDeviceCategory);

  @override
  String getKey() {
    return AnalyticEventKeys.manualTesting.updateDeviceCategory;
  }

  @override
  String getSubordinateKey() {
    return AnalyticEventKeys.manualTesting.subOrdinateKey;
  }

  @override
  Future<Map<String, dynamic>?> getArguments() async {
    var arg = await super.getArguments();
    arg?[AnalyticEventParams.deviceBarcode] = barcode;
    arg?[AnalyticEventParams.deviceCategory] = previousDeviceCategory;
    arg?[AnalyticEventParams.updateCategory] = updatedDeviceCategory;
    return arg;
  }
}
