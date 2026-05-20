import 'package:components/auth/providers/login_provider.dart';
import 'package:components/auth/types.dart';
import 'package:components/auth/widget/login/login_widget.dart';
import 'package:core/core.dart';
import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/libraries/shared_preferences/app_preferences.dart';
import 'package:flutter_trc/src/modules/login/resources/collector_user_controller.dart';
import 'package:flutter_trc/src/modules/login/resources/login_types.dart';
import 'package:flutter_trc/src/resources/user_details.dart';
import 'package:flutter_trc/src/utils/app_util.dart';
import 'package:provider/provider.dart';

import '../l10n.dart';

class ConsoleLoginWidget extends StatelessWidget {
  final LoginTypes loginType;

  const ConsoleLoginWidget(this.loginType, {super.key});

  @override
  Widget build(BuildContext context) {
    var l10n = L10n(context);
    return ChangeNotifierProvider(
      create: (_) => LoginProvider(false),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: Dimens.space_16),
        child: LoginWidget(
          serviceName: ServiceGroups.console.value,
          serviceVersion: "v1",
          enterMobileNumberTitle: _getTitle(),
          companyName: "cashify",
          otpEventKey: "otp_oms_event_active",
          isCompanyNameEditable: true,
          enterMobileNumberSubTitle: l10n.pleaseEnterCredentials,
          mfaBypassClientId: getClientId(),
          bypassMfa: true,
          // mfaBypassClientId: "sales-rms:epoch",
          versionNumber: "",
          loginType: loginType == LoginTypes.trcLogin || loginType == LoginTypes.qcLogin ? LoginType.email : LoginType.mobile,
          // loginType: LoginType.email,
          onSubmit: (userAuth, mode, mobileNumber, pin, {required companyKey, credential}) {
            Logger.debug('mydebug-----_RmsLoginWidgetState.build', [
              'userAuth',
              userAuth,
              'mobileNumber',
              mobileNumber,
              'mode',
              mode,
              'pin',
              pin,
              'companyKey',
              companyKey
            ]);
            AppPreferences.app.saveAuthToken(userAuth!);
            UserDetails().setUserDetailsData().then((value) {
              AppPreferences.app.setLoginType(loginType.value);
              UserRoles.navigateToUserRoleScreen(context, loginType: loginType);
            }, onError: (error) {
              CshSnackBar.error(context: context, message: error);
            });
          },
        ),
      ),
    );
  }

  String _getTitle() {
    switch (loginType) {
      case LoginTypes.trcLogin:
        return "TRC Login";
      case LoginTypes.qcLogin:
        return "QC Login";
      case LoginTypes.shipexLogin:
        return "Shipex Login";
      case LoginTypes.rmsLogin:
        return "RMS Login";
    }
  }
}
