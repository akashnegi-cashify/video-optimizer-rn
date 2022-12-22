import 'dart:async';
import 'dart:convert';

import 'package:components/auth/handler/auth_handler.dart';
import 'package:core/core.dart';
import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/resources/user_details.dart';
import 'package:flutter_trc/src/utils/app_constants.dart';
import 'package:provider/provider.dart';

import '../../../resources/models/send_native_data.dart';
import '../../../utils/trc_method_channels.dart';
import '../resources/collector_user_controller.dart';
import '../resources/login_service.dart';

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
                loginToken: event.data?.token!);
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
}
