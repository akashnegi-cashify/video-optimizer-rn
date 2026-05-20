import 'dart:async';

import 'package:core/core.dart';
import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/libraries/analytics/analytics_controller.dart';
import 'package:flutter_trc/src/libraries/analytics/events/qc_login_event.dart';
import 'package:flutter_trc/src/libraries/shared_preferences/app_preferences.dart';
import 'package:flutter_trc/src/modules/login/resources/login_types.dart';
import 'package:flutter_trc/src/resources/user_details.dart';
import 'package:provider/provider.dart';

import '../../elss/common_resources/elss_service.dart';
import '../models/send_otp_response.dart';
import '../resources/collector_user_controller.dart';
import '../resources/login_service.dart';

class TRCLoginProvider extends CshChangeNotifier {
  Timer? timer;
  int start = 30;
  bool isTimerStared = false;
  bool isActiveResendOtp = false;
  SendOTPResponse? otpResponse;

  static TRCLoginProvider of(BuildContext context, {bool listen = true}) {
    return Provider.of<TRCLoginProvider>(context, listen: listen);
  }

  Future<void> userLogin(String employeeId, String password, String location) async {
    var completer = Completer<void>();
    try {
      String? deviceId = await DeviceUtil.getDeviceId();
      TRCLoginService.userLogin(employeeId, password, location, deviceId).listen((event) async {
        var token = event?.data?.token;
        if (!Validator.isNullOrEmpty(token)) {
          AppPreferences.app.saveAuthToken(token!);
          UserDetails().setUserDetailsDataTemp(token);
          AppPreferences.app.setLoginType(LoginTypes.trcLogin.value);
          completer.complete();
        }
      }, onError: (error) {
        String errorMessage = ApiErrorHelper.getErrorMessage(error) ?? "Something Went Wrong!!";
        completer.completeError(errorMessage);
      }, onDone: () {
        notifyListeners();
      });
    } catch (e) {
      completer.completeError(e.toString());
    }
    return completer.future;
  }

  Future<String> qcSendOTP(String mobileNumber, String notificationType) {
    var completer = Completer<String>();
    try {
      ElssService.sendOtp(mobileNumber, "qc", "v1", notificationType, "on_site").listen((event) {
        if (event != null) {
          otpResponse = event;
          startTimer();
          completer.complete(event.requestId ?? "");
        } else {
          completer.completeError("Something Went Wrong");
        }
      }, onError: (error) {
        String errorMessage = ApiErrorHelper.getErrorMessage(error) ?? "Something went wrong";
        completer.completeError(errorMessage);
      }, onDone: () {
        notifyListeners();
      });
    } catch (e) {
      completer.completeError(e.toString());
    }
    return completer.future;
  }

  Future<bool> authenticateSentOTP(
      BuildContext context, String mobileNumber, String notificationType, String otp, String referenceId) {
    var completer = Completer<bool>();
    try {
      ElssService.authenticateOTP(mobileNumber, "qc", "v1", notificationType, "on_site", otp, referenceId).listen(
          (event) {
        if (event != null) {
          String? accessToken = event.accessToken;
          if (!Validator.isNullOrEmpty(accessToken)) {
            AppPreferences.app.saveAuthToken(accessToken!);
            UserDetails().setUserDetailsDataTemp(accessToken);
            AppPreferences.app.setLoginType(LoginTypes.qcLogin.value);
            _fireLoginAnalytics();
            UserRoles.navigateToUserRoleScreen(context, loginType: LoginTypes.qcLogin);
          }
          completer.complete(true);
        } else {
          completer.complete(false);
        }
      }, onError: (error) {
        String errorMessage = ApiErrorHelper.getErrorMessage(error) ?? "Something went wrong";
        completer.completeError(errorMessage);
      }, onDone: () {
        notifyListeners();
      });
    } catch (e) {
      completer.completeError(e.toString());
    }
    return completer.future;
  }

  @override
  void dispose() {
    super.dispose();
    if (timer != null && timer!.isActive) {
      timer!.cancel();
    }
  }

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (start == 1) {
          timer.cancel();
          isActiveResendOtp = true;
        } else {
          start--;
        }
        notifyListeners();
      },
    );
  }

  void resetResendOtpButton() {
    isActiveResendOtp = false;
    start = 30;
    notifyListeners();
  }

  void resetSentOTPResponse() {
    if (timer != null) {
      timer!.cancel();
    }
    isActiveResendOtp = false;
    start = 30;

    otpResponse = null;
    notifyListeners();
  }

  void _fireLoginAnalytics() {
    AnalyticsController.logEvent(QcLoginEvent());
  }
}
