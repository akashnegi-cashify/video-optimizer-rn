import 'package:builder_component/builder_component.dart';
import 'package:csh_annotation/annotation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/qc/modules/data_wipe/providers/data_wipe_detail_provider.dart';
import 'package:flutter_trc/qc/modules/data_wipe/widgets/data_wipe_detail_widget.dart';
import 'package:flutter_trc/src/app_builder/app_builder_groups/qc_groups.dart';
import 'package:flutter_trc/src/app_builder/app_headers/general_app_header/models/none_config_model.dart';
import 'package:flutter_trc/src/common/model/device_barcode_param_model.dart';
import 'package:provider/provider.dart';

part 'data_wipe_detail_component.g.dart';

@CshComponent(
    key: DataWipeDetailComponent.COMP_KEY,
    configModel: NoneConfigModel,
    componentGroup: QcComponentGroup.qcDataWipeDetailComponentKey,
    params: DeviceBarcodeParamKeys.values,
    paramModel: DeviceBarcodeParamModel)
class DataWipeDetailComponent extends StatelessComponent<NoneConfigModel> {
  static const String COMP_KEY = "QC_data_wipe_detail_component";

  const DataWipeDetailComponent(super.jsonConfig, {super.key});

  @override
  Widget buildView(BuildContext context, configModel) {
    return paramBuilder(
      (model) {
        return ChangeNotifierProvider(
          create: (_) => DataWipeDetailProvider(model.deviceBarcode ?? ""),
          child: const DataWipeDetailWidget(),
        );
      },
    );
  }

  @override
  Function(Map<String, dynamic> data)? fromConfig() {
    return NoneConfigModel.fromConfig;
  }
}
