import 'package:core_widgets/core_widgets.dart';

import '../models/authenticate_otp_response.dart';
import '../models/send_otp_response.dart';

class QcServiceElss {
  static Stream<SendOTPResponse?> sendOtp(
      String mobileNumber, String serviceName, String serviceVersion, String notificationType, String at) {
    Map<String, List<String>> data = {
      "mn": [mobileNumber],
      "sern": [serviceName],
      "serv": [serviceVersion],
      "nt": [notificationType],
      "at": [at],
    };

    var headers = CasService().getHeaders(true);
    headers["content-type"] = "application/x-www-form-urlencoded";

    return CasService().post("/v1/auth/otp/send", SendOTPResponse.fromJson,
        params: data, authorization: true, userAuth: false, headers: headers);
  }

  static Stream<AuthenticateOTPResponse?>   authenticateOTP(String mobileNumber, String serviceName,
      String serviceVersion, String notificationType, String at, String otp, String rid) {
    Map<String, List<String>> data = {
      "mn": [mobileNumber],
      "sern": [serviceName],
      "serv": [serviceVersion],
      "nt": [notificationType],
      "rid": [rid],
      "otp": [otp],
      "at": [at],
    };
    var headers = CasService().getHeaders(true);
    headers["content-type"] = "application/x-www-form-urlencoded";

    return CasService()
        .post("/v1/auth/otp/authenticate", AuthenticateOTPResponse.fromJson, params: data, headers: headers);
  }


}
