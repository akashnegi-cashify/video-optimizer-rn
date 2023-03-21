import 'dart:async';

import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/modules/inventory_manager/screens/return_page.dart';
import 'package:flutter_trc/src/modules/inventory_manager/screens/summary_screen.dart';
import '../../../common/user/widget/logout_action_widget.dart';
import '../../../resources/user_details.dart';
import '../l10n.dart';
import '../providers/inventory_home_provider.dart';
import '../screens/inventory_home_screen.dart';
import 'inventory_assigned_widget.dart';
import 'inventory_pending_delivery_widget.dart';

class InventoryHomeWidget extends StatefulWidget {
  const InventoryHomeWidget({Key? key}) : super(key: key);

  @override
  State<InventoryHomeWidget> createState() => _InventoryHomeWidgetState();
}

class _InventoryHomeWidgetState extends State<InventoryHomeWidget> {
  final GlobalKey<InventoryPendingDeliveryWidgetState> _inventoryPendingWidgetKey = GlobalKey();

  @override
  void initState() {
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
        drawer: Drawer(
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: Dimens.space_60,
                  width: double.infinity,
                  color: theme.primaryColor,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(horizontal: Dimens.space_16),
                  child: Row(
                    children: [
                      Container(
                        height: Dimens.space_40,
                        width: Dimens.space_40,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: theme.backgroundColor),
                        ),
                      ),
                      const SizedBox(width: Dimens.space_16),
                      if (!Validator.isNullOrEmpty(UserDetails().userDetailsData?.userName))
                        Expanded(
                          child: Text(
                            "Hi ${UserDetails().userDetailsData!.userName!}",
                            style: theme.primaryTextTheme.headline3?.copyWith(color: theme.backgroundColor),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        )
                    ],
                  ),
                ),
                const SizedBox(height: Dimens.space_10),
                Expanded(
                  child: ListView(
                    children: [
                      ListTile(
                        title: Text(l10n.delivery, style: theme.primaryTextTheme.headline4),
                        onTap: () {
                          Navigator.of(context).pushReplacementNamed(InventoryHomeScreen.route);
                        },
                      ),
                      Divider(color: theme.shadowColor),
                      ListTile(
                        title: Text(l10n.returns, style: theme.primaryTextTheme.headline4),
                        onTap: () {
                          Navigator.of(context).pop(true);
                          Navigator.of(context).pushNamed(ReturnScreen.route);
                        },
                      ),
                      Divider(color: theme.shadowColor),
                      ListTile(
                        title: Text(l10n.summary, style: theme.primaryTextTheme.headline4),
                        onTap: () {
                          Navigator.of(context).pop(true);
                          Navigator.of(context).pushNamed(SummaryScreen.route);
                        },
                      )
                    ],
                  ),
                ),
                Divider(color: theme.shadowColor),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: Dimens.space_16),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      l10n.appVersion,
                      style: theme.primaryTextTheme.headline5,
                    ),
                  ),
                ),
                const SizedBox(height: Dimens.space_30),
              ],
            ),
          ),
        ),
        appBar: CshHeader(
          l10n.delivery,
          showBackBtn: false,
          bottom: TabBar(
            indicatorColor: theme.primaryColor,
            indicatorWeight: Dimens.space_4,
            unselectedLabelStyle: theme.primaryTextTheme.bodyText2,
            labelStyle: theme.primaryTextTheme.headline4,
            tabs: [
              Text(l10n.pendingDelivery.toUpperCase()),
              Text(l10n.assigned.toUpperCase()),
            ],
          ),
          actions: [LogoutActionWidget()],
        ),
        body: Column(
          children: [
            Expanded(
              child: TabBarView(
                children: [
                  (provider.allowPendingWidget)
                      ? InventoryPendingDeliveryWidget(
                          key: _inventoryPendingWidgetKey,
                          onLocationChange: () {
                            _selectLocationModal(true);
                          },
                        )
                      : const SizedBox(),
                  const InventoryAssignedWidget(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  _selectLocationModal(bool fromListSection) {
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
                          if (fromListSection) {
                            _inventoryPendingWidgetKey.currentState?.resetAndRefreshScreen();
                          }
                        } else {
                          Navigator.of(context).pop(true);
                          CshSnackBar.error(context: context, message: l10n.pleaseSelectAtleastOneGroupLocation);
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
