import 'package:core/core.dart';
import 'package:console_flutter_template/src/environments/environment_config.dart';
import 'package:console_flutter_template/src/environments/environments.dart';

import 'base_tracking_event.dart';

// TODO: Dev Action Required -> Update the analytics trackers in this file
enum AnalyticTrackers { FIRE_BASE, CASHIFY }

class AnalyticsController {
  static List<AnalyticTrackers> getTrackers() {
    List<AnalyticTrackers> trackers = [AnalyticTrackers.FIRE_BASE];
    if (AnalyticsController.sendEventToCashify()) {
      trackers.add(AnalyticTrackers.CASHIFY);
    }
    return trackers;
  }

  static bool sendEventToCashify() {
    var environment = getEnvironment();
    return (environment.mode == Environments.stage.mode || environment.mode == Environments.beta.mode);
  }

  static Future init(List<AnalyticTrackers>? trackers) {
    if (trackers == null || trackers.isEmpty) {
      Logger.log('There are no analytics to initialize.');
      return Future.value();
    }
    return Future.forEach(trackers, (dynamic tracker) async {
      switch (tracker) {
        case AnalyticTrackers.FIRE_BASE:
          // TODO initialize firebase
          // await FirebaseAnalyticsHelper.initialize();
          break;
        case AnalyticTrackers.CASHIFY:
        // TODO initialize cashify analytics
          // await CashifyAnalyticsHelper.init();
          break;
        default:
          Logger.log('Undefined analytics tracker.');
          break;
      }
    });
  }

  static void logEvent(BaseTrackingEvent event) {
    final trackers = event.getTrackers();
    if (trackers.isEmpty) {
      Logger.log('There are no analytics to log event.');
      return;
    }
    for (var tracker in trackers) {
      switch (tracker) {
        case AnalyticTrackers.FIRE_BASE:
          // FirebaseAnalyticsHelper.sendAnalyticsEvent(
          //     name: event.getKey(), parameters: event.getArguments());
          break;
        case AnalyticTrackers.CASHIFY:
          // CashifyAnalyticsHelper.sendAnalyticsEvent(name: event.getKey(), parameters: event.getArguments());
          break;
        default:
          Logger.log('Undefined analytics tracker.');
          break;
      }
    }
  }
}
