import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/shipex/modules/packaging/widgets/pending_order_data_list_widget.dart';
import 'package:provider/provider.dart';

import '../l10n.dart';
import '../providers/group_list_provider.dart';
import 'new_order_data_list.dart';

class ShipexPackagingWidget extends StatelessWidget {
  const ShipexPackagingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var l10n = L10n(context);
    return ChangeNotifierProvider<GroupListProvider>(
      create: (_) => GroupListProvider(),
      lazy: false,
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: CshHeader(
            l10n.shipexPacking,
            showBackBtn: true,
            bottom: TabBar(
              indicatorColor: theme.primaryColor,
              indicatorWeight: Dimens.space_4,
              unselectedLabelStyle: theme.primaryTextTheme.bodyMedium,
              labelStyle: theme.primaryTextTheme.headlineMedium,
              tabs: [
                Text(l10n.newString.toUpperCase()),
                Text(l10n.pending.toUpperCase()),
              ],
            ),
          ),
          body: const Column(
            children: [
              Expanded(
                child: TabBarView(
                  children: [
                    NewOrderDataList(),
                    PendingOrderDataList(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
