import 'package:core/core.dart';
import 'package:flutter_trc/src/libraries/analytics/cashify/cashify_analytics_helper.dart';

import 'base_tracking_event.dart';

enum AnalyticTrackers { FIRE_BASE, CASHIFY }

class AnalyticsController {
  static List<AnalyticTrackers> getTrackers() {
    List<AnalyticTrackers> trackers = [AnalyticTrackers.CASHIFY];
    return trackers;
  }

  static Future init() {
    var trackers = getTrackers();
    return Future.forEach(trackers, (dynamic tracker) async {
      switch (tracker) {
        case AnalyticTrackers.CASHIFY:
          await CashifyAnalyticsHelper.init();
          break;
        default:
          Logger.log('Undefined analytics tracker. $tracker');
          break;
      }
    });
  }

  static Future<void> logEvent(BaseTrackingEvent event) async {
    final trackers = event.getTrackers();
    if (trackers.isEmpty) {
      Logger.log('There are no analytics to log event.');
      return;
    }

    var arguments = await event.getArguments();

    for (var tracker in trackers) {
      switch (tracker) {
        case AnalyticTrackers.FIRE_BASE:
          // FirebaseAnalyticsHelper.sendAnalyticsEvent(name: event.getKey(), parameters: arguments);
          break;
        case AnalyticTrackers.CASHIFY:
          // CashifyAnalyticsHelper.sendAnalyticsEvent(
          //     subOrdinateKey: event.getSubordinateKey(), eventName: event.getEventKey(), parameters: arguments);
          break;
        default:
          Logger.log('Undefined analytics tracker.');
          break;
      }
    }
  }
}
