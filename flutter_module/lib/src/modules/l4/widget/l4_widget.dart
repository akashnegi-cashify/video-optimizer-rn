import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/common/utils/csh_ml_scanner_util.dart';
import 'package:flutter_trc/src/modules/engineer/l10n.dart';

import '../../../common/widgets/app_version_widget.dart';
import '../../../common/widgets/user_name_widget.dart';
import '../../engineer/manage_parts/manage_parts_screen.dart';
import '../../engineer/my_devices/widgets/my_devices_screen.dart';
import '../../engineer/my_devices/wip_devices/view_parts/widgets/assigned_parts_screen.dart';
import '../../engineer/receive_devices/widget/receive_devices_button_widget.dart';

class L4HomeWidget extends StatelessWidget {
  const L4HomeWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    L10n l10n = L10n(context);

    return Padding(
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
              CshMlScannerUtil().openScanner(
                context,
                onScanned: (scannedData, controller) {
                  Navigator.of(context).pop(); // dismiss the scanner
                  Navigator.pushNamed(context, AssignedPartsScreen.route,
                      arguments: AssignedPartsData(false, deviceBarcode: scannedData.trim()));
                },
              );
            },
          ),
          const Spacer(),
          const Align(
            alignment: Alignment.center,
            child: UserNameWidget(),
          ),
          const Align(
            alignment: Alignment.center,
            child: AppVersionWidget(),
          )
          // const Spacer(),
        ],
      ),
    );
    // return Scaffold(
    //   appBar: TrcHeader(
    //     l10n.home,
    //     showBackBtn: false,
    //     showLogoutButton: true,
    //   ),
    //   body: SafeArea(
    //     child: ,
    //   ),
    // );
  }
}
