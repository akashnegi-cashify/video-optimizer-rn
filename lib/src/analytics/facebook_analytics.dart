import 'package:core/core.dart';
import 'package:facebook_app_events/facebook_app_events.dart';

class FacebookAnalyticsHelper {
  static FacebookAppEvents? _facebookAppEvents;

  static initialize() {
    _facebookAppEvents = FacebookAppEvents();
  }

  static Future<void> sendAnalyticsEvent({required String name, Map<String, dynamic>? parameters}) async {
    if (_facebookAppEvents == null) {
      Logger.debug('Call FirebaseHelper.initialize() before using sendAnalyticsEvent method. Called event: $name');
      return;
    }

    parameters!.forEach((key, value) {
      if (value == null) {
        parameters[key] = "null";
      }
    });

    await _facebookAppEvents!.logEvent(
      name: name,
      parameters: parameters,
    );

    Logger.log('FirebaseAnalytics -> Event name : $name Parameters: '
        '${parameters.toString()}');
  }
}
