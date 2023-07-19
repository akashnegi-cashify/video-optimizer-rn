import 'package:builder_component/builder_component.dart';
import 'package:csh_annotation/annotation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/app_builder/app_builder_groups/groups.dart';

import '../models/rider_home_comp_config.dart';
import '../rider_home_widget.dart';

part 'rider_home_component.g.dart';

@CshComponent(
    key: RiderHomeComponent.COMP_KEY,
    configModel: RiderHomeCompConfig,
    componentGroup: ComponentGroup.riderHomeComponentKey)
class RiderHomeComponent extends StatelessComponent<RiderHomeCompConfig> {
  static const String COMP_KEY = "TRC_rider_home_component";

  const RiderHomeComponent(super.jsonConfig, {super.key});

  @override
  Widget buildView(BuildContext context, configModel) {
    return const RiderWidget();
  }

  @override
  Function(Map<String, dynamic> data)? fromConfig() {
    return RiderHomeCompConfig.fromConfig;
  }
}
