import 'package:builder_component/builder_component.dart';
import 'package:csh_annotation/annotation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/qc/modules/device_details/widgets/device_details_widget.dart';
import 'package:flutter_trc/src/app_builder/app_builder_groups/qc_groups.dart';
import 'package:flutter_trc/src/app_builder/app_headers/general_app_header/models/none_config_model.dart';
import 'package:flutter_trc/src/common/model/device_barcode_param_model.dart';
import 'package:provider/provider.dart';

part 'device_details_component.g.dart';

@CshComponent(
    key: DeviceDetailsComponent.COMP_KEY,
    configModel: NoneConfigModel,
    componentGroup: QcComponentGroup.qcDeviceDetailsComponentKey,
    paramModel: DeviceBarcodeParamModel,
    params: DeviceBarcodeParamKeys.values)
class DeviceDetailsComponent extends StatelessComponent<NoneConfigModel> {
  static const String COMP_KEY = "QC_device_details_component";

  const DeviceDetailsComponent(super.jsonConfig, {super.key});

  @override
  Widget buildView(BuildContext context, configModel) {
    return paramBuilder((model) => DeviceDetailsWidget(model.deviceBarcode!));
  }

  @override
  Function(Map<String, dynamic> data)? fromConfig() {
    return NoneConfigModel.fromConfig;
  }
}
