import 'package:builder_component/builder_component.dart';
import 'package:core_widgets/core_widgets.dart';
import 'package:csh_annotation/annotation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/qc/modules/qc_tester/calculator/screens/calculator_scanner_screen.dart';
import 'package:flutter_trc/qc/modules/qc_tester/lob_devices/screens/lob_device_scanner_screen.dart';
import 'package:flutter_trc/src/app_builder/app_builder_groups/groups.dart';
import 'package:flutter_trc/src/app_builder/app_headers/general_app_header/models/none_config_model.dart';
import 'package:flutter_trc/src/common/utils/csh_ml_scanner_util.dart';

part 'trc_tester_component.g.dart';

@CshComponent(
    key: TrcTesterComponent.COMP_KEY,
    configModel: NoneConfigModel,
    componentGroup: ComponentGroup.trcTesterComponentKey)
class TrcTesterComponent extends StatelessComponent<NoneConfigModel> {
  static const String COMP_KEY = "TRC_trc_tester_component";

  const TrcTesterComponent(super.jsonConfig, {super.key});

  @override
  Widget buildView(BuildContext context, configModel) {
    return Container(
      padding: const EdgeInsets.all(Dimens.space_16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CshBigButton(
            text: 'Trc Tester',
            onPressed: () {
              Navigator.pushNamed(context, CalculatorScannerScreen.route);
            },
          ),
          const SizedBox(height: Dimens.space_16),
          CshBigButton(
            text: 'Trc Manual Tester',
            onPressed: () {
              CshMlScannerUtil().openScanner(
                context,
                header: "Manual Testing",
                hintText: "Scan Device Barcode",
                onScanned: (scannedData, controller) {
                  if (scannedData.isNotEmpty) {
                    Navigator.pushReplacementNamed(context, LobDeviceScannerScreen.route,
                        arguments: LobDeviceScannerScreenArg(barcode: scannedData));
                  }
                },
              );
            },
          ),
        ],
      ),
    );
  }

  @override
  Function(Map<String, dynamic> data)? fromConfig() {
    return NoneConfigModel.fromConfig;
  }
}
