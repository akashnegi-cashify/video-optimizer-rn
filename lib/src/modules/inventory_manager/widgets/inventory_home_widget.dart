import 'dart:async';

import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';

import '../../../common/user/widget/logout_action_widget.dart';
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
        drawer: const InventoryDrawerWidget(),
        appBar: CshHeader(
          l10n.delivery,
          showBackBtn: false,
          bottom: TabBar(
            indicatorColor: theme.primaryColor,
            indicatorWeight: Dimens.space_4,
            unselectedLabelStyle: theme.primaryTextTheme.bodyText2,
            labelStyle: theme.primaryTextTheme.headline4,
            tabs: [
              Text(l10n.requestedParts.toUpperCase()),
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
                          if (fromListSection) {
                            _inventoryPendingWidgetKey.currentState?.resetAndRefreshScreen();
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
