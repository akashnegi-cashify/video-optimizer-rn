import 'package:builder_component/builder_component.dart';
import 'package:csh_annotation/annotation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/qc/modules/gaurd/providers/guardDeviceCountingListProvider.dart';
import 'package:flutter_trc/src/app_builder/app_builder_groups/qc_groups.dart';
import 'package:flutter_trc/src/app_builder/app_headers/general_app_header/models/none_config_model.dart';
import 'package:provider/provider.dart';

import '../widgets/qc_device_counting_list_widget.dart';

part 'guard_device_counting_list_component.g.dart';

@CshComponent(
    key: GuardDeviceCountingListComponent.COMP_KEY,
    configModel: NoneConfigModel,
    componentGroup: QcComponentGroup.qcGuardDeviceCountingListComponentKey)
class GuardDeviceCountingListComponent extends StatelessComponent<NoneConfigModel> {
  static const String COMP_KEY = "QC_guard_device_counting_list_component";

  const GuardDeviceCountingListComponent(super.jsonConfig, {super.key});

  @override
  Widget buildView(BuildContext context, configModel) {
    return ChangeNotifierProvider(
      create: (_) => GuardDeviceCountingListProvider(),
      lazy: false,
      child: const QcDeviceCountingListWidget(),
    );
  }

  @override
  Function(Map<String, dynamic> data)? fromConfig() {
    return NoneConfigModel.fromConfig;
  }
}
