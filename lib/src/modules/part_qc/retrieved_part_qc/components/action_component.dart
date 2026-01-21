import 'package:builder_component/builder_component.dart';
import 'package:csh_annotation/annotation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/app_builder/app_builder_groups/groups.dart';
import 'package:provider/provider.dart';

import '../models/action_item_params.dart';
import '../widgets/action_widget.dart';
part 'action_component.g.dart';

@CshComponent(
  key: ActionComponent.COMP_KEY,
  componentGroup: ComponentGroup.actionComponentKey,
  paramModel: ActionItemParams,
  params: ActionItemParamKey.values,
)
class ActionComponent extends StatelessComponent {
  static const String COMP_KEY = "TRC_action_component";

  const ActionComponent(super.jsonConfig, {super.key});

  @override
  Widget buildView(BuildContext context, configModel) {
    return paramBuilder((param) {
      return ActionWidget(param.barcode);
    });
  }

  @override
  Function(Map<String, dynamic> data)? fromConfig() {
    return null;
  }
}
