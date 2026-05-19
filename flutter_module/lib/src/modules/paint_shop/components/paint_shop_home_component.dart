import 'package:builder_component/builder_component.dart';
import 'package:csh_annotation/annotation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/app_builder/app_headers/general_app_header/models/none_config_model.dart';
import 'package:flutter_trc/src/modules/paint_shop/widgets/paint_shop_home_widget.dart';

import '../../../app_builder/app_builder_groups/groups.dart';

part 'paint_shop_home_component.g.dart';

@CshComponent(
  key: PaintShopHomeComponent.COMP_KEY,
  configModel: NoneConfigModel,
  componentGroup: ComponentGroup.paintShopHomeComponentKey,
)
class PaintShopHomeComponent extends StatelessComponent<NoneConfigModel> {
  static const String COMP_KEY = "TRC_paint_shop_home_component";

  const PaintShopHomeComponent(super.jsonConfig, {super.key});

  @override
  Widget buildView(BuildContext context, configModel) {
    return PaintShopHomeWidget();
  }

  @override
  Function(Map<String, dynamic> data)? fromConfig() {
    return NoneConfigModel.fromConfig;
  }
}
