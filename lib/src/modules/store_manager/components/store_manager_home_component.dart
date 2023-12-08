import 'package:builder_component/builder_component.dart';
import 'package:core_widgets/core_widgets.dart';
import 'package:csh_annotation/annotation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/qc/modules/store_in/screens/index.dart';
import 'package:flutter_trc/qc/modules/store_out/screens/index.dart';
import 'package:flutter_trc/src/app_builder/app_builder_groups/groups.dart';
import 'package:flutter_trc/src/app_builder/app_headers/general_app_header/models/none_config_model.dart';
import 'package:flutter_trc/src/common/utils/csh_ml_scanner_util.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

@CshComponent(
    key: StoreManagerHomeComponent.COMP_KEY,
    configModel: NoneConfigModel,
    componentGroup: ComponentGroup.trcStoreManagerHomeComponentKey)
class StoreManagerHomeComponent extends StatelessComponent<NoneConfigModel> {
  static const String COMP_KEY = "TRC_store_manager_home_component";

  const StoreManagerHomeComponent(super.jsonConfig, {super.key});

  @override
  Widget buildView(BuildContext context, configModel) {
    return Container(
      padding: const EdgeInsets.all(Dimens.space_16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          CshBigButton(
              text: "Store In",
              onPressed: () {
                CshMlScannerUtil().openScanner(
                  context,
                  header: "Scan location Qr Code",
                  hintText: "Scan location Qr Code",
                  scanFormatList: [BarcodeFormat.qrCode],
                  onScanned: (scannedData, controller) {
                    Navigator.pop(context); // pop screen
                    StoreInLocationScanScreen.navigateTo(context, barcode: scannedData, isBinStoreIn: true);
                  },
                );
              }),
          const SizedBox(height: Dimens.space_16),
          CshBigButton(
              text: "Store Out",
              onPressed: () {
                Navigator.of(context).pushNamed(StoreOutScreen.route);
              }),
        ],
      ),
    );
  }

  @override
  Function(Map<String, dynamic> data)? fromConfig() {
    return NoneConfigModel.fromConfig;
  }
}
