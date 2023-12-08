import 'package:builder_component/builder_component.dart';
import 'package:core_widgets/core_widgets.dart';
import 'package:csh_annotation/annotation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/app_builder/app_headers/general_app_header/models/none_config_model.dart';
import 'package:ml_barcode_scanner/widgets/ml_barcode_scanner_widget.dart';
import 'package:provider/provider.dart';

import '../../../app_builder/app_builder_groups/groups.dart';
import '../../../common/widgets/app_version_widget.dart';
import '../../../common/widgets/user_name_widget.dart';
import '../../../screens/barcode_scanner_with_controller.dart';
import '../l10n.dart';
import '../providers/received_devices_provider.dart';
import '../widgets/received_rubbing_devices_screen.dart';
import 'package:core/core.dart';

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
                Navigator.of(context).pushNamed(
                  BarcodeScannerControllerWidget.route,
                  arguments: (String barcode, {MlScannerController? controller}) {
                    Provider.of<ReceivedDevicesProvider>(insideContext, listen: false)
                        .receiveDeviceViaScanning(barcode)
                        .listen((event) {
                      if (controller != null) {
                        controller.stop();
                      }

                      CshSnackBar.success(context: context, message: l10n.deviceReceivedSuccessfully);
                      ReceivedRubbingDevicesScreenArguments args =
                          ReceivedRubbingDevicesScreenArguments(searchQuery: barcode);
                      Navigator.pushReplacementNamed(context, ReceivedRubbingDevicesScreen.route, arguments: args);
                    })
                      ..onError(
                        (e) {
                          if (controller != null) {
                            controller.stop();
                          }
                          CshSnackBar.error(
                              context: context, message: ApiErrorHelper.getErrorMessage(e) ?? l10n.somethingWentWrong);
                        },
                      )
                      ..onDone(
                        () {
                          if (controller != null) {
                            Future.delayed(const Duration(milliseconds: 300), () {
                              controller.start();
                            });
                          }
                        },
                      );
                  },
                );
              },
            ),
            const SizedBox(
              height: Dimens.space_24,
            ),
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

  @override
  Function(Map<String, dynamic> data)? fromConfig() {
    return NoneConfigModel.fromConfig;
  }
}
