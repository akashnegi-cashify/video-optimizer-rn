import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/header/trc_header.dart';
import 'package:flutter_trc/src/modules/audit/screens/trc_audit_screen.dart';
import 'package:flutter_trc/src/modules/elss/common_screen/elss_home_screen.dart';
import 'package:flutter_trc/src/modules/engineer/widgets/engineer_home_widget.dart';
import 'package:flutter_trc/src/modules/inventory_manager/screens/inventory_home_screen.dart';
import 'package:flutter_trc/src/modules/l4/l4_home_screen.dart';
import 'package:flutter_trc/src/modules/part_qc/screens/pq_home_screen.dart';
import 'package:flutter_trc/src/modules/rider/rider_home_screen.dart';
import 'package:flutter_trc/src/modules/rubbing/widgets/received_rubbing_devices_screen.dart';
import 'package:flutter_trc/src/modules/rubbing/widgets/rubbing_home_screen.dart';
import 'package:flutter_trc/src/modules/store_manager/screens/store_manager_home_screen.dart';
import 'package:flutter_trc/src/modules/trc_executive/screens/trc_executive_screen.dart';
import 'package:flutter_trc/src/modules/trc_tester/trc_tester_screen.dart';
import 'package:flutter_trc/src/resources/user_details.dart';
import 'package:flutter_trc/trc/my_permissions/permissions.dart';
import 'package:flutter_trc/trc/my_permissions/widget/trc_role_permission_widget.dart';

import 'l10n.dart';

class TrcHomeScreenNew extends StatelessWidget {
  static String route = "/trc_home_new";

  const TrcHomeScreenNew({super.key});

  @override
  Widget build(BuildContext context) {
    var l10n = L10n(context);
    return Scaffold(
      appBar: TrcHeader("Home"),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            spacing: Dimens.space_16,
            children: [
              CshBigButton(
                text: "Elss",
                onPressed: () {
                  ElssHomeScreenArguments args = ElssHomeScreenArguments(isLogicFromQC: false);
                  // Navigator.of(context).pushNamedAndRemoveUntil(ElssHomeScreen.route, (route) => false, arguments: args);
                  Navigator.pushNamed(context, ReceivedRubbingDevicesScreen.route);
                },
              ),
              CshBigButton(
                text: "Rubbing",
                onPressed: () {
                  UserDetails().setIsGlassChangeRole(false);
                  Navigator.of(context).pushNamed(RubbingHomeScreen.route);
                },
              ),
              CshBigButton(
                text: "Glass Change",
                onPressed: () {
                  UserDetails().setIsGlassChangeRole(true);
                  Navigator.of(context).pushNamed(RubbingHomeScreen.route);
                },
              ),
              TRCRolePermissionWidget(
                permission: TrcPermissions.engineer,
                child: CshBigButton(
                  text: "Engineer",
                  onPressed: () {
                    Navigator.of(context).pushNamed(EngineerHomeScreen.route);
                  },
                ),
              ),
              CshBigButton(
                text: "ROLE_RIDER",
                onPressed: () {
                  Navigator.of(context).pushNamed(RiderHomeScreen.route);
                },
              ),
              CshBigButton(
                text: "ROLE_L4",
                onPressed: () {
                  Navigator.of(context).pushNamed(L4HomeScreen.route);
                },
              ),
              TRCRolePermissionWidget(
                permission: TrcPermissions.inventory,
                child: CshBigButton(
                  text: "ROLE_INVENTORY_MANAGER",
                  onPressed: () {
                    Navigator.of(context).pushNamed(InventoryHomeScreen.route);
                  },
                ),
              ),
              CshBigButton(
                text: "Part ROLE_QC",
                onPressed: () {
                  Navigator.of(context).pushNamed(PartQCHomeScreen.route);
                },
              ),
              CshBigButton(
                text: "TRC_EXECUTIVE",
                onPressed: () {
                  Navigator.of(context).pushNamed(TRCExecutiveScreen.route);
                },
              ),
              CshBigButton(
                text: "QC_ROLE",
                onPressed: () {
                  Navigator.of(context).pushNamed(TrcTesterScreen.route);
                },
              ),
              CshBigButton(
                text: "ROLE_STORAGE_MANAGER",
                onPressed: () {
                  Navigator.of(context).pushNamed(StoreManagerHomeScreen.route);
                },
              ),
              CshBigButton(
                text: "ROLE_TRC_AUDIT",
                onPressed: () {
                  Navigator.of(context).pushNamed(TrcAuditScreen.route);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
