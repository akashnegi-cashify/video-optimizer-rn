import 'dart:async';

import 'package:components/auth/handler/auth_handler.dart';
import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/libraries/shared_prefrences/app_prefrences.dart';
import 'package:flutter_trc/src/resources/user_details.dart';
import 'package:provider/provider.dart';

import '../../../utils/trc_method_channels.dart';
import '../resources/collector_user_controller.dart';
import '../resources/login_service.dart';
import '../resources/qc_service.dart';

class TRCLoginProvider extends CshChangeNotifier {
  static TRCLoginProvider of(BuildContext context, {bool listen = true}) {
    return Provider.of<TRCLoginProvider>(context, listen: listen);
  }

  Future<bool> userLogin(String employeeId, String password, BuildContext context) {
    var completer = Completer<bool>();
    try {
      TRCLoginService.userLogin(employeeId, password).listen((event) async {
        if (event != null) {
          if (!Validator.isNullOrEmpty(event.data?.token)) {
            AuthHandler().setUserAuth(event.data!.token!);
            UserDetails().setUserDetailsData(event.data!.token!);

            await UserRoles.navigateToUserRoleScreen(context, UserDetails().userDetailsData?.listOfRoles ?? [],
                loginToken: event.data?.token!, loginFromQC: false);
            if (mounted) {
              await NativeCall.registerLogout(context);
            }
          }
          completer.complete(true);
        } else {
          completer.complete(false);
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
      QcService.sendOtp(mobileNumber, "qc", "v1", notificationType, "on_site").listen((event) {
        if (event != null) {
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
      String referenceId, bool loginFromQc) {
    var completer = Completer<bool>();
    try {
      QcService.authenticateOTP(mobileNumber, "qc", "v1", notificationType, "on_site", otp, referenceId).listen(
          (event) async {
        if (event != null) {
          if (!Validator.isNullOrEmpty(event.accessToken)) {
            AuthHandler().setUserAuth(event.accessToken!);
            UserDetails().setUserDetailsData(event.accessToken!);
            AppPreferences().setIsLoginFromQC(true);

            await UserRoles.navigateToUserRoleScreen(context, UserDetails().userDetailsData?.listOfRoles ?? [],
                loginToken: event.accessToken!, loginFromQC: true);
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
}
