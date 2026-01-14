import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/rms/modules/home/screens/rms_home_screen.dart';
import 'package:flutter_trc/shipex/modules/shipex_home/screens/shipex_home_screen.dart';
import 'package:flutter_trc/src/app.dart';
import 'package:flutter_trc/src/common/mpin/screens/mpin_login_screen.dart';
import 'package:flutter_trc/src/common/mpin/screens/mpin_setup_screen.dart';
import 'package:flutter_trc/src/common/nps/dialog/show_nps_dialog.dart';
import 'package:flutter_trc/src/libraries/shared_preferences/app_preferences.dart';
import 'package:flutter_trc/src/modules/audit/screens/trc_audit_screen.dart';
import 'package:flutter_trc/src/modules/home/trc_home_screen_new.dart';
import 'package:flutter_trc/src/modules/l4/l4_home_screen.dart';
import 'package:flutter_trc/src/modules/login/resources/login_types.dart';
import 'package:flutter_trc/src/modules/store_manager/screens/store_manager_home_screen.dart';
import 'package:flutter_trc/src/modules/trc_executive/screens/trc_executive_screen.dart';
import 'package:flutter_trc/src/modules/trc_tester/trc_tester_screen.dart';
import 'package:flutter_trc/src/resources/user_details.dart';

import '../../elss/common_screen/elss_home_screen.dart';
import '../../engineer/widgets/engineer_home_widget.dart';
import '../../inventory_manager/screens/inventory_home_screen.dart';
import '../../part_qc/screens/pq_home_screen.dart';
import '../../rider/rider_home_screen.dart';
import '../../rubbing/widgets/rubbing_home_screen.dart';

class UserRoles {
  static const String ROLE_STORAGE_MANAGER = "STORAGE_MANAGER";
  static const String ROLE_INVENTORY_MANAGER = "INVENTORY_MANAGER";
  static const String ROLE_RIDER = "RIDER";
  static const String ROLE_QC = "PART_QC";
  static const String ROLE_RUNNER = "RUNNER";
  static const String ROLE_ENGINEER = "ENGINEER";
  static const String ROLE_L4 = "L4_ENGINEER";
  static const String ROLE_ELSS = "ELSS";
  static const String ROLE_RUBBING = "RUBBING_ENGINEER";
  static const String ROLE_GLASS_CHANGE = "GLASS_CHANGE_ENGINEER";
  static const String TRC_EXECUTIVE = "TRC_EXECUTIVE";
  static const String QC_ROLE = "QC_ROLE";
  static const String ROLE_TRC_AUDIT = "AUDITOR";

  static navigateToUserRoleScreen(BuildContext context, List<String> listOfRoles,
      {required LoginTypes loginType}) async {
    switch (loginType) {
      case LoginTypes.trcLogin:
        navigateToTrcRole(context, listOfRoles);
        break;
      case LoginTypes.qcLogin:
        String? savedPin = AppPreferences.qc.getQcMPin();
        if (Validator.isTrue(AppPreferences.qc.getIsBioMetricEnabled()) || !Validator.isNullOrEmpty(savedPin)) {
          Navigator.pushNamedAndRemoveUntil(context, MPinLoginScreen.route, (route) => false);
        } else {
          Navigator.pushNamedAndRemoveUntil(context, MPinSetupScreen.route, (route) => false);
        }
        break;
      case LoginTypes.shipexLogin:
        Navigator.of(context).pushNamedAndRemoveUntil(ShipexHomeScreen.route, (route) => false);
        break;
      case LoginTypes.rmsLogin:
        Navigator.of(context).pushNamedAndRemoveUntil(RmsHomeScreen.route, (route) => false);
        break;
    }
  }

  static navigateToTrcRole(BuildContext context, List<String> listOfRoles) {
    Future.delayed(Duration(seconds: 1), () {
      if (AppNavKey.navKey.currentState?.context != null) {
        showNpsDialog(AppNavKey.navKey.currentState!.context, LoginTypes.trcLogin);
      }
    });

    // Navigator.pushNamed(context, TrcHomeScreenNew.route);
    Navigator.pushNamedAndRemoveUntil(context, TrcHomeScreenNew.route, (route) => false);

    // if (listOfRoles.contains(UserRoles.ROLE_ELSS)) {
    //   ElssHomeScreenArguments args = ElssHomeScreenArguments(isLogicFromQC: false);
    //   Navigator.of(context).pushNamedAndRemoveUntil(ElssHomeScreen.route, (route) => false, arguments: args);
    // } else if (listOfRoles.contains(UserRoles.ROLE_RUBBING) || listOfRoles.contains(UserRoles.ROLE_GLASS_CHANGE)) {
    //   Navigator.of(context).pushNamedAndRemoveUntil(RubbingHomeScreen.route, (route) => false);
    // } else if (listOfRoles.contains(UserRoles.ROLE_ENGINEER)) {
    //   Navigator.of(context).pushNamedAndRemoveUntil(EngineerHomeScreen.route, (route) => false);
    // } else if (listOfRoles.contains(UserRoles.ROLE_RIDER)) {
    //   Navigator.of(context).pushNamedAndRemoveUntil(RiderHomeScreen.route, (route) => false);
    // } else if (listOfRoles.contains(UserRoles.ROLE_L4)) {
    //   Navigator.of(context).pushNamedAndRemoveUntil(L4HomeScreen.route, (route) => false);
    // } else if (listOfRoles.contains(UserRoles.ROLE_INVENTORY_MANAGER)) {
    //   Navigator.of(context).pushNamedAndRemoveUntil(InventoryHomeScreen.route, (route) => false);
    // } else if (listOfRoles.contains(UserRoles.ROLE_QC)) {
    //   Navigator.of(context).pushNamedAndRemoveUntil(PartQCHomeScreen.route, (route) => false);
    // } else if (listOfRoles.contains(UserRoles.TRC_EXECUTIVE)) {
    //   Navigator.of(context).pushNamedAndRemoveUntil(TRCExecutiveScreen.route, (route) => false);
    // } else if (listOfRoles.contains(UserRoles.QC_ROLE)) {
    //   Navigator.of(context).pushNamedAndRemoveUntil(TrcTesterScreen.route, (route) => false);
    // } else if (listOfRoles.contains(UserRoles.ROLE_STORAGE_MANAGER)) {
    //   Navigator.of(context).pushNamedAndRemoveUntil(StoreManagerHomeScreen.route, (route) => false);
    // } else if (listOfRoles.contains(UserRoles.ROLE_STORAGE_MANAGER)) {
    //   Navigator.of(context).pushNamedAndRemoveUntil(StoreManagerHomeScreen.route, (route) => false);
    // } else if (listOfRoles.contains(UserRoles.ROLE_TRC_AUDIT)) {
    //   Navigator.of(context).pushNamedAndRemoveUntil(TrcAuditScreen.route, (route) => false);
    // } else {
    //   CshSnackBar.error(
    //     context: context,
    //     message: "Assigned role - ${UserDetails().consoleUserDetail?.role} is not created for app",
    //     duration: SnackBarDuration.LONG,
    //     snackBarPosition: SnackBarPosition.TOP,
    //   );
    // }
  }
}
