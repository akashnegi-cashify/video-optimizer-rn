import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_trc/src/common/user/user_util.dart';

class LogoutActionWidget extends StatelessWidget {
  const LogoutActionWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return GestureDetector(
      onTap: () async {
        UserUtil.switchAppModule(context);
      },
      child: CshIcon(
        FeatherIcons.logOut,
        iconSize: MobileIconSize.medium,
        padding: EdgeInsets.zero,
        iconColor: theme.primaryColor,
      ),
    );
  }
}
