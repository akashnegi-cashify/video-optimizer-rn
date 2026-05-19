import 'package:builder_component/builder_component.dart';
import 'package:csh_annotation/annotation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/app_builder/app_builder_groups/qc_groups.dart';

import '../../../../src/app_builder/app_builder_groups/groups.dart';
import '../../../../src/app_builder/app_headers/general_app_header/models/none_config_model.dart';
import '../widgets/search_item_widget.dart';

part 'search_item_component.g.dart';

@CshComponent(
  key: SearchItemComponent.COMP_KEY,
  configModel: NoneConfigModel,
  componentGroup: QcComponentGroup.qcSearchItemComponentKey,
)
class SearchItemComponent extends StatelessComponent<NoneConfigModel> {
  static const String COMP_KEY = "QC_qc_search_item_component";

  const SearchItemComponent(super.jsonConfig, {super.key});

  @override
  Widget buildView(BuildContext context, configModel) {
    return const SearchItemWidget();
  }

  @override
  Function(Map<String, dynamic> data)? fromConfig() {
    return NoneConfigModel.fromConfig;
  }
}
