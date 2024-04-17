import 'package:builder_project/builder_project.dart';
import 'package:core_widgets/core_widgets.dart';
import 'package:csh_annotation/annotation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/common/utils/csh_ml_scanner_util.dart';
import 'package:flutter_trc/src/common/widgets/app_version_widget.dart';
import 'package:flutter_trc/src/common/widgets/user_name_widget.dart';
import 'package:flutter_trc/src/modules/engineer/l10n.dart';
import 'package:flutter_trc/src/modules/engineer/my_devices/wip_devices/view_parts/widgets/assigned_parts_screen.dart';
import 'package:flutter_trc/src/modules/engineer/screens/retrieved_part_list_screen.dart';

import '../../retrieved_part_qc/screens/retrieved_parts_qc_dashboard_screen.dart';
import '../manage_parts/manage_parts_screen.dart';
import '../my_devices/widgets/my_devices_screen.dart';
import '../receive_devices/widget/receive_devices_button_widget.dart';
import '../view_reports/view_report_screen.dart';

part 'engineer_home_widget.g.dart';

@CshPage(key: EngineerHomeScreen.pageKey)
class EngineerHomeScreen extends BaseScreen {
  static const String pageKey = "TRC_engineer_home_screen";
  static const route = "/engineer/home";

  const EngineerHomeScreen({super.key});

  @override
  Widget buildView(BuildContext context) {
    return const PageWidget(pageKey: pageKey);
  }
}

class EngineerHomeWidget extends StatefulWidget {
  const EngineerHomeWidget({Key? key}) : super(key: key);

  @override
  State<EngineerHomeWidget> createState() => _EngineerHomeWidgetState();
}

class _EngineerHomeWidgetState extends State<EngineerHomeWidget> {
  @override
  Widget build(BuildContext context) {
    L10n l10n = L10n(context);

    return Padding(
      padding: const EdgeInsets.all(Dimens.space_16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: Dimens.space_48),
          const ReceiveDevicesButtonWidget(),
          const SizedBox(height: Dimens.space_16),
          CshBigButton(
              text: l10n.myDevices,
              onPressed: () {
                Navigator.of(context).pushNamed(MyDevicesScreen.route);
              }),
          const SizedBox(height: Dimens.space_16),
          CshBigButton(
            text: l10n.manageParts,
            onPressed: () {
              Navigator.pushNamed(context, ManagePartsScreen.route);
            },
          ),
          const SizedBox(height: Dimens.space_16),
          CshBigButton(
            text: l10n.viewReport,
            onPressed: () {
              Navigator.pushNamed(context, ViewReportScreen.route);
            },
          ),
          const SizedBox(height: Dimens.space_16),
          CshBigButton(
            text: l10n.deviceDetails,
            onPressed: () {
              CshMlScannerUtil().openScanner(
                context,
                onScanned: (scannedData, controller) {
                  Navigator.of(context).pop();
                  Navigator.pushNamed(context, AssignedPartsScreen.route,
                      arguments: AssignedPartsData(false, deviceBarcode: scannedData.trim()));
                },
              );
            },
          ),
          const SizedBox(height: Dimens.space_16),
          CshBigButton(
            text: l10n.retrievedPartList,
            onPressed: () {
              Navigator.pushNamed(context, RetrievedPartListScreen.route);
            },
          ),
          const SizedBox(height: Dimens.space_16),
          CshBigButton(
            text: "test",
            onPressed: () {
              Navigator.pushNamed(context, RetrievedPartsQcDashboardScreen.route);
            },
          ),
          const Spacer(),
          const Align(alignment: Alignment.center, child: UserNameWidget()),
          const Align(
            alignment: Alignment.center,
            child: AppVersionWidget(),
          )
          // const Spacer(),
        ],
      ),
    );
  }
}
