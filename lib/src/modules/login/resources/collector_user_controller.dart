import 'dart:convert';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/modules/l4/l4_home_screen.dart';
import 'package:flutter_trc/src/modules/rider/rider_home_widget.dart';
import '../../../amplify/amplify_provider.dart';
import '../../../resources/models/send_native_data.dart';
import '../../../utils/trc_method_channels.dart';
import '../../elss/common_screen/elss_home_screen.dart';
import '../../engineer/widgets/engineer_home_widget.dart';
import '../../inventory_manager/screens/inventory_home_screen.dart';
import '../../rubbing/widgets/rubbing_home_widget.dart';

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

  static navigateToUserRoleScreen(BuildContext context, List<String> listOfRoles,
      {String? loginToken, bool? loginFromQC = false}) async {
    var amplifyPro = AmplifyProvider.of(context, listen: false);
    if (loginFromQC == true) {
      amplifyPro.getS3DetailsForQcAndConfigAmplify();
      Navigator.of(context).pushNamedAndRemoveUntil(ElssHomeScreen.route, (route) => false, arguments: loginFromQC);
    } else {
      amplifyPro.getS3DetailsAndConfigureAmplify();
      if (listOfRoles.contains(UserRoles.ROLE_ELSS)) {
        Navigator.of(context).pushNamedAndRemoveUntil(ElssHomeScreen.route, (route) => false, arguments: loginFromQC);
      } else if (listOfRoles.contains(UserRoles.ROLE_RUBBING)) {
        Navigator.of(context).pushNamedAndRemoveUntil(RubbingHomeWidget.route, (route) => false);
      } else if (listOfRoles.contains(UserRoles.ROLE_ENGINEER)) {
        Navigator.of(context).pushNamedAndRemoveUntil(EngineerHomeScreen.route, (route) => false);
      } else if (listOfRoles.contains(UserRoles.ROLE_RIDER)) {
        Navigator.of(context).pushNamedAndRemoveUntil(RiderHomeScreen.route, (route) => false);
      } else if (listOfRoles.contains(UserRoles.ROLE_L4)) {
        Navigator.of(context).pushNamedAndRemoveUntil(L4HomeScreen.route, (route) => false);
      } else if (listOfRoles.contains(UserRoles.ROLE_INVENTORY_MANAGER)) {
        Navigator.of(context).pushNamedAndRemoveUntil(InventoryHomeScreen.route, (route) => false);
      } else {
        NativeData obj = NativeData(token: loginToken ?? "", authResponse: OAuthProvider.getAuth());
        await NativeCall.sendUserDataToNativeSide(jsonEncode(obj.toJson()));
      }
    }
  }
}
