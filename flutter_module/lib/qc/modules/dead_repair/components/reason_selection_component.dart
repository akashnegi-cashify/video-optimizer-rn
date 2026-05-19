import 'package:builder_component/builder_component.dart';
import 'package:core_widgets/core_widgets.dart';
import 'package:csh_annotation/annotation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/app_builder/app_headers/general_app_header/models/none_config_model.dart';
import 'package:provider/provider.dart';

import '../../../../src/app_builder/app_builder_groups/groups.dart';
import '../models/index.dart';
import '../widgets/index.dart';

part 'reason_selection_component.g.dart';

@CshComponent(
  key: ReasonSelectionComponent.COMP_KEY,
  configModel: NoneConfigModel,
  componentGroup: ComponentGroup.ReasonSelection,
  paramModel: ReasonSelectionCompParam,
  params: ReasonSelectionCompParamKeys.values,
)
class ReasonSelectionComponent extends StatelessComponent<NoneConfigModel> {
  static const String COMP_KEY = "QC_qc_reason_selection_component";

  const ReasonSelectionComponent(super.jsonConfig, {super.key});

  @override
  Widget buildView(BuildContext context, configModel) {
    return paramBuilder((paramModel) {
      if (ArrayUtil.isNullOrEmpty(paramModel.reasonList)) {
        return Center(
          child: CshTextNew.h3('Reason List Must Not Be Null Or Empty.'),
        );
      }

      if (paramModel.roleType==null) {
        return Center(
          child: CshTextNew.h3('Role Type Must Not Be Null.'),
        );
      }

      return ReasonSelectionWidget(
        reasonList: paramModel.reasonList!,
        code: paramModel.code,
        roleType: paramModel.roleType!,
        markId: paramModel.markId,
      );
    });
  }

  @override
  Function(Map<String, dynamic> data)? fromConfig() {
    return NoneConfigModel.fromConfig;
  }
}
