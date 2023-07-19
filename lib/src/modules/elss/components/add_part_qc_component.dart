import 'package:builder_component/builder_component.dart';
import 'package:core_widgets/core_widgets.dart';
import 'package:csh_annotation/annotation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/app_builder/app_builder_groups/groups.dart';
import 'package:provider/provider.dart';

import '../common_models/add_parts_qc_comp_config.dart';
import '../common_models/add_parts_qc_comp_param.dart';
import '../elss_qc/providers/add_part_list_provider_qc.dart';
import '../elss_qc/widgets/add_part_list_widget_qc.dart';

part 'add_part_qc_component.g.dart';

@CshComponent(
    key: AddPartsQcComponent.COMP_KEY,
    configModel: AddPartsQcCompConfig,
    params: AddPartsQCCompParamKeys.values,
    paramModel: AddPartsQCCompParam,
    componentGroup: ComponentGroup.addPartsQcComponentKey)
class AddPartsQcComponent extends StatelessComponent<AddPartsQcCompConfig> {
  static const String COMP_KEY = "TRC_add_part_QC_comp";

  const AddPartsQcComponent(super.jsonConfig, {super.key});

  @override
  Widget buildView(BuildContext context, configModel) {
    return paramBuilder(
      (param) {
        return ChangeNotifierProvider<AddPartListProviderQc>(
          create: (_) => AddPartListProviderQc(param.scannedBarcode ?? ""),
          lazy: false,
          builder: (BuildContext innerContext, __) {
            var provider = AddPartListProviderQc.of(innerContext);
            return (provider.isPartListLoading)
                ? const Center(
                    child: SizedBox(
                      height: Dimens.space_30,
                      width: Dimens.space_30,
                      child: CircularProgressIndicator(),
                    ),
                  )
                : const AddPartListWidgetQc();
          },
        );
      },
    );
  }

  @override
  Function(Map<String, dynamic> data)? fromConfig() {
    return AddPartsQcCompConfig.fromConfig;
  }
}
