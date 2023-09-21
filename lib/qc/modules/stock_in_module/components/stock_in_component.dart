import 'package:builder_component/builder_component.dart';
import 'package:csh_annotation/annotation.dart';
import 'package:flutter/material.dart';

import '../../../../src/app_builder/app_builder_groups/groups.dart';
import '../../../../src/app_builder/app_headers/general_app_header/models/none_config_model.dart';
import '../widgets/validate_awd_widget.dart';

part 'stock_in_component.g.dart';

@CshComponent(
    key: StockInComponent.COMP_KEY,
    configModel: NoneConfigModel,
    componentGroup: ComponentGroup.deviceReceiveComponentKey)
class StockInComponent extends StatelessComponent<NoneConfigModel> {
  static const String COMP_KEY = "QC_qc_stock_in_component";

  const StockInComponent(super.jsonConfig, {super.key});

  @override
  Widget buildView(BuildContext context, configModel) {
    return  const ValidateAwdWidget();
  }


  @override
  Function(Map<String, dynamic> data)? fromConfig() {
    return NoneConfigModel.fromConfig;
  }
}
