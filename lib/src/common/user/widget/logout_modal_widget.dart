import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';

import '../../l10n.dart';

enum LogoutModalType { logout, switchUserModule }

class LogoutModalWidget extends StatelessWidget {
  final Function()? onLogoutCallback;
  final LogoutModalType type;

  const LogoutModalWidget({
    super.key,
    this.onLogoutCallback,
    this.type = LogoutModalType.switchUserModule,
  });

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
            type == LogoutModalType.switchUserModule ? l10n.switchUserModule : l10n.logout,
            style: theme.primaryTextTheme.displayMedium,
          ),
          const SizedBox(height: Dimens.space_16),
          Text(
            type == LogoutModalType.switchUserModule ? l10n.doYouWantToSwitchModule : l10n.doYouWantToLogout,
            style: theme.primaryTextTheme.bodyLarge,
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
