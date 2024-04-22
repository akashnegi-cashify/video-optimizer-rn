import 'package:core/core.dart';
import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/qc/modules/qc_actions/qc_action_screen.dart';
import 'package:flutter_trc/shipex/modules/shipex_home/screens/shipex_home_screen.dart';
import 'package:flutter_trc/src/modules/l4/l4_home_screen.dart';
import 'package:flutter_trc/src/modules/store_manager/screens/store_manager_home_screen.dart';
import 'package:flutter_trc/src/modules/trc_executive/screens/trc_executive_screen.dart';
import 'package:flutter_trc/src/modules/trc_tester/trc_tester_screen.dart';

import '../../../amplify/amplify_provider.dart';
import '../../../resources/models/send_native_data.dart';
import '../../elss/common_screen/elss_home_screen.dart';
import '../../engineer/widgets/engineer_home_widget.dart';
import '../../inventory_manager/screens/inventory_home_screen.dart';
import '../../part_qc/screens/pq_home_screen.dart';
import '../../retrieved_part_qc/screens/retrieved_parts_qc_dashboard_screen.dart';
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
  static const String TRC_EXECUTIVE = "TRC_EXECUTIVE";
  static const String QC_ROLE = "QC_ROLE";

  static navigateToUserRoleScreen(BuildContext context, List<String> listOfRoles,
      {String? loginToken, bool? loginFromQC = false, bool? loginFromShipex = false}) async {
    var amplifyPro = AmplifyProvider.of(context, listen: false);
    if (Validator.isTrue(loginFromShipex)) {
      Navigator.of(context).pushNamedAndRemoveUntil(ShipexHomeScreen.route, (route) => false);
    } else if (loginFromQC == true) {
      amplifyPro.getS3DetailsForQcAndConfigAmplify();
      Navigator.of(context).pushNamedAndRemoveUntil(QcActionScreen.route, (route) => false);
    } else {
      amplifyPro.getS3DetailsForTrcAndConfigureAmplify();
      if (listOfRoles.contains(UserRoles.ROLE_ELSS)) {
        ElssHomeScreenArguments args = ElssHomeScreenArguments(isLogicFromQC: loginFromQC);
        Navigator.of(context).pushNamedAndRemoveUntil(ElssHomeScreen.route, (route) => false, arguments: args);
      } else if (listOfRoles.contains(UserRoles.ROLE_RUBBING)) {
        Navigator.of(context).pushNamedAndRemoveUntil(RubbingHomeScreen.route, (route) => false);
      } else if (listOfRoles.contains(UserRoles.ROLE_ENGINEER)) {
        Navigator.of(context).pushNamedAndRemoveUntil(EngineerHomeScreen.route, (route) => false);
      } else if (listOfRoles.contains(UserRoles.ROLE_RIDER)) {
        Navigator.of(context).pushNamedAndRemoveUntil(RiderHomeScreen.route, (route) => false);
      } else if (listOfRoles.contains(UserRoles.ROLE_L4)) {
        Navigator.of(context).pushNamedAndRemoveUntil(L4HomeScreen.route, (route) => false);
      } else if (listOfRoles.contains(UserRoles.ROLE_INVENTORY_MANAGER)) {
        Navigator.of(context).pushNamedAndRemoveUntil(InventoryHomeScreen.route, (route) => false);
      } else if (listOfRoles.contains(UserRoles.ROLE_QC)) {
        Navigator.of(context).pushNamedAndRemoveUntil(PartQCHomeScreen.route, (route) => false);
      } else if (listOfRoles.contains(UserRoles.TRC_EXECUTIVE)) {
        Navigator.of(context).pushNamedAndRemoveUntil(TRCExecutiveScreen.route, (route) => false);
      } else if (listOfRoles.contains(UserRoles.QC_ROLE)) {
        Navigator.of(context).pushNamedAndRemoveUntil(TrcTesterScreen.route, (route) => false);
      } else if (listOfRoles.contains(UserRoles.ROLE_STORAGE_MANAGER)) {
        Navigator.of(context).pushNamedAndRemoveUntil(StoreManagerHomeScreen.route, (route) => false);
      } else {
        NativeData obj = NativeData(token: loginToken ?? "", authResponse: OAuthProvider.getAuth());
      }
    }
  }
}
