import 'package:builder_component/builder_component.dart';
import 'package:csh_annotation/annotation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/app_builder/app_builder_groups/groups.dart';

import '../models/qc_general_header_config.dart';
import '../widgets/qc_general_header.dart';

part 'qc_general_header_component.g.dart';

@CshComponent(
    key: QcGeneralHeaderComponent.COMP_KEY,
    configModel: QCGeneralHeaderConfig,
    componentGroup: ComponentGroup.qcGeneralHeaderComponentKey)
class QcGeneralHeaderComponent extends StatelessComponent<QCGeneralHeaderConfig> implements PreferredSizeWidget {
  static const String COMP_KEY = "header_QC_qc_general";

  const QcGeneralHeaderComponent(super.jsonConfig, {super.key});

  @override
  Widget buildView(BuildContext context, configModel) {
    return QcGeneralHeader(
      configModel?.headerTitle ?? "",
      showBackBtn: configModel?.showBackButton ?? true,
      showLogoutButton: configModel?.showLogoutButton ?? false,
    );
  }

  @override
  Function(Map<String, dynamic> data)? fromConfig() {
    return QCGeneralHeaderConfig.fromConfig;
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
