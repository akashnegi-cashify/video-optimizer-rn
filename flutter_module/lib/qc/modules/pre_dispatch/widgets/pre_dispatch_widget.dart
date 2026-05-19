import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/common/widgets/labeled_text.dart';

import '../providers/pre_dispatch_provider.dart';
import '../types.dart';
import 'index.dart';

class PreDispatchWidget extends StatefulWidget {
  const PreDispatchWidget({super.key});

  @override
  State<PreDispatchWidget> createState() => _PreDispatchWidgetState();
}

class _PreDispatchWidgetState extends State<PreDispatchWidget> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool _isTabTap = false;
  List<Tab> preDispatchTabs = [
    const Tab(text: "ALL"),
    const Tab(text: "SCANNED", key: ValueKey(DispatchConstants.SCANNED_STATUS)),
    const Tab(text: "PENDING", key: ValueKey(DispatchConstants.PENDING_STATUS)),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: preDispatchTabs.length);
    _tabController.addListener(_tabChange);
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    var provider = PreDispatchProvider.of(context: context);
    var isLoading = provider.dataState.status == RequestStatus.initial;
    var response = provider.dataState.data;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: Dimens.space_8, vertical: Dimens.space_8),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CshShimmer(show: isLoading, child: CshTextNew.h3(provider.groupLotName ?? "Lot #${provider.lotId}")),
                  const SizedBox(height: Dimens.space_4),
                  CshShimmer(show: isLoading, child: CshTextNew.h3("Number Of Devices - ${response?.deviceList?.length ?? 0}")),
                  const SizedBox(height: Dimens.space_2),
                ],
              ),
            ),
          ],
        ),
        Expanded(
          child: Column(
            children: [
              CshTabBar(
                tabs: preDispatchTabs,
                controller: _tabController,
                indicatorSize: TabBarIndicatorSize.tab,
                onTap: (index) {
                  _isTabTap = true;
                },
                height: const TabBarHeights(mobile: Dimens.space_45, tablet: Dimens.space_45, desktop: Dimens.space_45),
                labelStyle: theme.primaryTextTheme.displaySmall,
              ),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: preDispatchTabs.map((e) {
                    return PreDispatchItemWidget(status: (e.key as ValueKey?)?.value as int?);
                  }).toList(),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.removeListener(_tabChange);
  }

  void _tabChange() {
    var provider = PreDispatchProvider.of(context: context, listen: false);

    if (_isTabTap == false && _tabController.indexIsChanging == false) {
      provider.refreshData();
    } else if (_isTabTap) {
      _isTabTap = false;
      provider.refreshData();
    }
  }
}
