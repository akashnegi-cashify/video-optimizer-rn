import 'package:builder_component/builder_component.dart';
import 'package:csh_annotation/annotation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/qc/modules/warehouse_audit/models/warehouse_audit_perform_param_model.dart';
import 'package:flutter_trc/qc/modules/warehouse_audit/providers/warehouse_audit_perform_provider.dart';
import 'package:flutter_trc/qc/modules/warehouse_audit/widgets/warehouse_audit_perform_widget.dart';
import 'package:flutter_trc/src/app_builder/app_builder_groups/qc_groups.dart';
import 'package:flutter_trc/src/app_builder/app_headers/general_app_header/models/none_config_model.dart';
import 'package:provider/provider.dart';

part 'warehouse_audit_perform_component.g.dart';

@CshComponent(
  key: WarehouseAuditPerformComponent.COMP_KEY,
  configModel: NoneConfigModel,
  componentGroup: QcComponentGroup.qcWarehouseAuditPerformComponentKey,
  params: WarehouseAuditPerformParamModelKeys.values,
  paramModel: WarehouseAuditPerformParamModel,
)
class WarehouseAuditPerformComponent extends StatelessComponent<NoneConfigModel> {
  static const String COMP_KEY = "QC_warehouse_audit_perform_component";

  const WarehouseAuditPerformComponent(super.jsonConfig, {super.key});

  @override
  Widget buildView(BuildContext context, configModel) {
    return paramBuilder((model) {
      return ChangeNotifierProvider(
        create: (_) => WarehouseAuditPerformProvider(model.auditId!),
        child: const WarehouseAuditPerformWidget(),
      );
    });
  }

  @override
  Function(Map<String, dynamic> data)? fromConfig() {
    return NoneConfigModel.fromConfig;
  }
}
