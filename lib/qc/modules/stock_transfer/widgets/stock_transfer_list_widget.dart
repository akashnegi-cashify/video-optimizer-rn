import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/qc/modules/stock_transfer/models/stock_transfer_list_response.dart';
import 'package:flutter_trc/qc/modules/stock_transfer/providers/stock_transfer_list_provider.dart';
import 'package:flutter_trc/qc/modules/stock_transfer/screens/st_store_out_screen.dart';
import 'package:flutter_trc/qc/modules/stock_transfer/widgets/st_list_tab.dart';

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
    var provider = StockTransferListProvider.of(context);
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
            StListTab(
              tabType: StockTransferListTab.pending,
              onItemClicked: (StockTransferListData item) {},
            ),
            StListTab(
              tabType: StockTransferListTab.dispatchPending,
              onItemClicked: (StockTransferListData item) {},
            ),
            StListTab(
              tabType: StockTransferListTab.storeOut,
              onItemClicked: (StockTransferListData item) async {
                var isRefresh = await Navigator.pushNamed(context, StStoreOutScreen.route,
                    arguments: StStoreOutScreen.arguments(item.lotId!));
                // TODO: make it working
                if (isRefresh == true) {
                  provider.getList(StockTransferListTab.storeOut);
                }
              },
            ),
          ]),
        ),
      ],
    );
  }
}
