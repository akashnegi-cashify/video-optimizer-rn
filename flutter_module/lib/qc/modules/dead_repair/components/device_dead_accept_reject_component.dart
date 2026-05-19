import 'package:builder_component/builder_component.dart';
import 'package:csh_annotation/annotation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/qc/modules/dead_repair/models/index.dart';
import 'package:flutter_trc/src/app_builder/app_headers/general_app_header/models/none_config_model.dart';
import 'package:provider/provider.dart';

import '../../../../src/app_builder/app_builder_groups/groups.dart';
import '../widgets/index.dart';

part 'device_dead_accept_reject_component.g.dart';

@CshComponent(
  key: DeviceDeadAcceptRejectComponent.COMP_KEY,
  configModel: NoneConfigModel,
  componentGroup: ComponentGroup.DeviceDeadAcceptReject,
  params: DeviceDeadAcceptRejectCompParamKeys.values,
  paramModel: DeviceDeadAcceptRejectCompParam,
)
class DeviceDeadAcceptRejectComponent extends StatelessComponent<NoneConfigModel> {
  static const String COMP_KEY = "QC_qc_device_dead_accept_reject_component";

  const DeviceDeadAcceptRejectComponent(super.jsonConfig, {super.key});

  @override
  Widget buildView(BuildContext context, configModel) {
    return paramBuilder(
      (paramModel) => DeviceDeadAcceptRejectWidget(
        markId: paramModel.markId,
        barcode: paramModel.code,
        preSelectedRemark: paramModel.selectedReason,
      ),
    );
  }

  @override
  Function(Map<String, dynamic> data)? fromConfig() {
    return NoneConfigModel.fromConfig;
  }
}
