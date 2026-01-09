import 'dart:async';

import 'package:components/components.dart' hide CshTabBar;
import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_trc/src/header/trc_header.dart';

import '../l10n.dart';
import '../models/inventory_location_response.dart';
import '../providers/inventory_home_provider.dart';
import '../resources/inventory_manager_service.dart';
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
              _selectLocationModal(true);
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
                    style: theme.primaryTextTheme.headlineMedium,
                  ),
                  const SizedBox(height: Dimens.space_8),
                  Expanded(
                    child: _LocationListWidget(
                      provider: provider,
                      onLocationToggled: () {
                        setState(() {});
                      },
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
                            // Refresh the pending delivery list
                            _inventoryPendingWidgetKey.currentState?.refreshList();
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

class _LocationListWidget extends StatefulWidget {
  final InventoryHomeProvider provider;
  final VoidCallback onLocationToggled;

  const _LocationListWidget({
    Key? key,
    required this.provider,
    required this.onLocationToggled,
  }) : super(key: key);

  @override
  State<_LocationListWidget> createState() => _LocationListWidgetState();
}

class _LocationListWidgetState extends State<_LocationListWidget> {
  bool _isLoading = true;
  List<String> _locations = [];

  @override
  void initState() {
    super.initState();
    _loadLocations();
  }

  void _loadLocations() {
    InventoryService.getInventoryLocation().listen((response) {
      if (response != null && response.locationsDataList != null) {
        setState(() {
          _locations = response.locationsDataList!;
          _isLoading = false;
        });
        // Initialize provider's list with locations
        for (var locationName in _locations) {
          if (!widget.provider.listOfGroupLocation.any((e) => e.locationName == locationName)) {
            widget.provider.listOfGroupLocation.add(
              GroupLocationModel(locationName: locationName, isSelected: false),
            );
          }
        }
      } else {
        setState(() {
          _isLoading = false;
        });
      }
    }, onError: (error) {
      setState(() {
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    if (_isLoading) {
      return const Center(child: CshShimmer(height: Dimens.space_60));
    }

    if (_locations.isEmpty) {
      return Center(
        child: Text(
          "No locations found",
          style: theme.primaryTextTheme.displaySmall,
        ),
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.symmetric(vertical: Dimens.space_4),
      itemCount: _locations.length,
      separatorBuilder: (context, index) => const SizedBox(height: Dimens.space_8),
      itemBuilder: (context, index) {
        final locationName = _locations[index];

        // Find or create the location item in provider's list
        var locationItem = widget.provider.listOfGroupLocation.firstWhere(
          (element) => element.locationName == locationName,
          orElse: () {
            final newItem = GroupLocationModel(locationName: locationName, isSelected: false);
            widget.provider.listOfGroupLocation.add(newItem);
            return newItem;
          },
        );

        return GestureDetector(
          onTap: () {
            widget.provider.toggleLocationState(
              locationName,
              !(locationItem.isSelected ?? false),
            );
            widget.onLocationToggled();
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: Dimens.space_6),
            child: Row(
              children: [
                CshCheckbox(
                  isSelected: locationItem.isSelected ?? false,
                  visualDensity: VisualDensity.compact,
                ),
                Expanded(
                  child: Text(
                    locationName,
                    style: theme.primaryTextTheme.displaySmall,
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
