import 'dart:convert';

import '../../../services/trc_service.dart';
import '../models/login_success_response.dart';

class TRCLoginService {
  static Stream<LoginSuccessResponse?> userLogin(String employeeCode, String password) {
    Map<String, dynamic> data = {
      "did": "null",
      "empCo": employeeCode,
      "ps": password,
      "version": 0,
    };
    var bodyData = jsonEncode(data);

    return TrcService()
        .post("/login", LoginSuccessResponse.fromJson, body: bodyData, authorization: true, userAuth: false);
  }
}
