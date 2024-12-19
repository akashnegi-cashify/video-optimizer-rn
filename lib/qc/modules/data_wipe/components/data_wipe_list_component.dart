import 'package:builder_component/builder_component.dart';
import 'package:csh_annotation/annotation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/qc/modules/data_wipe/providers/data_wipe_list_provider.dart';
import 'package:flutter_trc/qc/modules/data_wipe/widgets/data_wipe_list_widget.dart';
import 'package:flutter_trc/src/app_builder/app_builder_groups/qc_groups.dart';
import 'package:flutter_trc/src/app_builder/app_headers/general_app_header/models/none_config_model.dart';
import 'package:provider/provider.dart';

part 'data_wipe_list_component.g.dart';

@CshComponent(
    key: DataWipeListComponent.COMP_KEY,
    configModel: NoneConfigModel,
    componentGroup: QcComponentGroup.qcDataWipeListComponentKey)
class DataWipeListComponent extends StatelessComponent<NoneConfigModel> {
  static const String COMP_KEY = "QC_data_wipe_list_component";

  const DataWipeListComponent(super.jsonConfig, {super.key});

  @override
  Widget buildView(BuildContext context, configModel) {
    return ChangeNotifierProvider(
      create: (context) => DataWipeListProvider(),
      child: const DataWipeListWidget(),
    );
  }

  @override
  Function(Map<String, dynamic> data)? fromConfig() {
    return NoneConfigModel.fromConfig;
  }
}
