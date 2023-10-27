import 'dart:async';

import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_trc/src/header/trc_header.dart';

import '../../../utils/paginate_list_abstract.dart';
import '../l10n.dart';
import '../providers/inventory_home_provider.dart';
import 'inventory_assigned_widget.dart';
import 'inventory_drawer_widget.dart';
import 'inventory_pending_delivery_widget.dart';

class InventoryHomeWidget extends StatefulWidget {
  const InventoryHomeWidget({Key? key}) : super(key: key);

  @override
  State<InventoryHomeWidget> createState() => _InventoryHomeWidgetState();
}

class _InventoryHomeWidgetState extends State<InventoryHomeWidget> with SingleTickerProviderStateMixin {
  final GlobalKey<InventoryPendingDeliveryWidgetState> _inventoryPendingWidgetKey = GlobalKey();
  final GlobalKey<InventoryAssignedWidgetState> _inventoryAssignedWidgetKey = GlobalKey();
  late final TabController _tabBarController;

  @override
  void initState() {
    _tabBarController = TabController(length: 2, vsync: this);
    scheduleMicrotask(() {
      _selectLocationModal(false);
    });
    super.initState();
  }

  bool allowPendingList = false;

  @override
  Widget build(BuildContext context) {
    var l10n = L10n(context);
    var provider = InventoryHomeProvider.of(context);
    var theme = Theme.of(context);
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        drawer: const InventoryDrawerWidget(),
        appBar: TrcHeader(l10n.delivery, showBackBtn: false, showLogoutButton: true, showProfileButton: true),
        body: Column(
          children: [
            CshTabBar(
              indicatorSize: TabBarIndicatorSize.tab,
              tabs: [
                CshTab(label: l10n.requestedParts.toUpperCase(), width: double.infinity),
                CshTab(label: l10n.assigned.toUpperCase(), width: double.infinity),
              ],
              controller: _tabBarController,
              labelPadding: EdgeInsets.zero,
              height: const TabBarHeights(mobile: 56, tablet: 38, desktop: 38),
            ),
            Expanded(
              child: TabBarView(
                controller: _tabBarController,
                children: [
                  (provider.allowPendingWidget)
                      ? InventoryPendingDeliveryWidget(key: _inventoryPendingWidgetKey)
                      : const SizedBox(),
                  InventoryAssignedWidget(key: _inventoryAssignedWidgetKey),
                ],
              ),
            )
          ],
        ),
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              GlobalKey<PaginatedListState> key;
              if (_tabBarController.index == 0) {
                key = _inventoryPendingWidgetKey;
              } else {
                key = _inventoryAssignedWidgetKey;
              }
              _selectLocationModal(true, paginatedKey: key);
            },
            backgroundColor: theme.primaryColor,
            child: CshIcon(
              FeatherIcons.edit,
              iconSize: MobileIconSize.medium,
              iconColor: Colors.white,
              padding: const EdgeInsets.only(right: Dimens.space_8),
            )),
      ),
    );
  }

  _selectLocationModal(bool fromListSection, {GlobalKey<PaginatedListState>? paginatedKey}) {
    var l10n = L10n(context);
    var theme = Theme.of(context);
    var provider = InventoryHomeProvider.of(context, listen: false);
    showCshBottomSheet(
      isDismissible: false,
      isScrollControlled: true,
      context: context,
      child: StatefulBuilder(
        builder: (BuildContext context, setState) {
          return WillPopScope(
            onWillPop: () async {
              return Future.value(false);
            },
            child: Container(
              height: MediaQuery.of(context).size.height * 0.6,
              padding: const EdgeInsets.symmetric(horizontal: Dimens.space_16, vertical: Dimens.space_12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l10n.selectGroupNameS,
                    style: theme.primaryTextTheme.headline4,
                  ),
                  const SizedBox(height: Dimens.space_8),
                  Expanded(
                    child: ListView.separated(
                      padding: const EdgeInsets.symmetric(vertical: Dimens.space_4),
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            provider.toggleLocationState(provider.listOfGroupLocation[index].locationName ?? "",
                                !(provider.listOfGroupLocation[index].isSelected ?? false));
                            setState(() {});
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: Dimens.space_6),
                            child: Row(
                              children: [
                                CshCheckbox(
                                  isSelected: provider.listOfGroupLocation[index].isSelected ?? false,
                                  visualDensity: VisualDensity.compact,
                                ),
                                Expanded(
                                  child: Text(
                                    provider.listOfGroupLocation[index].locationName ?? "",
                                    style: theme.primaryTextTheme.headline3,
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return const SizedBox(height: Dimens.space_8);
                      },
                      itemCount: provider.inventoryLocationResponse!.locationsDataList!.length,
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: CshMediumButton(
                      text: l10n.submit,
                      onPressed: () {
                        if (provider.checkForLocationSelected()) {
                          Navigator.of(context).pop();
                          provider.allowPendingListToShow(true);
                          if (fromListSection && paginatedKey != null) {
                            paginatedKey.currentState?.resetAndRefreshScreen();
                          }
                        } else {
                          CshSnackBar.error(
                            context: context,
                            message: l10n.pleaseSelectAtleastOneGroupLocation,
                            snackBarPosition: SnackBarPosition.TOP,
                          );
                        }
                      },
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
