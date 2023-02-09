import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import '../elss_trc/l10n.dart';

class LogoutModalWidget extends StatelessWidget {
  final Function()? onLogoutCallback;

  const LogoutModalWidget({
    Key? key,
    this.onLogoutCallback,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var l10n = L10n(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: Dimens.space_16, horizontal: Dimens.space_16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.logout,
            style: theme.primaryTextTheme.headline2,
          ),
          const SizedBox(height: Dimens.space_16),
          Text(
            l10n.doYouWantToLogout,
            style: theme.primaryTextTheme.bodyText1,
          ),
          const SizedBox(height: Dimens.space_30),
          ComboButton(
            firstBtnText: l10n.cancel,
            secondBtnText: l10n.yes,
            isFirstPrimary: true,
            firstBtnClick: () {
              Navigator.of(context).pop(true);
            },
            secondBtnClick: () {
              Navigator.pop(context);
              if (onLogoutCallback != null) {
                onLogoutCallback!();
              }
            },
            buttonType: ButtonType.mini,
          ),
        ],
      ),
    );
  }
}
