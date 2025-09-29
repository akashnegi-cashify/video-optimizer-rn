import 'analytics_controller.dart';

abstract class BaseTrackingEvent {
  List<AnalyticTrackers> getTrackers();

  String getSubordinateKey();

  String getEventKey();

  Future<Map<String, dynamic>?> getArguments() async {
    return null;
  }
}
