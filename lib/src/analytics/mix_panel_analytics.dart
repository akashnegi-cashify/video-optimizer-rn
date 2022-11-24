import 'package:core/core.dart';
import 'package:mixpanel_flutter/mixpanel_flutter.dart';

class MixPanelAnalyticsHelper {
  static Mixpanel? _mixpanel;

  static init(String mixPanelToken, bool environmentModeCondition) async {
    _mixpanel = await Mixpanel.init(mixPanelToken, optOutTrackingDefault: false);
    _mixpanel?.setLoggingEnabled(environmentModeCondition);
    _fireAppStartEvent();
  }

  //App Start event to be added to this.
  static _fireAppStartEvent() {
    //Provider event to this function

    // final event = AppStartEvent();
    // sendAnalyticsEvent(
    //   name: event.getKey().key,
    //   properties: event.getArguments(AnalyticTrackers.MIX_PANEL),
    //   superProperties: event.getSuperArguments(AnalyticTrackers.MIX_PANEL),
    //   userProperties: event.getUserArguments(AnalyticTrackers.MIX_PANEL),
    //   incrementalProperties: event.getIncrementalProperties(AnalyticTrackers.MIX_PANEL),
    // );
  }

  static identify(String identity) {
    _mixpanel?.identify(identity);
  }

  // static identifyUser({required String phoneNo, String? name, String? email, int? gaUserId, String? uniqueReferralId}) {
  //   _mixpanel?.identify(phoneNo);
  //
  //   Map<String, dynamic> arguments = {};

  // arguments[AnalyticUserEventParams.RESERVED_PROP_EMAIL] = email;
  //
  // arguments[AnalyticUserEventParams.RESERVED_PROP_PHONE] = phoneNo;
  //
  // arguments[AnalyticUserEventParams.RESERVED_PROP_NAME] = name;
  //
  // arguments[AnalyticUserEventParams.USER_NAME.key] = name;
  //
  // arguments[AnalyticUserEventParams.USER_PHONE.key] = phoneNo;
  //
  // arguments[AnalyticUserEventParams.USER_EMAIL.key] = email;
  //
  // arguments[AnalyticUserEventParams.USER_REFERRAL_ID.key] = uniqueReferralId;
  //
  // arguments[AnalyticUserEventParams.USER_GA_ID.key] = gaUserId;

  //   setUserProperties(arguments);
  // }

  static Future<void> sendAnalyticsEvent(
      {required String name,
      Map<String, dynamic>? properties,
      Map<String, dynamic>? superProperties,
      Map<String, dynamic>? userProperties,
      Map<String, double?>? incrementalProperties}) async {
    if (_mixpanel == null) {
      Logger.error("Initialise mixpanel SDK before using it");
      return;
    }
    if (userProperties != null) setUserProperties(userProperties);

    if (incrementalProperties != null) setIncrementalProperties(incrementalProperties);

    if (superProperties != null) setSuperProperties(superProperties);

    _mixpanel?.track(name, properties: properties);
  }

  static setSuperProperties(Map<String, dynamic>? superProperties) async {
    if (superProperties != null) {
      _mixpanel?.registerSuperProperties(superProperties);
    }
  }

  static setUserProperties(Map<String, dynamic>? userProperties) {
    userProperties?.forEach((key, value) {
      _mixpanel?.getPeople().set(key, value);
    });
  }

  static setUserPropertiesOnce(Map<String, dynamic>? userProperties) {
    userProperties?.forEach((key, value) {
      _mixpanel?.getPeople().setOnce(key, value);
    });
  }

  static setIncrementalProperties(Map<String, double?>? userProperties) {
    userProperties?.forEach((key, value) {
      if (value != null) _mixpanel?.getPeople().increment(key, value);
    });
  }

  static startExperiment(String expName, String variantName) {
    _mixpanel?.track('\$experiment_started', properties: {'Experiment name': expName, 'Variant name': variantName});
  }
}
