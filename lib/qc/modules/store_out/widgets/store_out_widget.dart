import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/qc/modules/store_out/providers/store_out_provider.dart';
import 'package:flutter_trc/qc/modules/store_out/types.dart';
import 'package:provider/provider.dart';

import '../l10n.dart';
import '../screens/index.dart';
import 'index.dart';

class StoreOutWidget extends StatefulWidget {
  const StoreOutWidget({super.key});

  @override
  State<StoreOutWidget> createState() => _StoreOutWidgetState();
}

class _StoreOutWidgetState extends State<StoreOutWidget> with SingleTickerProviderStateMixin {
  late TabController _controller;
  late List<Tab> tabList;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    var l10n = L10n(context);
    tabList = [Tab(text: l10n.lotList), Tab(text: l10n.binList), Tab(text: l10n.binOut)];
    _controller = TabController(length: tabList.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return ChangeNotifierProvider(
      create: (_) => StoreOutProvider(),
      child: Builder(builder: (builderContext) {
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
              children: [
                StoreOutLotListContainer(onItemClick: (value)=>_onItemClick(builderContext,value,LotType.NORMAL_LOT.value)),
                StoreOutBinListWidget(onItemClick: (value)=>_onItemClick(builderContext,value,LotType.BIN_LOT.value)),
                const StoreOutBinOutWidget(),
              ],
            )),
          ],
        );
      }),
    );
  }

  void _onItemClick(BuildContext context,String? lotName,int lotType) {
    var provider = StoreOutProvider.of(context,listen: false);
    LotItemsScanScreen.navigate(context, lotName: lotName, lotType: lotType).then((value){
      if(lotType == LotType.NORMAL_LOT.value){
        provider.refreshLotList();
      }

      else if(lotType == LotType.BIN_LOT.value){
        provider.fetchStoreOutBinList();
      }
    });
  }
}
