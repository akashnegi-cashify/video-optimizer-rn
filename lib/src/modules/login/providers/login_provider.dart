import 'dart:async';

import 'package:components/auth/handler/auth_handler.dart';
import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/libraries/shared_prefrences/app_prefrences.dart';
import 'package:flutter_trc/src/resources/user_details.dart';
import 'package:provider/provider.dart';

import '../../../utils/trc_method_channels.dart';
import '../models/send_otp_response.dart';
import '../resources/collector_user_controller.dart';
import '../resources/login_service.dart';
import '../resources/qc_service.dart';

class TRCLoginProvider extends CshChangeNotifier {
  Timer? timer;
  int start = 30;
  bool isTimerStared = false;
  bool isActiveResendOtp = false;
  SendOTPResponse? otpResponse;

  static TRCLoginProvider of(BuildContext context, {bool listen = true}) {
    return Provider.of<TRCLoginProvider>(context, listen: listen);
  }

  Future<String> userLogin(String employeeId, String password, String location) async {
    var completer = Completer<String>();
    try {
      String? deviceId = await DeviceUtil.getDeviceId();
      TRCLoginService.userLogin(employeeId, password, location, deviceId).listen((event) async {
        var token = event?.data?.token;
        if (!Validator.isNullOrEmpty(token)) {
          AuthHandler().setUserAuth(token!);
          UserDetails().setUserDetailsData(token);
          completer.complete(token);
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

  Future<String> qcSendOTP(String mobileNumber, String notificationType, {bool? loginForShipex = false}) {
    var completer = Completer<String>();
    try {
      QcServiceElss.sendOtp(mobileNumber, Validator.isTrue(loginForShipex) ? "supersales-oms" : "qc", "v1",
              notificationType, "on_site")
          .listen((event) {
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

  Future<bool> authenticateSentOTP(BuildContext context, String mobileNumber, String notificationType, String otp,
      String referenceId, bool loginFromQc,
      {bool? loginForShipex = false}) {
    var completer = Completer<bool>();
    try {
      QcServiceElss.authenticateOTP(mobileNumber, Validator.isTrue(loginForShipex) ? "supersales-oms" : "qc", "v1",
              notificationType, "on_site", otp, referenceId)
          .listen((event) async {
        if (event != null) {
          if (!Validator.isNullOrEmpty(event.accessToken)) {
            AuthHandler().setUserAuth(event.accessToken!);
            UserDetails().setUserDetailsData(event.accessToken!);
            if (Validator.isTrue(loginFromQc)) {
              AppPreferences().setIsLoginFromQC(true);
              await UserRoles.navigateToUserRoleScreen(context, UserDetails().userDetailsData?.listOfRoles ?? [],
                  loginToken: event.accessToken!, loginFromQC: true, loginFromShipex: false);
            } else if (Validator.isTrue(loginForShipex)) {
              AppPreferences().setIsLoginFromShipex(true);
              await UserRoles.navigateToUserRoleScreen(context, UserDetails().userDetailsData?.listOfRoles ?? [],
                  loginToken: event.accessToken!, loginFromQC: false, loginFromShipex: true);
            }

            if (mounted) {
              await NativeCall.registerLogout(context);
            }
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
}
