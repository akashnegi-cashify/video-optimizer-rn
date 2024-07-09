import 'package:builder_component/builder_component.dart';
import 'package:csh_annotation/annotation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/rms/modules/home/widgets/rms_home_widget.dart';
import 'package:flutter_trc/src/app_builder/app_builder_groups/rms_groups.dart';
import 'package:flutter_trc/src/app_builder/app_headers/general_app_header/models/none_config_model.dart';

part 'rms_home_component.g.dart';

@CshComponent(
  key: RmsHomeComponent.COMP_KEY,
  configModel: NoneConfigModel,
  componentGroup: RmsComponentGroup.rmsHomeComponent,
)
class RmsHomeComponent extends StatelessComponent<NoneConfigModel> {
  static const String COMP_KEY = "RMS_home_component";

  const RmsHomeComponent(super.jsonConfig, {super.key});

  @override
  Widget buildView(BuildContext context, configModel) {
    return const RmsHomeWidget();
  }

  @override
  Function(Map<String, dynamic> data)? fromConfig() {
    return NoneConfigModel.fromConfig;
  }
}
