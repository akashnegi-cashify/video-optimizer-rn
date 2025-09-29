import 'package:builder_component/builder_component.dart';
import 'package:csh_annotation/annotation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/app_builder/app_builder_groups/groups.dart';
import 'package:provider/provider.dart';

import '../models/rms_general_header_config.dart';
import '../models/rms_general_header_param.dart';
import '../widgets/rms_general_header.dart';

part 'rms_general_header_component.g.dart';

@CshComponent(
  key: RmsGeneralHeaderComponent.COMP_KEY,
  configModel: RmsGeneralHeaderConfig,
  componentGroup: ComponentGroup.qcGeneralHeaderComponentKey,
  paramModel: RmsGeneralHeaderParam,
  params: RmsGeneralHeaderParamKeys.values,
)
class RmsGeneralHeaderComponent extends StatelessComponent<RmsGeneralHeaderConfig> implements PreferredSizeWidget {
  static const String COMP_KEY = "header_rms_general";

  const RmsGeneralHeaderComponent(super.jsonConfig, {super.key});

  @override
  Widget buildView(BuildContext context, configModel) {
    return paramBuilder((model) => RmsGeneralHeader(
          model.header ?? configModel?.headerTitle ?? "",
          showBackBtn: configModel?.showBackButton ?? true,
          showLogoutButton: configModel?.showLogoutButton ?? false,
          showProfileButton: configModel?.showProfileButton ?? false,
        ));
  }

  @override
  Function(Map<String, dynamic> data)? fromConfig() {
    return RmsGeneralHeaderConfig.fromConfig;
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
