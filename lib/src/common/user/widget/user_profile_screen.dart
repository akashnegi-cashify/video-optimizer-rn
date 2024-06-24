import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/app_builder/app_headers/qc_general_header/widgets/qc_general_header.dart';
import 'package:flutter_trc/src/common/user/user_util.dart';
import 'package:flutter_trc/src/environments/environment_config.dart';
import 'package:flutter_trc/src/libraries/shared_prefrences/app_prefrences.dart';
import 'package:flutter_trc/src/modules/login/screens/trc_and_qc_login_screen.dart';
import 'package:flutter_trc/src/resources/user_details.dart';

class UserProfileScreen extends StatelessWidget {
  static const String route = "/user_profile_screen";

  const UserProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var userDetailsData = UserDetails().userDetailsData;
    return Scaffold(
      appBar: const QcGeneralHeader("Profile", showBackBtn: true, showLogoutButton: false, showProfileButton: false),
      body: Padding(
        padding: const EdgeInsets.all(Dimens.space_16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(Dimens.space_24),
                decoration: BoxDecoration(
                  border: Border.all(color: theme.primaryColor, width: 1),
                  borderRadius: BorderRadius.circular(Dimens.space_6),
                ),
                child: CshIcon(
                  Icons.person,
                  iconSize: MobileIconSize.xxLarge,
                  iconColor: theme.primaryColor,
                ),
              ),
              const SizedBox(height: Dimens.space_16),
              CshTextNew.h3('Welcome ${userDetailsData?.userName}'),
              const SizedBox(height: Dimens.space_16),
              Container(
                width: MediaQuery.of(context).size.width * 0.9,
                alignment: Alignment.center,
                padding: const EdgeInsets.all(Dimens.space_8),
                decoration: BoxDecoration(
                  border: Border.all(color: theme.primaryColor, width: 1),
                  borderRadius: BorderRadius.circular(Dimens.space_6),
                ),
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(text: 'Mobile No - ', style: theme.textTheme.bodyMedium),
                      TextSpan(text: '${userDetailsData?.mobileNumber}', style: theme.textTheme.titleSmall),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: Dimens.space_16),
              Container(
                width: MediaQuery.of(context).size.width * 0.9,
                alignment: Alignment.center,
                padding: const EdgeInsets.all(Dimens.space_8),
                decoration: BoxDecoration(
                  border: Border.all(color: theme.primaryColor, width: 1),
                  borderRadius: BorderRadius.circular(Dimens.space_6),
                ),
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(text: 'App Version - ', style: theme.textTheme.bodyMedium),
                      TextSpan(text: '${environment?.appVersion}', style: theme.textTheme.titleSmall),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: Dimens.space_16),
              Container(
                width: MediaQuery.of(context).size.width * 0.9,
                alignment: Alignment.center,
                padding: const EdgeInsets.all(Dimens.space_8),
                decoration: BoxDecoration(
                  border: Border.all(color: theme.primaryColor, width: 1),
                  borderRadius: BorderRadius.circular(Dimens.space_6),
                ),
                child: Row(
                  children: [
                    _buildPermissionWidget(context, userDetailsData?.listOfRoles ?? []),
                  ],
                ),
              ),
              const SizedBox(height: Dimens.space_16),
              CshBigButton(
                  text: "Logout",
                  onPressed: () async {
                    bool? loginFromShipex = await AppPreferences().getIsLoginFromShipex();
                    if (Validator.isTrue(loginFromShipex)) {
                      AppPreferences().resetAndClearAll();
                      Navigator.of(context).pushNamedAndRemoveUntil(TrcAndQcLoginScreen.route, (route) => false);
                    } else {
                      UserUtil.applicationLogout(context);
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }

  _buildPermissionWidget(BuildContext context, List<String> roleList) {
    var theme = Theme.of(context);
    var listWidget = List.generate(
      roleList.length,
      (index) => Chip(
        label: Text(roleList[index], style: theme.primaryTextTheme.bodySmall),
        backgroundColor: theme.primaryColor.withAlpha(50),
        elevation: 1,
        visualDensity: VisualDensity.compact,
      ),
    );
    return Expanded(child: Wrap(spacing: Dimens.space_8, children: listWidget));
  }
}
