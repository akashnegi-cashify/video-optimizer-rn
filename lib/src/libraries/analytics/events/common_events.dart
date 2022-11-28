import '../../../interceptors/auth/request_headers.dart';
import '../advertiser_id_helper.dart';
import '../analytic_event_params.dart';
import '../analytics_controller.dart';
import '../base_tracking_event.dart';

abstract class CommonEvents extends BaseTrackingEvent {
  @override
  List<AnalyticTrackers> getTrackers() {
    return AnalyticsController.getTrackers();
  }

  @override
  Map<String, dynamic> getArguments() {
    Map<String, dynamic> argumentsMap = {};
    argumentsMap[AnalyticEventParams.PLATFORM] = AppHeaders.X_APP_VALUE;
    argumentsMap[AnalyticEventParams.DEVICE_ID] = AdvertiserIdHelper.getAdvertisingId();

    return argumentsMap;
  }
}
