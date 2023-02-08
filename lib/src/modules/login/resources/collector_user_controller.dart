import 'dart:convert';

import 'package:core/core.dart';
import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';

import '../../../amplify/amplify_provider.dart';
import '../../../resources/models/send_native_data.dart';
import '../../../utils/trc_method_channels.dart';

import '../../elss/screens/elss_home_screen.dart';
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
    if (Validator.isTrue(loginFromQC)) {
      var amplifyPro = AmplifyProvider.of(context, listen: false);
      amplifyPro.getS3DetailsAndConfigureAmplify();
      Navigator.of(context).pushNamedAndRemoveUntil(ElssHomeScreen.route, (route) => false);
    }

    if (listOfRoles.contains(UserRoles.ROLE_ELSS)) {
      var amplifyPro = AmplifyProvider.of(context, listen: false);
      amplifyPro.getS3DetailsAndConfigureAmplify();
      Navigator.of(context).pushNamedAndRemoveUntil(ElssHomeScreen.route, (route) => false);
    } else if (listOfRoles.contains(UserRoles.ROLE_RUBBING)) {
      Navigator.of(context).pushNamedAndRemoveUntil(RubbingHomeWidget.route, (route) => false);
    } else {
      NativeData obj = NativeData(token: loginToken ?? "", authResponse: OAuthProvider.getAuth());
      await NativeCall.sendUserDataToNativeSide(jsonEncode(obj.toJson()));
    }
  }
}
