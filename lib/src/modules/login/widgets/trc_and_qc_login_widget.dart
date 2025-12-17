import 'package:components/auth/handler/auth_handler.dart';
import 'package:core/core.dart';
import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/common/version_updates/app_update_helper.dart';
import 'package:flutter_trc/src/environments/environment_config.dart';
import 'package:flutter_trc/src/libraries/firebase/remote_config_helper.dart';
import 'package:flutter_trc/src/libraries/shared_preferences/app_preferences.dart';
import 'package:flutter_trc/src/modules/login/resources/collector_user_controller.dart';
import 'package:flutter_trc/src/modules/login/resources/login_types.dart';
import 'package:flutter_trc/src/modules/login/screens/login_screen.dart';
import 'package:flutter_trc/src/resources/user_details.dart';

import '../l10n.dart';

class TrcAndQcLoginWidget extends StatelessWidget {
  const TrcAndQcLoginWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var l10n = L10n(context);
    var theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: Dimens.space_20, horizontal: Dimens.space_16),
      child: Column(
        children: [
          FutureBuilder(
            builder: (_, snapshot) {
              return Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset("assets/images/cashify_ops_logo.webp"),
                    const SizedBox(height: Dimens.space_50),
                    CshMediumButton(
                      text: l10n.trcLogin,
                      onPressed: () {
                        _checkAppUpdate(context, () {
                          _moveToLoginScreen(context, LoginTypes.trcLogin);
                        });
                      },
                    ),
                    const SizedBox(height: Dimens.space_20),
                    CshMediumButton(
                      text: l10n.qcLogin,
                      onPressed: () {
                        if (isIOS()) {
                          _moveToLoginScreen(context, LoginTypes.qcLogin);
                        } else {
                          _checkAppUpdate(context, () {
                            _moveToLoginScreen(context, LoginTypes.qcLogin);
                          });
                        }
                      },
                    ),
                    const SizedBox(height: Dimens.space_20),
                    CshMediumButton(
                      text: l10n.shipexLogin,
                      onPressed: () {
                        _checkAppUpdate(context, () {
                          _moveToLoginScreen(context, LoginTypes.shipexLogin);
                        });
                      },
                    ),
                    const SizedBox(height: Dimens.space_20),
                    CshMediumButton(
                      text: l10n.rmsLogin,
                      onPressed: () {
                        _checkAppUpdate(context, () {
                          _moveToLoginScreen(context, LoginTypes.rmsLogin);
                        });
                      },
                    ),
                  ],
                ),
              );
            },
            future: RemoteConfigHelper().fetchAndActivate(),
          ),
          Text("App Version - ${environment?.appVersion}",
              textAlign: TextAlign.center, style: theme.primaryTextTheme.titleSmall),
        ],
      ),
    );
  }

  _moveToLoginScreen(BuildContext context, LoginTypes loginType) {
    if (loginType != LoginTypes.qcLogin || Validator.isNullOrEmpty(AppPreferences.qc.getUserAuth())) {
      /// Handle non-QC login or empty auth case
      LoginScreenArguments args = LoginScreenArguments(loginType: loginType);
      Navigator.of(context).pushNamed(LoginScreen.route, arguments: args);
      return;
    }
    /// Handle valid QC login case
    String userAuth = AppPreferences.qc.getUserAuth()!;
    AuthHandler().setUserAuth(userAuth);
    UserDetails().setUserDetailsDataTemp(userAuth);
    UserRoles.navigateToUserRoleScreen(context, UserDetails().userDetailsData?.listOfRoles ?? [],
        loginType: LoginTypes.qcLogin);
  }

  void _checkAppUpdate(BuildContext context, VoidCallback onProceed) {
    AppUpdateHelper.checkAppVersion(
      context,
      onProceed: () {
        onProceed();
      },
    );
  }
}
