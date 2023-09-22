import 'package:builder_component/builder_component.dart';
import 'package:csh_annotation/annotation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/qc/modules/re_qc/providers/re_qc_list_provider.dart';
import 'package:flutter_trc/qc/modules/re_qc/widgets/re_qc_list_widget.dart';
import 'package:flutter_trc/src/app_builder/app_builder_groups/qc_groups.dart';
import 'package:flutter_trc/src/app_builder/app_headers/general_app_header/models/none_config_model.dart';
import 'package:provider/provider.dart';

// part 're_qc_list_component.g.dart';

@CshComponent(
    key: ReQcListComponent.COMP_KEY,
    configModel: NoneConfigModel,
    componentGroup: QcComponentGroup.qcReQcListComponentKey)
class ReQcListComponent extends StatelessComponent<NoneConfigModel> {
  static const String COMP_KEY = "QC_re_qc_list_component";

  const ReQcListComponent(super.jsonConfig, {super.key});

  @override
  Widget buildView(BuildContext context, configModel) {
    return ChangeNotifierProvider(
      create: (_) => ReQcListProvider(),
      child: const ReQcListWidget(),
    );
  }

  @override
  Function(Map<String, dynamic> data)? fromConfig() {
    return NoneConfigModel.fromConfig;
  }
}
