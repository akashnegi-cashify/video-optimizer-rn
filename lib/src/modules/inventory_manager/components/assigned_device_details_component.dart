import 'package:builder_component/builder_component.dart';
import 'package:core_widgets/core_widgets.dart';
import 'package:csh_annotation/annotation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/app_builder/app_builder_groups/groups.dart';
import 'package:flutter_trc/src/app_builder/app_headers/general_app_header/models/none_config_model.dart';
import 'package:provider/provider.dart';

import '../models/assigned_device_details_comp_param.dart';
import '../providers/assigned_device_details_provider.dart';
import '../widgets/assiged_device_details_widget.dart';
import '../widgets/assinged_device_alloted_parts_list_widget.dart';

part 'assigned_device_details_component.g.dart';

@CshComponent(
    key: AssignedDeviceDetailsComponent.COMP_KEY,
    configModel: NoneConfigModel,
    params: AssignedDeviceDetailsCompParamKeys.values,
    paramModel: AssignedDeviceDetailsCompParam,
    componentGroup: ComponentGroup.assignedDeviceDetailsComponentKey)
class AssignedDeviceDetailsComponent extends StatelessComponent<NoneConfigModel> {
  static const String COMP_KEY = "TRC_assigned_device_details";

  const AssignedDeviceDetailsComponent(super.jsonConfig, {super.key});

  @override
  Widget buildView(BuildContext context, configModel) {
    return paramBuilder((param) {
      return ChangeNotifierProvider<AssignedDeviceDetailsProvider>(
        create: (_) => AssignedDeviceDetailsProvider(param.did),
        lazy: false,
        builder: (BuildContext innerContext, __) {
          var provider = AssignedDeviceDetailsProvider.of(innerContext);
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: Dimens.space_12, horizontal: Dimens.space_16),
            child: Column(
              children: [
                AssignedDeviceDetailsWidget(
                  dataModel: provider.assignedDeviceDetails?.detailsData,
                  isLoading: provider.isDataLoading,
                  errorMessage: provider.errMessage,
                ),
                const SizedBox(height: Dimens.space_8),
                Expanded(
                  child: AssignedDeviceAllottedPartsList(
                    dataModel: provider.deviceAllottedPartsResponse,
                    isLoading: provider.isListDataLoading,
                    errorMessage: provider.listErrorMessage,
                  ),
                )
              ],
            ),
          );
        },
      );
    });
  }

  @override
  Function(Map<String, dynamic> data)? fromConfig() {
    return NoneConfigModel.fromConfig;
  }
}
