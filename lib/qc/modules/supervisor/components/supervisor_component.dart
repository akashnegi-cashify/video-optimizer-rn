import 'package:builder_component/builder_component.dart';
import 'package:csh_annotation/annotation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/qc/modules/supervisor/models/supervisor_param_model.dart';
import 'package:flutter_trc/qc/modules/supervisor/providers/supervisor_provider.dart';
import 'package:flutter_trc/qc/modules/supervisor/widgets/supervisor_widget.dart';
import 'package:flutter_trc/src/app_builder/app_builder_groups/qc_groups.dart';
import 'package:flutter_trc/src/app_builder/app_headers/general_app_header/models/none_config_model.dart';
import 'package:provider/provider.dart';

part 'supervisor_component.g.dart';

@CshComponent(
  key: SupervisorComponent.COMP_KEY,
  configModel: NoneConfigModel,
  componentGroup: QcComponentGroup.qcSupervisorComponentKey,
  params: SupervisorParamModelKeys.values,
  paramModel: SupervisorParamModel,
)
class SupervisorComponent extends StatelessComponent<NoneConfigModel> {
  static const String COMP_KEY = "QC_supervisor_component";

  const SupervisorComponent(super.jsonConfig, {super.key});

  @override
  Widget buildView(BuildContext context, configModel) {
    return paramBuilder(
      (model) => ChangeNotifierProvider(
        create: (_) => SupervisorProvider(model.deviceBarcode!),
        lazy: false,
        child: const SupervisorWidget(),
      ),
    );
  }

  @override
  Function(Map<String, dynamic> data)? fromConfig() {
    return NoneConfigModel.fromConfig;
  }
}
