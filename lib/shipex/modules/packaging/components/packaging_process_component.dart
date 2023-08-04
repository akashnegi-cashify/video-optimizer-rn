import 'package:builder_component/builder_component.dart';
import 'package:csh_annotation/annotation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/app_builder/app_builder_groups/groups.dart';
import 'package:flutter_trc/src/app_builder/app_headers/general_app_header/models/none_config_model.dart';
import 'package:provider/provider.dart';

import '../models/packaging_process_comp_param.dart';
import '../widgets/packaging_process_widget.dart';

part 'packaging_process_component.g.dart';

@CshComponent(
    key: PackagingProcessComponent.COMP_KEY,
    componentGroup: ComponentGroup.packagingProcessComponentKey,
    paramModel: PackagingProcessCompParam,
    params: PackagingProcessCompParamKeys.values,
    configModel: NoneConfigModel)
class PackagingProcessComponent extends StatelessComponent<NoneConfigModel> {
  static const String COMP_KEY = "packaging_process_component";

  const PackagingProcessComponent(super.jsonConfig, {super.key});

  @override
  Widget buildView(BuildContext context, NoneConfigModel? configModel) {
    return paramBuilder((param) {
      return PackagingProcessWidget(
        dataModel: param.dataModel,
        isGroupLotPending: param.isGroupLotPending,
        isCCTVCameraSelected: param.isCCTVSelected ?? false,
      );
    });
  }

  @override
  Function(Map<String, dynamic> data)? fromConfig() {
    return NoneConfigModel.fromConfig;
  }
}
