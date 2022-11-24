import 'analytics_controller.dart';

abstract class BaseTrackingEvent {
  List<AnalyticTrackers> getTrackers();

  String getKey();

  Map<String, dynamic>? getArguments() {
    return null;
  }
}
