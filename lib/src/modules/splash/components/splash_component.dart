import 'package:builder_component/builder_component.dart';
import 'package:csh_annotation/annotation.dart';
import 'package:flutter/material.dart';

import '../../../app_builder/app_builder_groups/groups.dart';
import '../models/splash_config.dart';
import '../widgets/splash_widget.dart';

part 'splash_component.g.dart';

@CshComponent(
  key: SplashComponent.COMP_KEY,
  configModel: SplashConfigModel,
  componentGroup: ComponentGroup.splashComponentKey,
)
class SplashComponent extends StatelessComponent<SplashConfigModel> {
  static const String COMP_KEY = "TRC_splash_component";

  const SplashComponent(super.jsonConfig, {super.key});

  @override
  Widget buildView(BuildContext context, configModel) {
    return const SplashWidget();
  }

  @override
  Function(Map<String, dynamic> data)? fromConfig() {
    return SplashConfigModel.fromConfig;
  }
}
