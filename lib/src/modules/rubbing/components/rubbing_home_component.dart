import 'package:builder_component/builder_component.dart';
import 'package:core/core.dart';
import 'package:core_widgets/core_widgets.dart';
import 'package:csh_annotation/annotation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/app_builder/app_headers/general_app_header/models/none_config_model.dart';
import 'package:flutter_trc/src/common/utils/csh_ml_scanner_util.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:provider/provider.dart';

import '../../../app_builder/app_builder_groups/groups.dart';
import '../../../common/widgets/app_version_widget.dart';
import '../../../common/widgets/user_name_widget.dart';
import '../l10n.dart';
import '../providers/received_devices_provider.dart';
import '../widgets/received_rubbing_devices_screen.dart';

part 'rubbing_home_component.g.dart';

@CshComponent(
  key: RubbingHomeComponent.COMP_KEY,
  configModel: NoneConfigModel,
  componentGroup: ComponentGroup.rubbingHomeComponentKey,
)
class RubbingHomeComponent extends StatelessComponent<NoneConfigModel> {
  static const String COMP_KEY = "TRC_rubbing_home_component";

  const RubbingHomeComponent(super.jsonConfig, {super.key});

  @override
  Widget buildView(BuildContext context, configModel) {
    var l10n = L10n(context);
    return ChangeNotifierProvider<ReceivedDevicesProvider>(
      create: (_) => ReceivedDevicesProvider(),
      lazy: false,
      builder: (BuildContext insideContext, __) {
        return Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Spacer(),
            CshBigButton(
              text: l10n.scanBarcode,
              onPressed: () {
                CshMlScannerUtil().openScanner(
                  context,
                  onScanned: (barcode, controller) {
                    _onScanned(
                      context,
                      provider: Provider.of<ReceivedDevicesProvider>(insideContext, listen: false),
                      barcode: barcode,
                      controller: controller,
                    );
                  },
                );
              },
            ),
            const SizedBox(height: Dimens.space_24),
            CshBigButton(
              text: l10n.receivedDevice,
              onPressed: () {
                Navigator.pushNamed(context, ReceivedRubbingDevicesScreen.route);
              },
            ),
            const Spacer(),
            const Align(
              alignment: Alignment.bottomCenter,
              child: Column(
                children: [UserNameWidget(), AppVersionWidget()],
              ),
            )
          ],
        );
      },
    );
  }

  _onScanned(BuildContext context,
      {required ReceivedDevicesProvider provider, required String barcode, MobileScannerController? controller}) {
    var l10n = L10n(context);
    controller?.stop();
    provider.receiveDeviceViaScanning(barcode).listen((event) {
      CshSnackBar.success(context: context, message: l10n.deviceReceivedSuccessfully);
    }, onError: (error) {
      String errorMessage = ApiErrorHelper.getErrorMessage(error) ?? l10n.somethingWentWrong;
      CshSnackBar.error(context: context, message: errorMessage);
    }, onDone: () {
      if (controller != null) {
        Future.delayed(const Duration(milliseconds: 300), () {
          controller.start();
        });
      }
    });
  }

  @override
  Function(Map<String, dynamic> data)? fromConfig() {
    return NoneConfigModel.fromConfig;
  }
}
