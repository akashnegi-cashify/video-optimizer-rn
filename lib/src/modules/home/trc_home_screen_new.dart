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
              FractionallySizedBox(
                widthFactor: 0.9,
                child: CshBigButton(
                  text: "Elss",
                  onPressed: () {
                    ElssHomeScreenArguments args = ElssHomeScreenArguments(isLogicFromQC: false);
                    // Navigator.of(context).pushNamedAndRemoveUntil(ElssHomeScreen.route, (route) => false, arguments: args);
                    Navigator.pushNamed(context, ReceivedRubbingDevicesScreen.route);
                  },
                ),
              ),
              FractionallySizedBox(
                widthFactor: 0.9,
                child: CshBigButton(
                  text: "Rubbing",
                  onPressed: () {
                    UserDetails().setIsGlassChangeRole(false);
                    Navigator.of(context).pushNamedAndRemoveUntil(RubbingHomeScreen.route, (route) => false);
                  },
                ),
              ),
              FractionallySizedBox(
                widthFactor: 0.9,
                child: CshBigButton(
                  text: "Glass Change",
                  onPressed: () {
                    UserDetails().setIsGlassChangeRole(true);
                    Navigator.of(context).pushNamedAndRemoveUntil(RubbingHomeScreen.route, (route) => false);
                  },
                ),
              ),
              FractionallySizedBox(
                widthFactor: 0.9,
                child: CshBigButton(
                  text: "Engineer",
                  onPressed: () {
                    Navigator.of(context).pushNamedAndRemoveUntil(EngineerHomeScreen.route, (route) => false);
                  },
                ),
              ),

              FractionallySizedBox(
                widthFactor: 0.9,
                child: CshBigButton(
                  text: "ROLE_RIDER",
                  onPressed: () {
                    Navigator.of(context).pushNamedAndRemoveUntil(RiderHomeScreen.route, (route) => false);
                  },
                ),
              ),

              FractionallySizedBox(
                widthFactor: 0.9,
                child: CshBigButton(
                  text: "ROLE_L4",
                  onPressed: () {
                    Navigator.of(context).pushNamedAndRemoveUntil(L4HomeScreen.route, (route) => false);
                  },
                ),
              ), 
              FractionallySizedBox(
                widthFactor: 0.9,
                child: CshBigButton(
                  text: "ROLE_INVENTORY_MANAGER",
                  onPressed: () {
                    Navigator.of(context).pushNamedAndRemoveUntil(InventoryHomeScreen.route, (route) => false);
                  },
                ),
              ),

              FractionallySizedBox(
                widthFactor: 0.9,
                child: CshBigButton(
                  text: "Part ROLE_QC",
                  onPressed: () {
                    Navigator.of(context).pushNamedAndRemoveUntil(PartQCHomeScreen.route, (route) => false);
                  },
                ),
              ),
              
              FractionallySizedBox(
                widthFactor: 0.9,
                child: CshBigButton(
                  text: "TRC_EXECUTIVE",
                  onPressed: () {
                    Navigator.of(context).pushNamedAndRemoveUntil(TRCExecutiveScreen.route, (route) => false);
                  },
                ),
              ),

              FractionallySizedBox(
                widthFactor: 0.9,
                child: CshBigButton(
                  text: "QC_ROLE",
                  onPressed: () {
                    Navigator.of(context).pushNamedAndRemoveUntil(TrcTesterScreen.route, (route) => false);
                  },
                ),
              ),
              
              FractionallySizedBox(
                widthFactor: 0.9,
                child: CshBigButton(
                  text: "ROLE_STORAGE_MANAGER",
                  onPressed: () {
                    Navigator.of(context).pushNamedAndRemoveUntil(StoreManagerHomeScreen.route, (route) => false);
                  },
                ),
              ),
              
              FractionallySizedBox(
                widthFactor: 0.9,
                child: CshBigButton(
                  text: "ROLE_TRC_AUDIT",
                  onPressed: () {
                    Navigator.of(context).pushNamedAndRemoveUntil(TrcAuditScreen.route, (route) => false);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
