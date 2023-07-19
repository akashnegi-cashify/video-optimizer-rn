import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/modules/login/screens/login_screen.dart';

import '../l10n.dart';

class TrcAndQcLoginWidget extends StatelessWidget {
  const TrcAndQcLoginWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var l10n = L10n(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: Dimens.space_20, horizontal: Dimens.space_16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Expanded(child: SizedBox()),
          Image.asset("assets/images/cashify_img.png"),
          const SizedBox(height: Dimens.space_50),
          SizedBox(
            width: double.infinity,
            child: CshMediumButton(
              text: l10n.trcLogin,
              onPressed: () {
                LoginScreenArguments args = LoginScreenArguments(isLoginFromQc: false);
                Navigator.of(context).pushNamed(LoginScreen.route, arguments: args);
              },
            ),
          ),
          const SizedBox(height: Dimens.space_20),
          SizedBox(
            width: double.infinity,
            child: CshMediumButton(
              text: l10n.qcLogin,
              onPressed: () {
                LoginScreenArguments args = LoginScreenArguments(isLoginFromQc: true);
                Navigator.of(context).pushNamed(LoginScreen.route, arguments: args);
              },
            ),
          ),
          const Expanded(child: SizedBox()),
        ],
      ),
    );
  }
}
