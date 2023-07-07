import 'package:flutter_trc/src/environments/environment_config.dart';
import 'package:flutter_trc/src/resources/user_details.dart';
import 'package:flutter_trc/src/utils/device_info_util.dart';

import '../analytic_event_params.dart';
import '../analytics_controller.dart';
import '../base_tracking_event.dart';

abstract class CommonEvents extends BaseTrackingEvent {
  @override
  List<AnalyticTrackers> getTrackers() {
    return AnalyticsController.getTrackers();
  }

  @override
  Future<Map<String, dynamic>?> getArguments() async {
    Map<String, dynamic> argumentsMap = {};
    argumentsMap[AnalyticEventParams.HIT_TIMESTAMP] = DateTime.now().toString();
    argumentsMap[AnalyticEventParams.USER_ID] = UserDetails().userDetailsData?.uid;
    argumentsMap[AnalyticEventParams.APP_VERSION] = environment?.appVersion;
    argumentsMap[AnalyticEventParams.OS_VERSION] = DeviceInfoUtil.getOsVersion();
    argumentsMap[AnalyticEventParams.DEVICE_MODEL] = DeviceInfoUtil.getModelName();
    return argumentsMap;
  }
}
