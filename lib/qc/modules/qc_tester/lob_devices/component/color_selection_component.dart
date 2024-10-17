import 'package:builder_component/builder_component.dart';
import 'package:csh_annotation/annotation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/qc/modules/qc_tester/lob_devices/models/color_selection_screen_arg_model.dart';
import 'package:flutter_trc/qc/modules/qc_tester/lob_devices/providers/color_selection_provider.dart';
import 'package:flutter_trc/qc/modules/qc_tester/lob_devices/widgets/color_selection_widget.dart';
import 'package:flutter_trc/src/app_builder/app_builder_groups/qc_groups.dart';
import 'package:flutter_trc/src/app_builder/app_headers/general_app_header/models/none_config_model.dart';
import 'package:provider/provider.dart';

part 'color_selection_component.g.dart';

@CshComponent(
  key: ColorSelectionComponent.COMP_KEY,
  configModel: NoneConfigModel,
  componentGroup: QcComponentGroup.qcColorSelectionComponentKey,
  params: ColorSelectionScreenArgModelKeys.values,
  paramModel: ColorSelectionScreenArgModel,
)
class ColorSelectionComponent extends StatelessComponent<NoneConfigModel> {
  static const String COMP_KEY = "QC_color_selection_component";

  const ColorSelectionComponent(super.jsonConfig, {super.key});

  @override
  Widget buildView(BuildContext context, configModel) {
    return paramBuilder((model) {
      return ChangeNotifierProvider(
        create: (_) => ColorSelectionProvider(model.productId),
        child: ColorSelectionWidget(model.deviceBarcode, model.onColorSelected),
      );
    });
  }

  @override
  Function(Map<String, dynamic> data)? fromConfig() {
    return NoneConfigModel.fromConfig;
  }
}
