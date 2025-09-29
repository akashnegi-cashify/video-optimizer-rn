import 'package:builder_component/builder_component.dart';
import 'package:csh_annotation/annotation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/qc/modules/qc_tester/lob_devices/providers/lob_device_scanner_provider.dart';
import 'package:flutter_trc/qc/modules/qc_tester/lob_devices/widgets/lob_device_scanner_widget.dart';
import 'package:flutter_trc/src/app_builder/app_builder_groups/qc_groups.dart';
import 'package:flutter_trc/src/app_builder/app_headers/general_app_header/models/none_config_model.dart';
import 'package:flutter_trc/src/common/model/device_barcode_param_model.dart';
import 'package:provider/provider.dart';

part 'lob_device_scanner_component.g.dart';

@CshComponent(
  key: LobDeviceScannerComponent.COMP_KEY,
  configModel: NoneConfigModel,
  componentGroup: QcComponentGroup.qcLobDeviceScannerComponentKey,
  params: DeviceBarcodeParamKeys.values,
  paramModel: DeviceBarcodeParamModel,
)
class LobDeviceScannerComponent extends StatelessComponent<NoneConfigModel> {
  static const String COMP_KEY = "QC_lob_device_scanner";

  const LobDeviceScannerComponent(super.jsonConfig, {super.key});

  @override
  Widget buildView(BuildContext context, configModel) {
    return paramBuilder((model) {
      return ChangeNotifierProvider(
        create: (_) => LobDeviceScannerProvider(model.deviceBarcode),
        lazy: false,
        child: const LobDeviceScannerWidget(),
      );
    });

  }

  @override
  Function(Map<String, dynamic> data)? fromConfig() {
    return NoneConfigModel.fromConfig;
  }
}
