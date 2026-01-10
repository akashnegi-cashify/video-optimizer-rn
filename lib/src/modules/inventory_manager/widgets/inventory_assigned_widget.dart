import 'package:components/components.dart';
import 'package:components/resources/list/list_request.dart';
import 'package:core/core.dart';
import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_trc/src/common/utils/csh_ml_scanner_util.dart';
import 'package:flutter_trc/src/services/service_groups.dart';

import '../l10n.dart';
import '../models/pending_device_list_response.dart';
import '../models/rider_list_response.dart';
import '../providers/inventory_home_provider.dart';
import '../screens/assigned_device_details_screen.dart';
import 'assigned_tab_item_widget.dart';

enum SearchType { barcode, engineer }

class InventoryAssignedWidget extends StatefulWidget {
  const InventoryAssignedWidget({Key? key}) : super(key: key);

  @override
  State<InventoryAssignedWidget> createState() => InventoryAssignedWidgetState();
}

class InventoryAssignedWidgetState extends State<InventoryAssignedWidget> {
  final CshListController _listController = CshListController();
  bool _showUrgentRequestOnly = false;
  final List<DropDownItem> _searchFilterList = [
    DropDownItem<SearchType>("1", "Barcode", extraData: SearchType.barcode),
    DropDownItem<SearchType>("2", "Engineer", extraData: SearchType.engineer),
  ];
  late DropDownItem _selectedSearchFilter;
  final TextEditingController _searchBarController = TextEditingController();

  final TextInputDebounce _searchDeviceDeBouncer = TextInputDebounce();
  final TextEditingController _searchRiderController = TextEditingController();
  final TextInputDebounce _searchRiderDeBouncer = TextInputDebounce();

  @override
  void initState() {
    super.initState();
    _selectedSearchFilter = _searchFilterList[0];
  }

  void refreshList() {
    _listController.refresh();
  }

  FilterConfig _getFilterConfig(InventoryHomeProvider provider) {
    List<AdminFilterList> preSelectedFilters = [];

    // Add barcode filter if selected
    if (provider.barcode != null && provider.barcode?.isNotEmpty == true) {
      preSelectedFilters.add(
        AdminFilterList(
          type: CshFilterValueType.equality.value,
          field: "barcode",
          value: AdminFilterData(search: provider.barcode),
        ),
      );
    }

    // Add engineer name filter if selected (nested in fp)
    if (provider.engineerName != null && provider.engineerName!.isNotEmpty) {
      preSelectedFilters.add(
        AdminFilterList(
          type: 'fp.engName',
          field: 'fp.engName',
          value: AdminFilterData(search: provider.engineerName),
        ),
      );
    }

    // Add isUrgent filter (nested in fp)
    // preSelectedFilters.add(
    //   AdminFilterList(
    //     type: CshFilterValueType.equality.value,
    //     field: 'isUrgent',
    //     value: AdminFilterData(search: provider.isUrgent.toString()),
    //   ),
    // );

    // Add location_group filter (nested in fp)
    final locationsString = provider.getLocationsString();
    if (locationsString != null && locationsString.isNotEmpty) {
      // preSelectedFilters.add(
      //   AdminFilterList(
      //     type: CshFilterValueType.multiSelect.value,
      //     field: 'location',
      //     value: AdminFilterData(search: locationsString),
      //   ),
      // );
    }

    return FilterConfig(
      // preSelectedFilters: preSelectedFilters,
      // initialFilter: preSelectedFilters,
    );
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var l10n = L10n(context);
    var provider = InventoryHomeProvider.of(context);
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.fromLTRB(Dimens.space_8, Dimens.space_8, Dimens.space_8, 0),
          alignment: Alignment.center,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Flexible(
                flex: 2,
                fit: FlexFit.tight,
                child: Container(
                  color: theme.cardColor,
                  child: CshDropDown(
                      selectedItem: _selectedSearchFilter,
                      items: _searchFilterList,
                      onChanged: (DropDownItem? item) {
                        setState(() {
                          provider.barcode = null;
                          provider.engineerName = null;
                          _searchBarController.text = "";
                          _selectedSearchFilter = item!;
                          refreshList();
                        });
                      }),
                ),
              ),
              Flexible(
                flex: 4,
                fit: FlexFit.tight,
                child: CshTextFormField(
                  controller: _searchBarController,
                  isBorderAllowed: true,
                  hintText: l10n.searchItem,
                  keyboardType: TextInputType.name,
                  maxLength: 50,
                  suffixIcon: _isSelectedFilterBarcode()
                      ? CshIcon.assets(
                          "assets/images/ic_qr_scanner.png",
                          padding: EdgeInsets.zero,
                          iconSize: MobileIconSize.medium,
                          onClick: () {
                            CshMlScannerUtil().openScanner(context, onScanned: (scannedData, controller) {
                              Navigator.of(context).pop();
                              _searchBarController.text = scannedData.trim();
                              provider.barcode = scannedData.trim();
                              refreshList();
                              provider.barcode = "";
                            });
                          },
                        )
                      : null,
                  onChanged: (data) {
                    _searchDeviceDeBouncer.start(() {
                      if (_isSelectedFilterBarcode()) {
                        provider.barcode = data.trim();
                      } else {
                        provider.engineerName = data.trim();
                      }
                      refreshList();
                    });
                  },
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: Dimens.space_16),
          child: CshMediumButton(
            text: l10n.assignRider,
            onPressed: provider.checkIfAssignedForRider()
                ? () {
                    _getRiderList(theme, l10n);
                  }
                : null,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: Dimens.space_8),
          child: GestureDetector(
            onTap: () {
              _showUrgentRequestOnly = !_showUrgentRequestOnly;
              provider.isUrgent = _showUrgentRequestOnly;
              setState(() {});
              refreshList();
            },
            child: Row(
              children: [
                CshCheckbox(isSelected: _showUrgentRequestOnly),
                Text(l10n.showUrgentRequestsOnly, style: theme.primaryTextTheme.headlineMedium)
              ],
            ),
          ),
        ),
        Expanded(
          child: CshApiList<PendingDeviceDetailData>(
            apiConfig: ListApiConfig(
              apiUrl: "/inventory/list-assignment-pending-devices",
              serviceGroup: TRCServiceGroups.unifyTrc,
            ),
            filterConfig: _getFilterConfig(provider),
            controller: _listController,
            itemFromJson: PendingDeviceDetailData.fromJson,
            shimmerLoaderWidget: const CshShimmer(height: Dimens.space_60),
            listPadding: const EdgeInsets.symmetric(horizontal: Dimens.space_16, vertical: Dimens.space_12),
            verticalRowSpacing: Dimens.space_8,
            isHideCoreFilterButton: true,
            getRowWidget: (item, index) {
              final data = item;
              // Find or create item in provider's assignedTabListData for checkbox state management
              PendingDeviceDetailData? itemForWidget;
              if (data?.deviceId != null) {
                itemForWidget = provider.assignedTabListData.firstWhere(
                  (element) => element.deviceId == data!.deviceId,
                  orElse: () {
                    final newItem = PendingDeviceDetailData(
                      deviceId: data?.deviceId,
                      deviceBarcode: data?.deviceBarcode,
                      engineerName: data?.engineerName,
                      location: data?.location,
                      productTitle: data?.productTitle,
                      trayBarcode: data?.trayBarcode,
                      partAvailableCount: data?.partAvailableCount,
                      totalPartCount: data?.totalPartCount,
                      assignedAt: data?.assignedAt,
                      isUrgent: data?.isUrgent,
                      repairType: data?.repairType,
                      grade: data?.grade,
                      isAssignedToRider: false,
                    );
                    provider.assignedTabListData.add(newItem);
                    return newItem;
                  },
                );
                // Sync data from API response to existing item
                itemForWidget.deviceBarcode = data?.deviceBarcode;
                itemForWidget.engineerName = data?.engineerName;
                itemForWidget.location = data?.location;
                itemForWidget.productTitle = data?.productTitle;
                itemForWidget.trayBarcode = data?.trayBarcode;
                itemForWidget.partAvailableCount = data?.partAvailableCount;
                itemForWidget.totalPartCount = data?.totalPartCount;
                itemForWidget.assignedAt = data?.assignedAt;
                itemForWidget.isUrgent = data?.isUrgent;
                itemForWidget.repairType = data?.repairType;
                itemForWidget.grade = data?.grade;
              } else {
                itemForWidget = data;
              }

              return AssignedTabItemWidget(
                dataModel: itemForWidget,
                onCardClicked: () {
                  if (data?.deviceId != null) {
                    AssignedDeviceDetailsScreenArguments args =
                        AssignedDeviceDetailsScreenArguments(did: data!.deviceId!);
                    Navigator.of(context).pushNamed(AssignedDeviceDetailsScreen.route, arguments: args);
                  } else {
                    CshSnackBar.error(context: context, message: l10n.noDidPresent);
                  }
                },
                onCheckBoxChange: (bool checked) {
                  if (itemForWidget?.deviceId != null) {
                    itemForWidget!.isAssignedToRider = checked;
                    provider.notifyListeners();
                    setState(() {});
                  }
                },
              );
            },
          ),
        ),
      ],
    );
  }

  _getRiderList(ThemeData theme, L10n l10n) {
    var provider = InventoryHomeProvider.of(context, listen: false);
    CshLoading().showLoading(context);
    provider.getListOfRiders().then((value) {
      CshLoading().hideLoading(context);
      if (value) {
        if (!Validator.isListNullOrEmpty(provider.riderListResponse?.riderDataList)) {
          _showRiderList(theme, l10n);
        } else {
          CshSnackBar.error(context: context, message: l10n.noRiderPresent);
        }
      }
    }, onError: (error) {
      CshLoading().hideLoading(context);
      CshSnackBar.error(context: context, message: error);
    }).then((value) {
      provider.selectedRider = null;
    });
  }

  _showRiderList(ThemeData theme, L10n l10n) {
    var provider = InventoryHomeProvider.of(context, listen: false);
    List<RiderListDataResponse> dataList = provider.getSearchResults(pattern: "");

    showCshBottomSheet(
      isScrollControlled: true,
      context: context,
      child: StatefulBuilder(
        builder: (BuildContext context, setState) {
          return Padding(
            padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom, top: Dimens.space_12),
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.50,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: Dimens.space_16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(l10n.listOfRiders, style: theme.primaryTextTheme.displaySmall),
                        CshIcon(
                          FeatherIcons.x,
                          iconSize: MobileIconSize.large,
                          padding: EdgeInsets.zero,
                          onClick: () {
                            Navigator.of(context).pop();
                          },
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: Dimens.space_8),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: Dimens.space_16),
                    child: CshTextFormField(
                      controller: _searchRiderController,
                      hintText: l10n.searchRiderByName,
                      maxLines: 1,
                      maxLength: 50,
                      keyboardType: TextInputType.name,
                      onChanged: (data) {
                        _searchRiderDeBouncer.start(() {
                          if (!Validator.isNullOrEmpty(data)) {
                            dataList = provider.getSearchResults(pattern: data.trim());
                          } else {
                            dataList = provider.getSearchResults(pattern: "");
                          }
                          setState(() {});
                        });
                      },
                    ),
                  ),
                  const SizedBox(height: Dimens.space_8),
                  Expanded(
                    child: ListView.separated(
                      padding: const EdgeInsets.symmetric(vertical: Dimens.space_8, horizontal: Dimens.space_16),
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            provider.selectedRider = dataList[index];
                            setState(() {});
                          },
                          child: Row(
                            children: [
                              CshCheckbox(
                                isSelected: dataList[index].riderId == provider.selectedRider?.riderId,
                                visualDensity: VisualDensity.compact,
                              ),
                              Expanded(
                                child: Text(
                                  dataList[index].riderName ?? "",
                                  style: theme.primaryTextTheme.headlineMedium,
                                ),
                              )
                            ],
                          ),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return const SizedBox(height: Dimens.space_8);
                      },
                      itemCount: dataList.length,
                    ),
                  ),
                  const SizedBox(height: Dimens.space_8),
                  CshMediumButton(
                    text: l10n.assign,
                    onPressed: () {
                      if (provider.selectedRider != null) {
                        _assignRider(l10n);
                        Navigator.of(context).pop();
                      } else {
                        CshSnackBar.error(
                          context: context,
                          message: l10n.pleaseAssignRider,
                          snackBarPosition: SnackBarPosition.TOP,
                        );
                      }
                    },
                  ),
                  const SizedBox(height: Dimens.space_12),
                ],
              ),
            ),
          );
        },
      ),
    ).then((value) {
      _searchRiderController.clear();
    });
  }

  _assignRider(L10n l10n) {
    var provider = InventoryHomeProvider.of(context, listen: false);
    CshLoading().showLoading(context);
    provider.assignRider().then((value) {
      CshLoading().hideLoading(context);
      if (value) {
        refreshList();
        CshSnackBar.success(context: context, message: l10n.riderAssignedSuccessfully);
      }
    }, onError: (error) {
      CshLoading().hideLoading(context);
      CshSnackBar.error(context: context, message: error);
    });
  }

  bool _isSelectedFilterBarcode() {
    return _selectedSearchFilter.extraData == SearchType.barcode;
  }

  @override
  void dispose() {
    _searchBarController.dispose();
    _searchRiderController.dispose();
    _searchDeviceDeBouncer.stop();
    _searchRiderDeBouncer.stop();
    super.dispose();
  }
}
