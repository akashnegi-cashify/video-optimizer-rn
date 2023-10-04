import 'package:builder_component/builder_component.dart';
import 'package:csh_annotation/annotation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/app_builder/app_builder_groups/groups.dart';

import '../models/shipex_general_header_config.dart';
import '../widgets/shipex_general_header_widget.dart';

part 'shipex_general_header_component.g.dart';

@CshComponent(
    key: ShipexGeneralHeaderComponent.COMP_KEY,
    configModel: ShipexGeneralHeaderConfig,
    componentGroup: ComponentGroup.shipexGeneralHeaderComponentKey)
class ShipexGeneralHeaderComponent extends StatelessComponent<ShipexGeneralHeaderConfig>
    implements PreferredSizeWidget {
  static const String COMP_KEY = "header_shipex_general";

  const ShipexGeneralHeaderComponent(super.jsonConfig, {super.key});

  @override
  Widget buildView(BuildContext context, configModel) {
    return ShipexGeneralHeader(
      configModel?.headerTitle ?? "",
      showBackBtn: configModel?.showBackButton ?? true,
      showLogoutButton: configModel?.showLogoutButton ?? false,
    );
  }

  @override
  Function(Map<String, dynamic> data)? fromConfig() {
    return ShipexGeneralHeaderConfig.fromConfig;
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
