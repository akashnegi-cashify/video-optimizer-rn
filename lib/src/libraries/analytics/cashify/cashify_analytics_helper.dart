import 'dart:async';

import 'package:core/core.dart';
import 'package:flutter_trc/src/libraries/analytics/cashify/resources/cashify_analytics_service.dart';
import 'package:flutter_trc/src/libraries/analytics/cashify/resources/save_analytic_request.dart';
import 'package:flutter_trc/src/libraries/shared_prefrences/app_prefrences.dart';
import 'package:flutter_trc/src/modules/login/resources/login_types.dart';

typedef SaveEventFun = Function({required String eventName, String? subOrdinateKey, Map<String, dynamic>? parameters});

class CashifyAnalyticsHelper {
  static SaveEventFun? saveEvent;

  static Future<void> init() async {}

  static Future<void> sendAnalyticsEvent(
      {required String eventName, String? subOrdinateKey, Map<String, dynamic>? parameters}) async {
    var loginType = await AppPreferences().getLoginType();
    var loginTypeEnum = LoginTypes.fromValue(loginType ?? "");
    if (loginTypeEnum != LoginTypes.qcLogin) {
      return;
    }

    if (parameters != null) {
      parameters.forEach((key, value) {
        if (value == null) {
          parameters[key] = "null";
        }
      });
    }

    CashifyAnalyticsService.saveEvent(
            SaveAnalyticsRequest(eventName, subOrdinateKey ?? eventName, parameters: parameters))
        .timeout(const Duration(seconds: 2), onTimeout: (sink) {
      sink.addError(TimeoutException('The connection has timed out, Please try again!'));
      sink.close();
    }).listen((event) {
      Logger.debug(
          'CashifyAnalytics -> Event name : $eventName, Parameters: ${parameters != null ? parameters.toString() : null}');
    }, onError: (error) {
      String? errorMsg = ApiErrorHelper.getErrorMessage(error);
      Logger.log('CashifyAnalytics Error -> Event name : $eventName , error: $errorMsg');
    });
  }
}
