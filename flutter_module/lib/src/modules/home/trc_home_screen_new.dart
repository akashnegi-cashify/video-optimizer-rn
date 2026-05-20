import 'package:core/core.dart';
import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/common/facility_list/widgets/current_facility_widget.dart';
import 'package:flutter_trc/src/header/trc_header.dart';
import 'package:flutter_trc/src/libraries/shared_preferences/app_preferences.dart';
import 'package:flutter_trc/src/modules/audit/screens/trc_audit_screen.dart';
import 'package:flutter_trc/src/modules/body_shop/screens/body_shop_home_screen.dart';
import 'package:flutter_trc/src/modules/dismantle/screens/dismantle_home_screen.dart';
import 'package:flutter_trc/src/modules/elss/common_screen/elss_home_screen.dart';
import 'package:flutter_trc/src/modules/engineer/resources/engineer_api_service.dart';
import 'package:flutter_trc/src/modules/engineer/widgets/engineer_home_widget.dart';
import 'package:flutter_trc/src/modules/inventory_manager/screens/inventory_home_screen.dart';
import 'package:flutter_trc/src/modules/l4/l4_home_screen.dart';
import 'package:flutter_trc/src/modules/laptop_analyzer/screens/laptop_analyzer_home_screen.dart';
import 'package:flutter_trc/src/modules/laptop_assembly/screens/laptop_assembly_home_screen.dart';
import 'package:flutter_trc/src/modules/paint_shop/screens/paint_shop_home_screen.dart';
import 'package:flutter_trc/src/modules/part_qc/screens/pq_home_screen.dart';
import 'package:flutter_trc/src/modules/rider/rider_home_screen.dart';
import 'package:flutter_trc/src/modules/rubbing/resources/rubbing_module_role_type.dart';
import 'package:flutter_trc/src/modules/rubbing/widgets/rubbing_home_screen.dart';
import 'package:flutter_trc/src/modules/store_manager/screens/store_manager_home_screen.dart';
import 'package:flutter_trc/src/modules/trc_executive/screens/trc_executive_screen.dart';
import 'package:flutter_trc/src/modules/trc_tester/trc_tester_screen.dart';
import 'package:flutter_trc/src/resources/user_details.dart';
import 'package:flutter_trc/src/services/service_groups.dart';
import 'package:flutter_trc/trc/my_permissions/permissions.dart';
import 'package:flutter_trc/trc/my_permissions/widget/trc_role_permission_widget.dart';

class TrcHomeScreenNew extends StatelessWidget {
  static String route = "/trc_home_new";

  const TrcHomeScreenNew({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TrcHeader("Home",
          showBackBtn: false, showLogoutButton: true, showProfileButton: true),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
              horizontal: Dimens.space_16, vertical: Dimens.space_24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CurrentFacilityWidget(
                getFacility: AppPreferences.trc.getFacility,
                setFacility: AppPreferences.trc.setFacility,
                serviceGroup: TRCServiceGroups.unifyTrc,
                apiUrl: "/console/facility/list",
                showForce: true,
              ),
              // Elss
              TRCRolePermissionWidget(
                permission: TrcPermissions.elss,
                padding: EdgeInsets.only(top: Dimens.space_16),
                child: CshBigButton(
                  text: "Elss",
                  onPressed: () {
                    ElssHomeScreenArguments args =
                        ElssHomeScreenArguments(isLogicFromQC: false);
                    Navigator.of(context)
                        .pushNamed(ElssHomeScreen.route, arguments: args);
                  },
                ),
              ),
              // Rubbing
              TRCRolePermissionWidget(
                permission: TrcPermissions.rubbing,
                padding: EdgeInsets.only(top: Dimens.space_16),
                child: CshBigButton(
                  text: "Rubbing",
                  onPressed: () {
                    UserDetails()
                        .setRubbingRoleType(RubbingModuleRoleType.rubbing);
                    Navigator.of(context).pushNamed(RubbingHomeScreen.route);
                  },
                ),
              ),
              // Glass Change
              TRCRolePermissionWidget(
                permission: TrcPermissions.glassChange,
                padding: EdgeInsets.only(top: Dimens.space_16),
                child: CshBigButton(
                  text: "Glass Change",
                  onPressed: () {
                    UserDetails()
                        .setRubbingRoleType(RubbingModuleRoleType.glassChange);
                    Navigator.of(context).pushNamed(RubbingHomeScreen.route);
                  },
                ),
              ),
              // Camera Cleaning
              TRCRolePermissionWidget(
                permission: TrcPermissions.cameraCleaning,
                padding: EdgeInsets.only(top: Dimens.space_16),
                child: CshBigButton(
                  text: "Camera Cleaning",
                  onPressed: () {
                    UserDetails().setRubbingRoleType(
                        RubbingModuleRoleType.cameraCleaning);
                    Navigator.of(context).pushNamed(RubbingHomeScreen.route);
                  },
                ),
              ),
              // Engineer
              TRCRolePermissionWidget(
                permission: TrcPermissions.engineer,
                padding: EdgeInsets.only(top: Dimens.space_16),
                child: CshBigButton(
                    text: "Engineer",
                    onPressed: () => _enterLocation(context, false)),
              ),
              // L4 Engineer
              TRCRolePermissionWidget(
                permission: TrcPermissions.l4Engineer,
                padding: EdgeInsets.only(top: Dimens.space_16),
                child: CshBigButton(
                    text: "L4 Engineer",
                    onPressed: () => _enterLocation(context, true)),
              ),
              // Rider
              TRCRolePermissionWidget(
                permission: TrcPermissions.rider,
                padding: EdgeInsets.only(top: Dimens.space_16),
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
                padding: EdgeInsets.only(top: Dimens.space_16),
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
                padding: EdgeInsets.only(top: Dimens.space_16),
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
                padding: EdgeInsets.only(top: Dimens.space_16),
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
                padding: EdgeInsets.only(top: Dimens.space_16),
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
                padding: EdgeInsets.only(top: Dimens.space_16),
                child: CshBigButton(
                  text: "Store Manager",
                  onPressed: () {
                    Navigator.of(context)
                        .pushNamed(StoreManagerHomeScreen.route);
                  },
                ),
              ),
              // Auditor
              TRCRolePermissionWidget(
                permission: TrcPermissions.auditor,
                padding: EdgeInsets.only(top: Dimens.space_16),
                child: CshBigButton(
                  text: "TRC Audit",
                  onPressed: () {
                    Navigator.of(context).pushNamed(TrcAuditScreen.route);
                  },
                ),
              ),
              SizedBox(height: Dimens.space_16),
              CshBigButton(
                text: "Paint Shop",
                onPressed: () {
                  Navigator.of(context).pushNamed(PaintShopHomeScreen.route);
                },
              ),
              SizedBox(height: Dimens.space_16),
              CshBigButton(
                text: "Body Shop",
                onPressed: () {
                  Navigator.of(context).pushNamed(BodyShopHomeScreen.route);
                },
              ),
              SizedBox(height: Dimens.space_16),
              CshBigButton(
                text: "Dismantling",
                onPressed: () {
                  Navigator.of(context).pushNamed(DismantleHomeScreen.route);
                },
              ),
              SizedBox(height: Dimens.space_16),
              CshBigButton(
                text: "Laptop Analyzer",
                onPressed: () {
                  Navigator.of(context)
                      .pushNamed(LaptopAnalyzerHomeScreen.route);
                },
              ),
              SizedBox(height: Dimens.space_16),
              CshBigButton(
                text: "Laptop Assembly",
                onPressed: () {
                  Navigator.of(context)
                      .pushNamed(LaptopAssemblyHomeScreen.route);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _enterLocation(BuildContext context, bool isL4Engineer) {
    final locationController = TextEditingController();
    String? locationError;
    showCshBottomSheet(
      context: context,
      child: StatefulBuilder(builder: (innerContext, setState) {
        return Padding(
          padding: EdgeInsets.only(
              bottom: MediaQuery.of(innerContext).viewInsets.bottom),
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
                  errorText: locationError,
                ),
                CshBigButton(
                  text: "Submit",
                  onPressed: () {
                    final location = locationController.text.trim();
                    if (location.isEmpty) {
                      setState(() {
                        locationError = "Please enter location";
                      });
                      return;
                    }
                    setState(() {
                      locationError = null;
                    });
                    CshLoading().showLoading(innerContext);
                    EngineerAPIService.updateEngineerLocation(location).listen(
                        (event) {
                      if (innerContext.mounted) {
                        CshLoading().hideLoading(innerContext);
                        Navigator.of(innerContext).pop();
                        if (isL4Engineer) {
                          Navigator.of(innerContext)
                              .pushNamed(L4HomeScreen.route);
                        } else {
                          Navigator.of(innerContext)
                              .pushNamed(EngineerHomeScreen.route);
                        }
                      }
                    }, onError: (error) {
                      if (innerContext.mounted) {
                        CshLoading().hideLoading(innerContext);
                        setState(() {
                          locationError =
                              ApiErrorHelper.getErrorMessage(error).toString();
                        });
                      }
                    });
                  },
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
