import 'package:builder_component/builder_component.dart';
import 'package:core_widgets/core_widgets.dart';
import 'package:csh_annotation/annotation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/app_builder/app_builder_groups/groups.dart';
import 'package:provider/provider.dart';

import '../l10n.dart';
import '../models/return_comp_config.dart';
import '../providers/return_page_provider.dart';
import '../widgets/receive_tab_widget.dart';
import '../widgets/return_tab_widget.dart';

part 'return_component.g.dart';

@CshComponent(
    key: ReturnComponent.COMP_KEY, configModel: ReturnCompConfig, componentGroup: ComponentGroup.returnComponentKey)
class ReturnComponent extends StatelessComponent<ReturnCompConfig> {
  static const String COMP_KEY = "TRC_return_comp";

  const ReturnComponent(super.jsonConfig, {super.key});

  @override
  Widget buildView(BuildContext context, configModel) {
    var theme = Theme.of(context);
    var l10n = L10n(context);
    return ChangeNotifierProvider<ReturnProvider>(
      create: (_) => ReturnProvider(),
      lazy: false,
      builder: (BuildContext insideContext, __) {
        return DefaultTabController(
          length: 2,
          child: Scaffold(
            appBar: CshHeader(
              l10n.returns,
              showBackBtn: true,
              bottom: TabBar(
                labelStyle: theme.primaryTextTheme.headline4,
                labelColor: theme.primaryColor,
                unselectedLabelStyle: theme.primaryTextTheme.bodyText2,
                indicatorWeight: Dimens.space_4,
                indicatorColor: theme.primaryColor,
                tabs: [
                  Tab(text: l10n.receive),
                  Tab(text: l10n.returns),
                ],
              ),
            ),
            body: const TabBarView(
              children: [
                ReceiveTabWidget(),
                ReturnTabWidget(),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Function(Map<String, dynamic> data)? fromConfig() {
    return ReturnCompConfig.fromConfig;
  }
}
