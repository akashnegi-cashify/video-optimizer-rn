import 'package:builder_component/builder_component.dart';
import 'package:csh_annotation/annotation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/qc/modules/d2c_video/widgets/d2c_video_widget.dart';
import 'package:flutter_trc/src/app_builder/app_builder_groups/qc_groups.dart';
import 'package:flutter_trc/src/app_builder/app_headers/general_app_header/models/none_config_model.dart';
import 'package:flutter_trc/src/common/model/device_barcode_param_model.dart';
import 'package:provider/provider.dart';

part 'd2c_video_component.g.dart';

@CshComponent(
  key: D2CVideoComponent.COMP_KEY,
  configModel: NoneConfigModel,
  componentGroup: QcComponentGroup.qcD2cVideoComponentKey,
  paramModel: DeviceBarcodeParamModel,
  params: DeviceBarcodeParamKeys.values,
)
class D2CVideoComponent extends StatelessComponent<NoneConfigModel> {
  static const String COMP_KEY = "QC_d2c_video_component_key";

  const D2CVideoComponent(super.jsonConfig, {super.key});

  @override
  Widget buildView(BuildContext context, configModel) {
    return paramBuilder((model) {
      return const D2CVideoWidget();
    });
  }

  @override
  Function(Map<String, dynamic> data)? fromConfig() {
    return NoneConfigModel.fromConfig;
  }
}
