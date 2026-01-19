import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/header/trc_header.dart';
import 'package:flutter_trc/src/modules/audit/screens/trc_audit_screen.dart';
import 'package:flutter_trc/src/modules/elss/common_screen/elss_home_screen.dart';
import 'package:flutter_trc/src/modules/engineer/resources/engineer_api_service.dart';
import 'package:flutter_trc/src/modules/engineer/widgets/engineer_home_widget.dart';
import 'package:flutter_trc/src/modules/inventory_manager/screens/inventory_home_screen.dart';
import 'package:flutter_trc/src/modules/l4/l4_home_screen.dart';
import 'package:flutter_trc/src/modules/part_qc/screens/pq_home_screen.dart';
import 'package:flutter_trc/src/modules/rider/rider_home_screen.dart';
import 'package:flutter_trc/src/modules/rubbing/widgets/rubbing_home_screen.dart';
import 'package:flutter_trc/src/modules/store_manager/screens/store_manager_home_screen.dart';
import 'package:flutter_trc/src/modules/trc_executive/screens/trc_executive_screen.dart';
import 'package:flutter_trc/src/modules/trc_tester/trc_tester_screen.dart';
import 'package:flutter_trc/src/resources/user_details.dart';
import 'package:flutter_trc/trc/my_permissions/permissions.dart';
import 'package:flutter_trc/trc/my_permissions/widget/trc_role_permission_widget.dart';

class TrcHomeScreenNew extends StatelessWidget {
  static String route = "/trc_home_new";

  const TrcHomeScreenNew({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TrcHeader("Home", showBackBtn: false, showLogoutButton: true, showProfileButton: true),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            spacing: Dimens.space_16,
            children: [
              // Elss
              TRCRolePermissionWidget(
                permission: TrcPermissions.elss,
                child: CshBigButton(
                  text: "Elss",
                  onPressed: () {
                    ElssHomeScreenArguments args = ElssHomeScreenArguments(isLogicFromQC: false);
                    Navigator.of(context).pushNamed(ElssHomeScreen.route, arguments: args);
                  },
                ),
              ),
              // Rubbing
              TRCRolePermissionWidget(
                permission: TrcPermissions.rubbing,
                child: CshBigButton(
                  text: "Rubbing",
                  onPressed: () {
                    UserDetails().setIsGlassChangeRole(false);
                    Navigator.of(context).pushNamed(RubbingHomeScreen.route);
                  },
                ),
              ),
              // Glass Change
              TRCRolePermissionWidget(
                permission: TrcPermissions.glassChange,
                child: CshBigButton(
                  text: "Glass Change",
                  onPressed: () {
                    UserDetails().setIsGlassChangeRole(true);
                    Navigator.of(context).pushNamed(RubbingHomeScreen.route);
                  },
                ),
              ),
              // Engineer
              TRCRolePermissionWidget(
                permission: TrcPermissions.engineer,
                child: CshBigButton(text: "Engineer", onPressed: () => _enterLocation(context, false)),
              ),
              // L4 Engineer
              TRCRolePermissionWidget(
                permission: TrcPermissions.l4Engineer,
                child: CshBigButton(text: "L4 Engineer", onPressed: () => _enterLocation(context, true)),
              ),
              // Rider
              TRCRolePermissionWidget(
                permission: TrcPermissions.rider,
                child: CshBigButton(
                  text: "Rider",
                  onPressed: () {
                    Navigator.of(context).pushNamed(RiderHomeScreen.route);
                  },
                ),
              ),
              // Inventory Manager
              TRCRolePermissionWidget(
                permission: TrcPermissions.inventory,
                child: CshBigButton(
                  text: "Inventory Manager",
                  onPressed: () {
                    Navigator.of(context).pushNamed(InventoryHomeScreen.route);
                  },
                ),
              ),
              // Part QC
              TRCRolePermissionWidget(
                permission: TrcPermissions.partQc,
                child: CshBigButton(
                  text: "Part QC",
                  onPressed: () {
                    Navigator.of(context).pushNamed(PartQCHomeScreen.route);
                  },
                ),
              ),
              // TRC Executive
              TRCRolePermissionWidget(
                permission: TrcPermissions.executive,
                child: CshBigButton(
                  text: "TRC Executive",
                  onPressed: () {
                    Navigator.of(context).pushNamed(TRCExecutiveScreen.route);
                  },
                ),
              ),
              // Tester (QC Role)
              TRCRolePermissionWidget(
                permission: TrcPermissions.tester,
                child: CshBigButton(
                  text: "Tester",
                  onPressed: () {
                    Navigator.of(context).pushNamed(TrcTesterScreen.route);
                  },
                ),
              ),
              // Store Manager
              TRCRolePermissionWidget(
                permission: TrcPermissions.storeManager,
                child: CshBigButton(
                  text: "Store Manager",
                  onPressed: () {
                    Navigator.of(context).pushNamed(StoreManagerHomeScreen.route);
                  },
                ),
              ),
              // Auditor
              TRCRolePermissionWidget(
                permission: TrcPermissions.auditor,
                child: CshBigButton(
                  text: "TRC Audit",
                  onPressed: () {
                    Navigator.of(context).pushNamed(TrcAuditScreen.route);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _enterLocation(BuildContext context, bool isL4Engineer) {
    final locationController = TextEditingController();
    showCshBottomSheet(
      context: context,
      child: Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Container(
          padding: const EdgeInsets.all(Dimens.space_16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            spacing: Dimens.space_16,
            children: [
              CshTextNew.h4("Enter Location"),
              CshTextFormField(
                controller: locationController,
                hintText: "Enter Location",
                autofocus: true,
                textInputAction: TextInputAction.done,
              ),
              CshBigButton(
                text: "Submit",
                onPressed: () {
                  final location = locationController.text.trim();
                  if (location.isEmpty) {
                    CshSnackBar.error(context: context, message: "Please enter location");
                    return;
                  }
                  CshLoading().showLoading(context);
                  EngineerAPIService.updateEngineerLocation(location).listen((event) {
                    if (context.mounted) {
                      CshLoading().hideLoading(context);
                      Navigator.of(context).pop();
                      if (isL4Engineer) {
                        Navigator.of(context).pushNamed(L4HomeScreen.route);
                      } else {
                        Navigator.of(context).pushNamed(EngineerHomeScreen.route);
                      }
                    }
                  }, onError: (error) {
                    if (context.mounted) {
                      CshLoading().hideLoading(context);
                      CshSnackBar.error(context: context, message: error.toString());
                    }
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
