import 'dart:async';
import 'package:core/core.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';

class FirebaseAnalyticsHelper {
  static FirebaseAnalytics? _analytics;
  static FirebaseAnalyticsObserver? _observer;

  static Future<FirebaseApp> initialize(Future<void> initializationFunc) async {
    FirebaseApp app = await Firebase.initializeApp();
    _analytics = FirebaseAnalytics.instance;
    await initializationFunc;

    _observer = FirebaseAnalyticsObserver(analytics: _analytics!);
    return app;
  }

  static FirebaseAnalytics? get firebaseAnalytics {
    return _analytics;
  }

  static FirebaseAnalyticsObserver? get analyticsObserver {
    return _observer;
  }

  static Future<void> sendAnalyticsEvent({required String name, Map<String, dynamic>? parameters}) async {
    if (firebaseAnalytics == null) {
      print('Call FirebaseHelper.initialize() before using sendAnalyticsEvent method. Called event: $name');
      return;
    }

    parameters!.forEach((key, value) {
      if (value == null) {
        parameters[key] = "null";
      }
    });

    await firebaseAnalytics!.logEvent(
      name: name,
      parameters: parameters,
    );

    Logger.log('FirebaseAnalytics -> Event name : $name Parameters: '
        '${parameters.toString()}');
  }

  static Future<bool> setUserProperty(String name, String value) async {
    try {
      if (firebaseAnalytics != null) {
        await firebaseAnalytics!.setUserProperty(name: name, value: value);
        return Future.value(true);
      } else {
        return Future.value(false);
      }
    } catch (error) {
      return Future.value(false);
    }
  }

  static Future<bool> setCurrentLanguage(
      String languageCode, String keyForSelectedLanguage, Future<void> fetchActivated) {
    Completer<bool> completer = Completer();
    setUserProperty(keyForSelectedLanguage, languageCode).then((value) async {
      if (value) {
        await fetchActivated;
        completer.complete(true);
      } else {
        completer.complete(true);
      }
    }, onError: (error) {
      completer.complete(false);
    });
    return completer.future;
  }
}
