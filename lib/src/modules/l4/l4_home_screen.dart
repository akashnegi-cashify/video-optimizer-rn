import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/common/widgets/app_version_widget.dart';
import 'package:flutter_trc/src/common/widgets/user_name_widget.dart';
import 'package:flutter_trc/src/modules/engineer/l10n.dart';
import 'package:flutter_trc/src/modules/engineer/manage_parts/manage_parts_widget.dart';
import 'package:flutter_trc/src/modules/engineer/my_devices/widgets/my_devices_widget.dart';
import 'package:flutter_trc/src/modules/engineer/my_devices/wip_devices/view_parts/widgets/assigned_parts_screen.dart';
import 'package:flutter_trc/src/modules/engineer/receive_devices/widget/receive_devices_button_widget.dart';
import 'package:flutter_trc/src/screens/barcode_scanner_screen.dart';

import '../../header/trc_header.dart';

class L4HomeScreen extends StatelessWidget {
  const L4HomeScreen({Key? key}) : super(key: key);

  static const route = "/l4/home";

  @override
  Widget build(BuildContext context) {
    return const L4HomeWidget();
  }
}

class L4HomeWidget extends StatelessWidget {
  const L4HomeWidget({Key? key}) : super(key: key);

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
              const Spacer(),
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
