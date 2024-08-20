import 'package:components/auth/handler/auth_handler.dart';
import 'package:components/auth/providers/login_provider.dart';
import 'package:components/auth/types.dart';
import 'package:components/auth/widget/login/login_widget.dart';
import 'package:core/core.dart';
import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/libraries/shared_prefrences/app_prefrences.dart';
import 'package:flutter_trc/src/modules/login/resources/collector_user_controller.dart';
import 'package:flutter_trc/src/modules/login/resources/login_types.dart';
import 'package:flutter_trc/src/resources/user_details.dart';
import 'package:provider/provider.dart';
import '../l10n.dart';

class RmsLoginWidget extends StatefulWidget {
  const RmsLoginWidget({super.key});

  @override
  State<RmsLoginWidget> createState() => _RmsLoginWidgetState();
}

class _RmsLoginWidgetState extends State<RmsLoginWidget> {
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
            enterMobileNumberTitle: "RMS Login",
            companyName: "cashify",
            isCompanyNameEditable: true,
            enterMobileNumberSubTitle : l10n.pleaseEnterCredentials,
            mfaBypassClientId: "sales-rms:epoch",
            versionNumber: "",
            loginType: LoginType.mobile,
            onSubmit: (userAuth, mobileNumber, mode, pin, {companyKey}) async {
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
              AuthHandler().setUserAuth(userAuth!);
              UserDetails().setUserDetailsData(userAuth);
              AppPreferences().setLoginType(LoginTypes.rmsLogin.value);
              await UserRoles.navigateToUserRoleScreen(context, UserDetails().userDetailsData?.listOfRoles ?? [],
                  loginToken: userAuth, loginType: LoginTypes.rmsLogin);
            }),
      ),
    );
  }
}
