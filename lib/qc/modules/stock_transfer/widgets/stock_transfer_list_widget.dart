import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/qc/modules/stock_transfer/providers/stock_transfer_list_provider.dart';
import 'package:flutter_trc/qc/modules/stock_transfer/widgets/st_list_tab.dart';
import 'package:provider/provider.dart';

import '../l10n.dart';

class StockTransferListWidget extends StatefulWidget {
  const StockTransferListWidget({super.key});

  @override
  State<StockTransferListWidget> createState() => _StockTransferListWidgetState();
}

class _StockTransferListWidgetState extends State<StockTransferListWidget> with SingleTickerProviderStateMixin {
  late TabController _tabBarController;

  @override
  void initState() {
    _tabBarController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var l10n = L10n(context);
    return Column(
      children: [
        CshTabBar(
          indicatorSize: TabBarIndicatorSize.tab,
          tabs: [
            CshTab(label: l10n.pending.toUpperCase()),
            CshTab(label: l10n.dispatchPending.toUpperCase()),
            CshTab(label: l10n.storeOut.toUpperCase())
          ],
          controller: _tabBarController,
          labelPadding: EdgeInsets.zero,
          height: const TabBarHeights(mobile: 56, tablet: 38, desktop: 38),
        ),
        Expanded(
          child: TabBarView(controller: _tabBarController, children: [
            ChangeNotifierProvider(
              create: (_) => StockTransferListProvider(),
              child: const StListTab(tabType: StockTransferListTab.pending),
            ),
            ChangeNotifierProvider(
              create: (_) => StockTransferListProvider(),
              child: const StListTab(tabType: StockTransferListTab.dispatchPending),
            ),
            ChangeNotifierProvider(
              create: (_) => StockTransferListProvider(),
              child: const StListTab(tabType: StockTransferListTab.storeOut),
            ),
          ]),
        ),
      ],
    );
  }
}
