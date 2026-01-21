import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/qc/modules/store_out/providers/store_out_provider.dart';
import 'package:flutter_trc/qc/modules/store_out/types.dart';
import 'package:flutter_trc/qc/modules/store_out/widgets/store_out_bin_list_widget.dart';
import 'package:flutter_trc/qc/modules/store_out/widgets/store_out_bin_out_widget.dart';
import 'package:flutter_trc/qc/modules/store_out/widgets/store_out_lot_list_container.dart';

import '../l10n.dart';
import '../screens/index.dart';

class StoreOutWidget extends StatefulWidget {
  final StoreOutFacility storeOutFacility;

  const StoreOutWidget(this.storeOutFacility, {super.key});

  @override
  State<StoreOutWidget> createState() => _StoreOutWidgetState();
}

class _StoreOutWidgetState extends State<StoreOutWidget> with TickerProviderStateMixin {
  late TabController _controller;
  late List<Tab> tabList;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    var l10n = L10n(context);
    tabList = [
      if (widget.storeOutFacility == StoreOutFacility.qc) Tab(text: l10n.lotList, key: const ValueKey('lotListTab')),
      Tab(text: l10n.binList, key: const ValueKey('binListTab')),
      Tab(text: l10n.binOut, key: const ValueKey('binOutTab')),
    ];
    _controller = TabController(length: tabList.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        CshTabBar(
          tabs: tabList,
          controller: _controller,
          labelStyle: theme.primaryTextTheme.displaySmall,
          indicatorSize: TabBarIndicatorSize.tab,
          height: const TabBarHeights(
            mobile: Dimens.space_54 + Dimens.space_2,
            tablet: Dimens.space_36 + Dimens.space_2,
            desktop: Dimens.space_36 + Dimens.space_2,
          ),
        ),
        Expanded(
          child: TabBarView(
              controller: _controller,
              children: tabList.map((e) {
                if (e.key == const ValueKey('lotListTab')) {
                  return StoreOutLotListContainer(
                      onItemClick: (lotName, lotId) => _onItemClick(context, lotName, lotId, LotType.NORMAL_LOT.value));
                } else if (e.key == const ValueKey("binListTab")) {
                  return StoreOutBinListWidget(
                      onItemClick: (lotName, lotId) => _onItemClick(context, lotName, lotId, LotType.BIN_LOT.value));
                } else {
                  return const StoreOutBinOutWidget();
                }
              }).toList()),
        ),
      ],
    );
  }

  void _onItemClick(BuildContext context, String? lotName, int? lotId, int lotType) {
    LotItemsScanScreen.navigate(context, lotName: lotName, lotId: lotId, lotType: lotType).then((value) {
      if (lotType == LotType.NORMAL_LOT.value || lotType == LotType.BIN_LOT.value) {
        var provider = StoreOutProvider.of(context, listen: false);
        provider.refreshLotList(lotType);
      }
    });
  }
}
