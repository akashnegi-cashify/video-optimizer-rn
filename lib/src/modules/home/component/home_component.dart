import 'package:builder_component/builder_component.dart';
import 'package:csh_annotation/annotation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/app_builder/app_builder_groups/groups.dart';
import 'package:flutter_trc/src/modules/home/models/home_comp_config.dart';

import '../widgets/home_widget.dart';

part 'home_component.g.dart';

@CshComponent(
    key: HomeComponent.COMP_KEY, configModel: HomeConfigModel, componentGroup: ComponentGroup.homeComponentKey)
class HomeComponent extends StatelessComponent {
  static const String COMP_KEY = "TRC_home_component";

  const HomeComponent(super.jsonConfig, {super.key});

  @override
  Widget buildView(BuildContext context, configModel) {
    return const HomeWidget();
  }

  @override
  Function(Map<String, dynamic> data)? fromConfig() {
    return HomeConfigModel.fromConfig;
  }
}
