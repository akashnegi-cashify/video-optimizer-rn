import 'package:builder_component/builder_component.dart';
import 'package:csh_annotation/annotation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/app_builder/app_headers/general_app_header/models/none_config_model.dart';
import 'package:flutter_trc/src/modules/trc_executive/providers/tl_list_provider.dart';
import 'package:flutter_trc/src/modules/trc_executive/widgets/tl_list_widget.dart';
import 'package:provider/provider.dart';

import '../../../app_builder/app_builder_groups/groups.dart';

part 'tl_list_component.g.dart';

@CshComponent(
  key: TlListComponent.COMP_KEY,
  configModel: NoneConfigModel,
  componentGroup: ComponentGroup.trcTlListComponentKey,
)
class TlListComponent extends StatelessComponent<NoneConfigModel> {
  static const String COMP_KEY = "TRC_tl_list_component";

  const TlListComponent(super.jsonConfig, {super.key});

  @override
  Widget buildView(BuildContext context, configModel) {
    return ChangeNotifierProvider(
      create: (_) => TlListProvider(),
      child: const TlListWidget(),
    );
  }

  @override
  Function(Map<String, dynamic> data)? fromConfig() {
    return NoneConfigModel.fromConfig;
  }
}
