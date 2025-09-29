import 'package:builder_component/builder_component.dart';
import 'package:csh_annotation/annotation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/qc/modules/qc_tester/calculator_media_capture/models/calculator_media_capture_comp_param.dart';
import 'package:flutter_trc/src/app_builder/app_builder_groups/groups.dart';
import 'package:flutter_trc/src/app_builder/app_headers/general_app_header/models/none_config_model.dart';
import 'package:provider/provider.dart';

import '../providers/calculator_media_capture_provider.dart';
import '../widgets/calculator_media_capture_widget.dart';

part 'calculator_media_capture_component.g.dart';

@CshComponent(
    key: CalculatorMediaCaptureComponent.COMP_KEY,
    componentGroup: ComponentGroup.calculatorMediaCaptureComponentKey,
    params: CalculatorMediaCaptureParamKeys.values,
    paramModel: CalculatorMediaCaptureParam,
    configModel: NoneConfigModel)
class CalculatorMediaCaptureComponent extends StatelessComponent<NoneConfigModel> {
  static const String COMP_KEY = "calculator_media_capture";

  const CalculatorMediaCaptureComponent(super.jsonConfig, {super.key});

  @override
  Widget buildView(BuildContext context, configModel) {
    return paramBuilder(
      (model) {
        return ChangeNotifierProvider<CalculatorMediaCaptureProvider>(
          create: (_) => CalculatorMediaCaptureProvider(
            model.deviceBarcode ?? "",
            model.journeyType,
            categoryId: model.categoryId,
          ),
          lazy: false,
          child: CalculatorMediaCaptureWidget(onMediaListUpdated: model.onMediaListUpdated),
        );
      },
    );
  }

  @override
  Function(Map<String, dynamic> data)? fromConfig() {
    return NoneConfigModel.fromConfig;
  }
}
