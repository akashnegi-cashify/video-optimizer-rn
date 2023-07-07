import 'dart:async';

import 'package:core/core.dart';
import 'package:flutter_trc/src/libraries/analytics/cashify/resources/cashify_analytics_service.dart';
import 'package:flutter_trc/src/libraries/analytics/cashify/resources/save_analytic_request.dart';

class CashifyAnalyticsHelper {
  static Future<void> init() async {}

  static Future<void> sendAnalyticsEvent({required String name, Map<String, dynamic>? parameters}) async {
    if (parameters != null) {
      parameters.forEach((key, value) {
        if (value == null) {
          parameters[key] = "null";
        }
      });
    }

    CashifyAnalyticsService.saveEvent(SaveAnalyticsRequest(name, name, parameters: parameters))
        .timeout(const Duration(seconds: 2), onTimeout: (sink) {
      sink.addError(TimeoutException('The connection has timed out, Please try again!'));
      sink.close();
    }).listen((event) {
      Logger.debug(
          'CashifyAnalytics -> Event name : $name, Parameters: ${parameters != null ? parameters.toString() : null}');
    }, onError: (error) {
      String? errorMsg = ApiErrorHelper.getErrorMessage(error);
      Logger.log('CashifyAnalytics Error -> Event name : $name , error: $errorMsg');
    });
  }
}
