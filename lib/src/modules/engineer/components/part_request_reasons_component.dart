import 'package:builder_component/builder_component.dart';
import 'package:csh_annotation/annotation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/app_builder/app_builder_groups/groups.dart';
import 'package:flutter_trc/src/app_builder/app_headers/general_app_header/models/none_config_model.dart';
import 'package:flutter_trc/src/modules/engineer/models/part_request_reasons_comp_model.dart';
import 'package:flutter_trc/src/modules/engineer/providers/part_request_reasons_provider.dart';
import 'package:flutter_trc/src/modules/engineer/widgets/part_request_reasons_widget.dart';
import 'package:provider/provider.dart';

part 'part_request_reasons_component.g.dart';

@CshComponent(
  key: PartRequestReasonsComponent.COMP_KEY,
  configModel: NoneConfigModel,
  componentGroup: ComponentGroup.trcPartRequestReasonsComponentKey,
  paramModel: PartRequestReasonsCompParam,
  params: PartRequestReasonsCompParamKeys.values,
)
class PartRequestReasonsComponent extends StatelessComponent<NoneConfigModel> {
  static const String COMP_KEY = "TRC_part_request_reasons_component";

  const PartRequestReasonsComponent(super.jsonConfig, {super.key});

  @override
  Widget buildView(BuildContext context, configModel) {
    return paramBuilder((model) {
      return ChangeNotifierProvider(
        create: (_) => PartRequestReasonsProvider(model.partRequestList),
        lazy: false,
        child: PartRequestReasonsWidget(model.onReasonsSubmitted),
      );
    });
  }

  @override
  Function(Map<String, dynamic> data)? fromConfig() {
    return NoneConfigModel.fromConfig;
  }
}
