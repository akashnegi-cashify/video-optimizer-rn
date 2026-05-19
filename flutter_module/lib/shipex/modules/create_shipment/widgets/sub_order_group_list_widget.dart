import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/shipex/modules/create_shipment/widgets/sub_order_tab_widget.dart';
import 'package:provider/provider.dart';

import '../l10n.dart';
import '../providers/sub_order_group_list_provider.dart';

class SubOrderGroupListWidget extends StatelessWidget {
  const SubOrderGroupListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var l10n = L10n(context);
    var theme = Theme.of(context);
    return ChangeNotifierProvider<SubOrderGroupListProvider>(
      create: (_) => SubOrderGroupListProvider(),
      lazy: false,
      builder: (BuildContext insideContext, __) {
        return DefaultTabController(
          length: 2,
          child: Scaffold(
            appBar: CshHeader(
              l10n.createShipment,
              showBackBtn: true,
              bottom: TabBar(
                labelStyle: theme.primaryTextTheme.headlineMedium,
                labelColor: theme.primaryColor,
                unselectedLabelStyle: theme.primaryTextTheme.bodyMedium,
                unselectedLabelColor: theme.primaryColor,
                indicatorColor: theme.primaryColor,
                indicatorWeight: Dimens.space_5,
                tabs: [
                  Tab(text: l10n.pending.toUpperCase()),
                  Tab(text: l10n.created.toUpperCase()),
                ],
              ),
            ),
            body: const Column(
              children: [
                Expanded(
                  child: TabBarView(
                    children: [
                      SubOrderGroupTabWidget(shipmentNumber: 0),
                      SubOrderGroupTabWidget(shipmentNumber: 1),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
