import 'package:builder_component/builder_component.dart';
import 'package:csh_annotation/annotation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/app_builder/app_builder_groups/groups.dart';
import 'package:flutter_trc/src/app_builder/app_headers/general_app_header/models/none_config_model.dart';
import 'package:provider/provider.dart';

import '../common_models/elss_home_comp_param.dart';
import '../elss_qc/widgets/elss_home_widget.dart';

part 'elss_home_component.g.dart';

@CshComponent(
    key: ElssHomeComponent.COMP_KEY,
    configModel: NoneConfigModel,
    paramModel: ElssHomeCompParam,
    params: ElssHomeCompParamKeys.values,
    componentGroup: ComponentGroup.elssHomeComponentKey)
class ElssHomeComponent extends StatelessComponent<NoneConfigModel> {
  static const String COMP_KEY = "TRC_elss_home_comp";

  const ElssHomeComponent(super.jsonConfig, {super.key});

  @override
  Widget buildView(BuildContext context, configModel) {
    return paramBuilder(
      (param) {
        return ElssHomeWidget(
          isLoginFromQC: param.isLogicFromQC ?? false,
        );
      },
    );
  }

  @override
  Function(Map<String, dynamic> data)? fromConfig() {
    return NoneConfigModel.fromConfig;
  }
}
