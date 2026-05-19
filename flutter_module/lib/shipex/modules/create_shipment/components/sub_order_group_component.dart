import 'package:builder_component/builder_component.dart';
import 'package:csh_annotation/annotation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/app_builder/app_builder_groups/groups.dart';
import 'package:flutter_trc/src/app_builder/app_headers/general_app_header/models/none_config_model.dart';

import '../widgets/sub_order_group_list_widget.dart';

part 'sub_order_group_component.g.dart';

@CshComponent(
    key: SubOrderGroupListComponent.COMP_KEY,
    componentGroup: ComponentGroup.subOrderGroupComponentKey,
    configModel: NoneConfigModel)
class SubOrderGroupListComponent extends StatelessComponent<NoneConfigModel> {
  static const String COMP_KEY = "sub_order_group_comp";

  const SubOrderGroupListComponent(super.jsonConfig, {super.key});

  @override
  Widget buildView(BuildContext context, NoneConfigModel? configModel) {
    return const SubOrderGroupListWidget();
  }

  @override
  Function(Map<String, dynamic> data)? fromConfig() {
    return NoneConfigModel.fromConfig;
  }
}
