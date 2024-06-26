import 'package:core_widgets/core_widgets.dart' hide iterate;
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_trc/src/common/utils/csh_ml_scanner_util.dart';

import '../../../utils/paginate_list_abstract.dart';
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

class InventoryAssignedWidgetState extends PaginatedListState<PendingDeviceDetailData, InventoryAssignedWidget> {
  InventoryAssignedWidgetState() : super(initialScrollOffset: 10, pageSize: 10);
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
    _selectedSearchFilter = _searchFilterList[0];
    super.initState();
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
                          provider.resetDataList();
                          resetAndRefreshScreen();
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
                              provider.resetDataList();
                              resetAndRefreshScreen(pageNumber: 0);
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
                      provider.resetDataList();
                      resetAndRefreshScreen(pageNumber: 0);
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
              provider.resetDataList();
              resetAndRefreshScreen(pageNumber: 0);
            },
            child: Row(
              children: [
                CshCheckbox(
                  isSelected: _showUrgentRequestOnly,
                ),
                Text(
                  l10n.showUrgentRequestsOnly,
                  style: theme.primaryTextTheme.headlineMedium,
                )
              ],
            ),
          ),
        ),
        Expanded(
          child: iterate(
            (item, index) {
              return AssignedTabItemWidget(
                dataModel: item,
                onCardClicked: () {
                  if (item.did != null) {
                    AssignedDeviceDetailsScreenArguments args = AssignedDeviceDetailsScreenArguments(did: item.did!);
                    Navigator.of(context).pushNamed(AssignedDeviceDetailsScreen.route, arguments: args);
                  } else {
                    CshSnackBar.error(context: context, message: l10n.noDidPresent);
                  }
                },
                onCheckBoxChange: (bool data) {
                  item.isAssignedToRider = data;
                  setState(() {});
                },
              );
            },
            separator: const SizedBox(height: Dimens.space_8),
            onRefresh: () async {},
            onNoDataFound: () {
              return Center(
                child: Text(
                  l10n.noDataFound,
                  style: theme.primaryTextTheme.titleMedium,
                  textAlign: TextAlign.center,
                ),
              );
            },
            onError: (String error) {
              return Center(
                child: Row(
                  children: [
                    const SizedBox.shrink(),
                    Expanded(
                      child: Text(
                        error,
                        style: theme.primaryTextTheme.displaySmall,
                        textAlign: TextAlign.center,
                      ),
                    )
                  ],
                ),
              );
            },
            padding: const EdgeInsets.symmetric(horizontal: Dimens.space_16, vertical: Dimens.space_12),
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
        provider.resetDataList();
        resetAndRefreshScreen(pageNumber: 0);
        CshSnackBar.success(context: context, message: l10n.riderAssignedSuccessfully);
      }
    }, onError: (error) {
      CshLoading().hideLoading(context);
      CshSnackBar.error(context: context, message: error);
    });
  }

  @override
  void requestApi(int pageNo,
      {Function(List<PendingDeviceDetailData>? list)? onSuccess, Function(String errorMessage)? onError}) {
    var provider = InventoryHomeProvider.of(context, listen: false);
    provider.getListOfAssignmentPendingDevices(pageNo++, pageSize).then((value) {
      if (onSuccess != null) {
        onSuccess(value.data?.dataList);
      }
    }, onError: (error) {
      if (onError != null) {
        onError(error);
      }
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
