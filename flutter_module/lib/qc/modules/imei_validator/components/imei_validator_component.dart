import 'package:builder_component/builder_component.dart';
import 'package:csh_annotation/annotation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/qc/modules/imei_validator/models/imei_validator_screen_arg_model.dart';
import 'package:flutter_trc/qc/modules/imei_validator/widgets/imei_validator_widget.dart';
import 'package:flutter_trc/src/app_builder/app_builder_groups/qc_groups.dart';
import 'package:flutter_trc/src/app_builder/app_headers/general_app_header/models/none_config_model.dart';
import 'package:provider/provider.dart';

part 'imei_validator_component.g.dart';

@CshComponent(
    key: ImeiValidatorComponent.COMP_KEY,
    configModel: NoneConfigModel,
    componentGroup: QcComponentGroup.qcImeiValidatorComponentKey,
    params: ImeiValidatorScreenArgModelKeys.values,
    paramModel: ImeiValidatorScreenArgModel)
class ImeiValidatorComponent extends StatelessComponent<NoneConfigModel> {
  static const String COMP_KEY = "QC_imei_validator_component";

  const ImeiValidatorComponent(super.jsonConfig, {super.key});

  @override
  Widget buildView(BuildContext context, configModel) {
    return paramBuilder((model) => ImeiValidatorWidget(model.imeiQrcodeResponse));
  }

  @override
  Function(Map<String, dynamic> data)? fromConfig() {
    return NoneConfigModel.fromConfig;
  }
}
