import 'package:builder_component/builder_component.dart';
import 'package:csh_annotation/annotation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/qc/modules/qc_tester/calculator/widgets/submit_device_quote_widget.dart';
import 'package:flutter_trc/src/app_builder/app_builder_groups/qc_groups.dart';
import 'package:flutter_trc/src/app_builder/app_headers/general_app_header/models/none_config_model.dart';

part 'submit_device_quote_component.g.dart';

@CshComponent(
  key: SubmitDeviceQuoteComponent.COMP_KEY,
  configModel: NoneConfigModel,
  componentGroup: QcComponentGroup.qcSubmitDeviceQuoteComponentKey,
)
class SubmitDeviceQuoteComponent extends StatelessComponent<NoneConfigModel> {
  static const String COMP_KEY = "QC_submit_device_quote_component";

  const SubmitDeviceQuoteComponent(super.jsonConfig, {super.key});

  @override
  Widget buildView(BuildContext context, configModel) {
    return const SubmitDeviceQuoteWidget();
  }

  @override
  Function(Map<String, dynamic> data)? fromConfig() {
    return NoneConfigModel.fromConfig;
  }
}
