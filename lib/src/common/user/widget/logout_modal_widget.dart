import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import '../../../modules/elss/l10n.dart';

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
          Row(
            children: [
              Expanded(
                child: CshMediumButton(
                  text: l10n.cancel,
                  onPressed: () {
                    Navigator.of(context).pop(true);
                  },
                ),
              ),
              const SizedBox(width: Dimens.space_8),
              Expanded(
                child: CshMediumButton(
                  text: l10n.yes,
                  onPressed: () {
                    Navigator.pop(context);
                    if (onLogoutCallback != null) {
                      onLogoutCallback!();
                    }
                  },
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
