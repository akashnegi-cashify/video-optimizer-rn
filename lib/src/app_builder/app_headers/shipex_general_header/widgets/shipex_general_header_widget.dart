import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_trc/src/common/user/widget/user_profile_action_widget.dart';

import '../../../../common/user/widget/logout_action_widget.dart';
import '../../../../environments/environment_config.dart';
import '../../../../libraries/alice/csh_alice.dart';

class ShipexGeneralHeader extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool? showBackBtn;
  final PreferredSizeWidget? bottom;
  final List<Widget>? actions;
  final Widget? titleWidget;
  final bool? showLogoutButton;
  final bool? showProfileButton;

  const ShipexGeneralHeader(
    this.title, {
    Key? key,
    this.actions,
    this.bottom,
    this.showBackBtn = true,
    this.showLogoutButton = false,
    this.showProfileButton = false,
    this.titleWidget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> actionsList = [
      if (Validator.isTrue(environment?.enableAlice))
        CshIcon(
          FeatherIcons.info,
          iconColor: Colors.amber,
          iconSize: MobileIconSize.medium,
          padding: EdgeInsets.zero,
          onClick: () {
            CshAlice().alice?.showInspector();
          },
        ),
      if (Validator.isTrue(showLogoutButton)) const LogoutActionWidget(),
      if (Validator.isTrue(showProfileButton)) const UserProfileActionWidget(),
      if (!Validator.isListNullOrEmpty(actions)) ...actions!
    ];
    return CshHeader(
      title,
      showBackBtn: showBackBtn ?? true,
      bottom: bottom,
      actions: actionsList,
      child: titleWidget,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
