import 'package:builder_component/builder_component.dart';
import 'package:csh_annotation/annotation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/rms/modules/facility_list/models/facility_list_param_model.dart';
import 'package:flutter_trc/src/app_builder/app_builder_groups/rms_groups.dart';
import 'package:flutter_trc/src/app_builder/app_headers/general_app_header/models/none_config_model.dart';
import 'package:provider/provider.dart';

import '../widgets/facility_list_widget.dart';

part 'facility_list_component.g.dart';

@CshComponent(
  key: FacilityListComponent.COMP_KEY,
  configModel: NoneConfigModel,
  componentGroup: RmsComponentGroup.rmsFacilityListComponent,
  params: FacilityListPageParamKeys.values,
  paramModel: FacilityListPageParamModel,
)
class FacilityListComponent extends StatelessComponent<NoneConfigModel> {
  static const String COMP_KEY = "RMS_facility_list_component";

  const FacilityListComponent(super.jsonConfig, {super.key});

  @override
  Widget buildView(BuildContext context, configModel) {
    return paramBuilder(
      (model) => FacilityListWidget(model.onFacilitySelected),
    );
  }

  @override
  Function(Map<String, dynamic> data)? fromConfig() {
    return NoneConfigModel.fromConfig;
  }
}
