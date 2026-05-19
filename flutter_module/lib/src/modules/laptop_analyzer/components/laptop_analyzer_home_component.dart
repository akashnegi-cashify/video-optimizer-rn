import 'package:builder_component/builder_component.dart';
import 'package:csh_annotation/annotation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/app_builder/app_headers/general_app_header/models/none_config_model.dart';
import 'package:flutter_trc/src/modules/laptop_analyzer/widgets/laptop_analyzer_home_widget.dart';

import '../../../app_builder/app_builder_groups/groups.dart';

part 'laptop_analyzer_home_component.g.dart';

@CshComponent(
  key: LaptopAnalyzerHomeComponent.COMP_KEY,
  configModel: NoneConfigModel,
  componentGroup: ComponentGroup.laptopAnalyzerHomeComponentKey,
)
class LaptopAnalyzerHomeComponent extends StatelessComponent<NoneConfigModel> {
  static const String COMP_KEY = "TRC_laptop_analyzer_home_component";

  const LaptopAnalyzerHomeComponent(super.jsonConfig, {super.key});

  @override
  Widget buildView(BuildContext context, configModel) {
    return const LaptopAnalyzerHomeWidget();
  }

  @override
  Function(Map<String, dynamic> data)? fromConfig() {
    return NoneConfigModel.fromConfig;
  }
}
