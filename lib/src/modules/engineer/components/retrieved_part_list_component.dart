import 'package:builder_component/builder_component.dart';
import 'package:csh_annotation/annotation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/app_builder/app_builder_groups/groups.dart';
import 'package:flutter_trc/src/app_builder/app_headers/general_app_header/models/none_config_model.dart';
import 'package:flutter_trc/src/modules/engineer/providers/retrieved_part_list_provider.dart';
import 'package:flutter_trc/src/modules/engineer/widgets/retrieved_part_list_widget.dart';
import 'package:provider/provider.dart';

part 'retrieved_part_list_component.g.dart';

@CshComponent(
    key: RetrievedPartListComponent.COMP_KEY,
    configModel: NoneConfigModel,
    componentGroup: ComponentGroup.trcRetrievedPartListComponentKey)
class RetrievedPartListComponent extends StatelessComponent<NoneConfigModel> {
  static const String COMP_KEY = "TRC_retrieved_part_list_component";

  const RetrievedPartListComponent(super.jsonConfig, {super.key});

  @override
  Widget buildView(BuildContext context, configModel) {
    return ChangeNotifierProvider(
      create: (_) => RetrievedPartListProvider(),
      child: const RetrievedPartListWidget(),
    );
  }

  @override
  Function(Map<String, dynamic> data)? fromConfig() {
    return NoneConfigModel.fromConfig;
  }
}
