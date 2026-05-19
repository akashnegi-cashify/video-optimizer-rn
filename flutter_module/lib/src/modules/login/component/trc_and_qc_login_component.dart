import 'package:builder_component/builder_component.dart';
import 'package:csh_annotation/annotation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/app_builder/app_builder_groups/groups.dart';
import 'package:flutter_trc/src/app_builder/app_headers/general_app_header/models/none_config_model.dart';

import '../widgets/trc_and_qc_login_widget.dart';

part 'trc_and_qc_login_component.g.dart';

@CshComponent(
    key: TrcAndQCLoginComponent.COMP_KEY,
    configModel: NoneConfigModel,
    componentGroup: ComponentGroup.trcAndQcLoginComponentKey)
class TrcAndQCLoginComponent extends StatelessComponent<NoneConfigModel> {
  static const String COMP_KEY = "TRC_trc_and_qc_login";

  const TrcAndQCLoginComponent(super.jsonConfig, {super.key});

  @override
  Widget buildView(BuildContext context, configModel) {
    return const TrcAndQcLoginWidget();
  }

  @override
  Function(Map<String, dynamic> data)? fromConfig() {
    return NoneConfigModel.fromConfig;
  }
}
