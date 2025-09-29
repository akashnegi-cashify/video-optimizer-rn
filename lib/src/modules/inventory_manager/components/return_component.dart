import 'package:builder_component/builder_component.dart';
import 'package:core_widgets/core_widgets.dart';
import 'package:csh_annotation/annotation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/app_builder/app_builder_groups/groups.dart';
import 'package:flutter_trc/src/app_builder/app_headers/general_app_header/models/none_config_model.dart';
import 'package:provider/provider.dart';

import '../l10n.dart';
import '../providers/return_page_provider.dart';
import '../widgets/receive_tab_widget.dart';
import '../widgets/return_tab_widget.dart';

part 'return_component.g.dart';

@CshComponent(
    key: ReturnComponent.COMP_KEY, configModel: NoneConfigModel, componentGroup: ComponentGroup.returnComponentKey)
class ReturnComponent extends StatelessComponent<NoneConfigModel> {
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
                labelStyle: theme.primaryTextTheme.headlineMedium,
                labelColor: theme.primaryColor,
                unselectedLabelStyle: theme.primaryTextTheme.bodyMedium,
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
    return NoneConfigModel.fromConfig;
  }
}
