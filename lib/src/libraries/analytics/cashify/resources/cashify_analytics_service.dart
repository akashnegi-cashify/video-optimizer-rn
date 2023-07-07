import 'dart:convert';

import 'package:flutter_trc/src/libraries/analytics/cashify/resources/save_analytic_request.dart';
import 'package:flutter_trc/src/libraries/analytics/cashify/resources/save_analytic_response.dart';
import 'package:flutter_trc/src/services/qc_service.dart';

class CashifyAnalyticsService {
  static Stream<SaveAnalyticsResponse?> saveEvent(SaveAnalyticsRequest request) {
    return QcService(addAuthorization: false).post(
      '/analytic/event/send',
      SaveAnalyticsResponse.fromJson,
      body: jsonEncode(request),
    );
  }
}
