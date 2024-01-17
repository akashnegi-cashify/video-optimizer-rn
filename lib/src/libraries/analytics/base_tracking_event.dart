import 'analytics_controller.dart';

abstract class BaseTrackingEvent {
  List<AnalyticTrackers> getTrackers();

  String getKey();

  Future<Map<String, dynamic>?> getArguments() async {
    return null;
  }
}
