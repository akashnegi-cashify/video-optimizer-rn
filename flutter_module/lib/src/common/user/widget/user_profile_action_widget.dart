import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_trc/src/common/user/widget/user_profile_screen.dart';

class UserProfileActionWidget extends StatelessWidget {
  const UserProfileActionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return GestureDetector(
      onTap: () async {
        Navigator.pushNamed(context, UserProfileScreen.route);
      },
      child: CshIcon(
        FeatherIcons.user,
        iconSize: MobileIconSize.medium,
        padding: EdgeInsets.zero,
        iconColor: theme.primaryColor,
      ),
    );
  }
}
