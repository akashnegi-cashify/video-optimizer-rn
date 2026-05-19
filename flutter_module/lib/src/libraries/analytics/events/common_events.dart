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
  String getEventKey() {
    return getSubordinateKey();
  }

  @override
  Future<Map<String, dynamic>?> getArguments() async {
    Map<String, dynamic> argumentsMap = {};
    argumentsMap[AnalyticEventParams.hitTimeStamp] = DateTime.now().toString();
    argumentsMap[AnalyticEventParams.userId] = UserDetails().consoleUserDetail?.empcode;
    argumentsMap[AnalyticEventParams.appVersion] = environment?.appVersion;
    argumentsMap[AnalyticEventParams.osVersion] = DeviceInfoUtil.getOsVersion();
    argumentsMap[AnalyticEventParams.deviceModel] = DeviceInfoUtil.getModelName();
    return argumentsMap;
  }
}
