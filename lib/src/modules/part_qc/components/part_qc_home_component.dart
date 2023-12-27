import 'package:builder_component/builder_component.dart';
import 'package:core_widgets/core_widgets.dart';
import 'package:csh_annotation/annotation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/app_builder/app_builder_groups/groups.dart';
import 'package:flutter_trc/src/app_builder/app_headers/general_app_header/models/none_config_model.dart';
import 'package:flutter_trc/src/modules/engineer/components/retrieved_part_list_component.dart';
import 'package:provider/provider.dart';

import '../l10n.dart';
import '../providers/pq_provider.dart';
import '../widgets/qc_pending_tab_widget.dart';

part 'part_qc_home_component.g.dart';

@CshComponent(
  key: PartQcHomeComponent.COMP_KEY,
  configModel: NoneConfigModel,
  componentGroup: ComponentGroup.partQcHomeComponentKey,
)
class PartQcHomeComponent extends StatelessComponent<NoneConfigModel> {
  static const String COMP_KEY = "TRC_part_qc_home_component";

  const PartQcHomeComponent(super.jsonConfig, {super.key});

  @override
  Widget buildView(BuildContext context, configModel) {
    return ChangeNotifierProvider(
      create: (context) => PartQcProvider(),
      lazy: false,
      child: const _PartQcHomeWidget(),
    );
  }

  @override
  Function(Map<String, dynamic> data)? fromConfig() {
    return NoneConfigModel.fromConfig;
  }
}

class _PartQcHomeWidget extends StatefulWidget {
  const _PartQcHomeWidget({super.key});

  @override
  State<_PartQcHomeWidget> createState() => _PartQcHomeWidgetState();
}

class _PartQcHomeWidgetState extends State<_PartQcHomeWidget> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var l10n = L10n(context);
    var theme = Theme.of(context);

    return Column(
      children: [
        CshTabBar(
            controller: _tabController,
            indicatorSize: TabBarIndicatorSize.tab,
            height: const TabBarHeights(mobile: Dimens.space_50, tablet: Dimens.space_45, desktop: Dimens.space_45),
            labelStyle: theme.primaryTextTheme.titleSmall,
            tabs: [
              Tab(text: l10n.qcPending.toUpperCase()),
              Tab(text: l10n.retrievedParts.toUpperCase()),
            ]),
        Expanded(
          child: TabBarView(controller: _tabController, children: const [
            QcPendingTabWidget(),
            RetrievedPartListComponent(null, roleType: RoleType.partQc),
          ]),
        )
      ],
    );
  }
}
