import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/common/widgets/app_version_widget.dart';
import 'package:flutter_trc/src/common/widgets/user_name_widget.dart';
import 'package:flutter_trc/src/header/trc_header.dart';
import 'package:flutter_trc/src/modules/engineer/l10n.dart';
import 'package:flutter_trc/src/modules/engineer/my_devices/wip_devices/view_parts/widgets/assigned_parts_screen.dart';
import 'package:flutter_trc/src/screens/barcode_scanner_screen.dart';

import '../manage_parts/manage_parts_widget.dart';
import '../my_devices/widgets/my_devices_widget.dart';
import '../receive_devices/widget/receive_devices_button_widget.dart';
import '../view_reports/view_report_widget.dart';

class EngineerHomeScreen extends StatelessWidget {
  const EngineerHomeScreen({Key? key}) : super(key: key);
  static const route = "/engineer/home";

  @override
  Widget build(BuildContext context) {
    return const _EngineerHomeWidget();
  }
}

class _EngineerHomeWidget extends StatefulWidget {
  const _EngineerHomeWidget({Key? key}) : super(key: key);

  @override
  State<_EngineerHomeWidget> createState() => _EngineerHomeWidgetState();
}

class _EngineerHomeWidgetState extends State<_EngineerHomeWidget> {
  @override
  Widget build(BuildContext context) {
    L10n l10n = L10n(context);
    return Scaffold(
      appBar: TrcHeader(
        l10n.home,
        showBackBtn: false,
        showLogoutButton: true,
      ),
      body: SafeArea(
        child: Padding(
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
                  Navigator.of(context).pushNamed(BarcodeScanWidget.route, arguments: (String data) {
                    Navigator.of(context).pop();
                    Navigator.pushNamed(context, AssignedPartsScreen.route,
                        arguments: AssignedPartsData(false, deviceBarcode: data.trim()));
                  });
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
        ),
      ),
    );
  }
}
