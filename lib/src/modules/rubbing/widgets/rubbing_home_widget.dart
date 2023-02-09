import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/common/user/widget/logout_action_widget.dart';
import 'package:flutter_trc/src/modules/rubbing/l10n.dart';
import 'package:flutter_trc/src/modules/rubbing/widgets/received_rubbing_devices_widget.dart';
import 'package:provider/provider.dart';

import '../../../common/widgets/app_version_widget.dart';
import '../../../common/widgets/user_name_widget.dart';
import '../../../screens/barcode_scanner_screen.dart';
import '../providers/received_devices_provider.dart';

class RubbingHomeWidget extends StatelessWidget {
  const RubbingHomeWidget({Key? key}) : super(key: key);
  static const route = "/rubbing/home";

  @override
  Widget build(BuildContext context) {
    L10n l10n = L10n(context);
    return ChangeNotifierProvider<ReceivedDevicesProvider>(
        create: (context) => ReceivedDevicesProvider(),
        builder: (context, widget) {
          return Scaffold(
            appBar: CshHeader(
              l10n.home,
              showBackBtn: false,
              actions: [LogoutActionWidget()],
            ),
            body: SafeArea(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Spacer(),
                  CshBigButton(
                    text: l10n.scanBarcode,
                    onPressed: () {
                      Navigator.of(context).pushNamed(BarcodeScanWidget.route,
                          arguments: (String barcode, {BarcodeScannerController? controller}) {
                        Provider.of<ReceivedDevicesProvider>(context, listen: false)
                            .receiveDeviceViaScanning(barcode)
                            .listen((event) {
                          CshSnackBar.success(context: context, message: l10n.deviceReceivedSuccessfully);
                          Navigator.pushReplacementNamed(context, ReceivedRubbingDevicesWidget.route,
                              arguments: barcode);
                        }).onError((e) {
                          CshSnackBar.error(
                              context: context, message: ApiErrorHelper.getErrorMessage(e) ?? l10n.somethingWentWrong);
                        });
                      });
                    },
                  ),
                  const SizedBox(
                    height: Dimens.space_24,
                  ),
                  CshBigButton(
                    text: l10n.receivedDevice,
                    onPressed: () {
                      Navigator.pushNamed(context, ReceivedRubbingDevicesWidget.route);
                    },
                  ),
                  const Spacer(),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Column(
                      children: const [UserNameWidget(), AppVersionWidget()],
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }
}
