import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/common/version_updates/app_update_helper.dart';
import 'package:flutter_trc/src/environments/environment_config.dart';
import 'package:flutter_trc/src/libraries/firebase/remote_config_helper.dart';
import 'package:flutter_trc/src/modules/login/resources/login_types.dart';
import 'package:flutter_trc/src/modules/login/screens/login_screen.dart';

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
                          LoginScreenArguments args = LoginScreenArguments(loginType: LoginTypes.trcLogin);
                          Navigator.of(context).pushNamed(LoginScreen.route, arguments: args);
                        });
                      },
                    ),
                    const SizedBox(height: Dimens.space_20),
                    CshMediumButton(
                      text: l10n.qcLogin,
                      onPressed: () {
                        _checkAppUpdate(context, () {
                          LoginScreenArguments args = LoginScreenArguments(loginType: LoginTypes.ocLogin);
                          Navigator.of(context).pushNamed(LoginScreen.route, arguments: args);
                        });
                      },
                    ),
                    const SizedBox(height: Dimens.space_20),
                    CshMediumButton(
                      text: l10n.shipexLogin,
                      onPressed: () {
                        _checkAppUpdate(context, () {
                          LoginScreenArguments args = LoginScreenArguments(loginType: LoginTypes.shipexLogin);
                          Navigator.of(context).pushNamed(LoginScreen.route, arguments: args);
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
              textAlign: TextAlign.center, style: theme.primaryTextTheme.subtitle2),
        ],
      ),
    );
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
