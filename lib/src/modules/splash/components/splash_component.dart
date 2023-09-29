import 'package:builder_component/builder_component.dart';
import 'package:csh_annotation/annotation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/app_builder/app_headers/general_app_header/models/none_config_model.dart';

import '../../../app_builder/app_builder_groups/groups.dart';
import '../widgets/splash_widget.dart';

part 'splash_component.g.dart';

@CshComponent(
  key: SplashComponent.COMP_KEY,
  configModel: NoneConfigModel,
  componentGroup: ComponentGroup.splashComponentKey,
)
class SplashComponent extends StatelessComponent<NoneConfigModel> {
  static const String COMP_KEY = "TRC_splash_component";

  const SplashComponent(super.jsonConfig, {super.key});

  @override
  Widget buildView(BuildContext context, configModel) {
    return const SplashWidget();
  }

  @override
  Function(Map<String, dynamic> data)? fromConfig() {
    return NoneConfigModel.fromConfig;
  }
}
