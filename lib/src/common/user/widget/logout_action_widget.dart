import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_trc/src/common/user/user_util.dart';
import 'package:flutter_trc/src/libraries/shared_prefrences/app_prefrences.dart';
import 'package:flutter_trc/src/modules/login/resources/login_types.dart';
import 'package:flutter_trc/src/modules/login/screens/trc_and_qc_login_screen.dart';

class LogoutActionWidget extends StatelessWidget {
  const LogoutActionWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return GestureDetector(
      onTap: () async {
          UserUtil.applicationLogout(context);
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
