import 'package:builder_component/builder_component.dart';
import 'package:csh_annotation/annotation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/header/trc_header.dart';

import '../../../app_builder_groups/groups.dart';
import '../models/general_header_config.dart';

part 'general_header_component.g.dart';

@CshComponent(
    key: GeneralHeaderComponent.COMP_KEY,
    configModel: GeneralHeaderConfig,
    componentGroup: ComponentGroup.generalHeaderComponentKey)
class GeneralHeaderComponent extends StatelessComponent<GeneralHeaderConfig> implements PreferredSizeWidget {
  static const String COMP_KEY = "header_TRC_general_component";

  const GeneralHeaderComponent(super.jsonConfig, {super.key});

  @override
  Widget buildView(BuildContext context, configModel) {
    return TrcHeader(configModel?.headerTitle ?? "",
        showBackBtn: configModel?.showBackButton ?? false, showLogoutButton: configModel?.showLogoutButton ?? false);
  }

  @override
  Function(Map<String, dynamic> data)? fromConfig() {
    return GeneralHeaderConfig.fromConfig;
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
