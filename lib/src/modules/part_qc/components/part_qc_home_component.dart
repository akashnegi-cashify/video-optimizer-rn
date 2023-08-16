import 'package:builder_component/builder_component.dart';
import 'package:core_widgets/core_widgets.dart';
import 'package:csh_annotation/annotation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/app_builder/app_builder_groups/groups.dart';
import 'package:provider/provider.dart';

import '../../../common/user/widget/logout_action_widget.dart';
import '../l10n.dart';
import '../models/part_qc_home_comp_config.dart';
import '../providers/pq_provider.dart';
import '../widgets/qc_pending_tab_widget.dart';
import '../widgets/reader_tab_widget.dart';

part 'part_qc_home_component.g.dart';

@CshComponent(
  key: PartQcHomeComponent.COMP_KEY,
  configModel: PartQcHomeCompConfig,
  componentGroup: ComponentGroup.partQcHomeComponentKey,
)
class PartQcHomeComponent extends StatelessComponent<PartQcHomeCompConfig> {
  static const String COMP_KEY = "TRC_part_qc_home_component";

  const PartQcHomeComponent(super.jsonConfig, {super.key});

  @override
  Widget buildView(BuildContext context, configModel) {
    var l10n = L10n(context);
    var theme = Theme.of(context);
    return ChangeNotifierProvider<PartQcProvider>(
      create: (_) => PartQcProvider(),
      lazy: false,
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: CshHeader(
            l10n.partQc,
            showBackBtn: false,
            actions: [LogoutActionWidget()],
            bottom: TabBar(
              labelStyle: theme.primaryTextTheme.headline4,
              labelColor: theme.primaryColor,
              unselectedLabelStyle: theme.primaryTextTheme.bodyText2,
              unselectedLabelColor: theme.primaryColor,
              indicatorColor: theme.primaryColor,
              indicatorWeight: Dimens.space_5,
              tabs: [
                Tab(text: l10n.reader.toUpperCase()),
                Tab(text: l10n.qcPending.toUpperCase()),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              ReaderTabWidget(),
              QcPendingTabWidget(),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Function(Map<String, dynamic> data)? fromConfig() {
    return PartQcHomeCompConfig.fromConfig;
  }
}
