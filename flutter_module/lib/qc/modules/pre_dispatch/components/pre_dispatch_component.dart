import 'package:builder_component/builder_component.dart';
import 'package:csh_annotation/annotation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../src/app_builder/app_builder_groups/qc_groups.dart';
import '../../../../src/app_builder/app_headers/general_app_header/models/none_config_model.dart';
import '../models/index.dart';
import '../widgets/index.dart';

part 'pre_dispatch_component.g.dart';

@CshComponent(
  key: PreDispatchComponent.COMP_KEY,
  configModel: NoneConfigModel,
  componentGroup: QcComponentGroup.qcPreDispatchComponentKey,
  paramModel: PreDispatchCompParam,
  params: PreDispatchCompParamKeys.values,
)
class PreDispatchComponent extends StatelessComponent<NoneConfigModel> {
  static const String COMP_KEY = "QC_qc_pre_dispatch_component";

  const PreDispatchComponent(super.jsonConfig, {super.key});

  @override
  Widget buildView(BuildContext context, configModel) {
    return paramBuilder((paramModel) => PreDispatchContainerWidget(
          lotGroupName: paramModel.lotGroupName,
          lotId: paramModel.lotId,
        ));
  }

  @override
  Function(Map<String, dynamic> data)? fromConfig() {
    return NoneConfigModel.fromConfig;
  }
}
