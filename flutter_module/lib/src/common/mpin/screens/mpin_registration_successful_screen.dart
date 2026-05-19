import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_trc/src/common/mpin/screens/mpin_login_screen.dart';

import '../l10n.dart';

class MPinRegistrationSuccessfulScreen extends StatelessWidget {
  static const route = '/mpin-registration-successful';

  const MPinRegistrationSuccessfulScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var customColor = theme.extension<CustomColors>() as CustomColors;
    var l10n = L10n(context);
    return PopScope(
      canPop: false,
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(Dimens.space_16),
                decoration: BoxDecoration(shape: BoxShape.circle, color: customColor.successColor.withAlpha(50)),
                child: CshIcon(
                  FeatherIcons.check,
                  iconColor: customColor.successColor,
                  iconSize: MobileIconSize.xxLarge,
                ),
              ),
              const SizedBox(height: Dimens.space_16),
              Text(
                "${l10n.registrationSuccessful}!",
                style: theme.primaryTextTheme.displayLarge,
              ),
              const SizedBox(height: Dimens.space_32),
              CshBigButton(
                text: l10n.login,
                width: const ButtonWidth(minWidth: 250, maxWidth: 300),
                onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(context, MPinLoginScreen.route, (route) => false);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
