import 'dart:async';

import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import '../../../screens/barcode_scanner_screen.dart';
import '../../../utils/paginate_list_abstract.dart';
import '../l10n.dart';
import 'package:flutter/material.dart';
import 'package:core_widgets/core_widgets.dart' as core;
import '../models/pending_device_list_response.dart';
import '../models/rider_list_response.dart';
import '../providers/inventory_home_provider.dart';
import '../screens/assigned_device_details_screen.dart';
import 'assigned_tab_item_widget.dart';

class InventoryAssignedWidget extends StatefulWidget {
  const InventoryAssignedWidget({Key? key}) : super(key: key);

  @override
  State<InventoryAssignedWidget> createState() => _InventoryAssignedWidgetState();
}

class _InventoryAssignedWidgetState extends PaginatedListState<PendingDeviceDetailData, InventoryAssignedWidget> {
  _InventoryAssignedWidgetState() : super(initialScrollOffset: 10, pageSize: 10);
  bool _showUrgentRequestOnly = false;
  final TextEditingController _searchBarController = TextEditingController();

  final core.TextInputDebounce _deBouncer = core.TextInputDebounce();
  final TextEditingController _searchRiderController = TextEditingController();
  final core.TextInputDebounce _searchTimer = core.TextInputDebounce();

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var l10n = L10n(context);
    var provider = InventoryHomeProvider.of(context);
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(core.Dimens.space_8, core.Dimens.space_8, core.Dimens.space_8, 0),
          child: core.CshTextFormField(
            controller: _searchBarController,
            isBorderAllowed: true,
            hintText: l10n.searchItem,
            keyboardType: TextInputType.name,
            maxLength: 50,
            prefixIcon: core.CshIcon(
              FeatherIcons.search,
              padding: EdgeInsets.zero,
              iconColor: theme.primaryColor,
              iconSize: core.MobileIconSize.medium,
            ),
            suffixIcon: core.CshIcon.assets(
              "assets/images/ic_qr_scanner.png",
              padding: EdgeInsets.zero,
              iconSize: core.MobileIconSize.medium,
              onClick: () {
                Navigator.of(context).pushNamed(BarcodeScanWidget.route, arguments: (String data) {
                  Navigator.of(context).pop();
                  _searchBarController.text = data.trim();
                  provider.barcode = data.trim();
                  provider.resetDataList();
                  resetAndRefreshScreen(pageNumber: 0);
                  provider.barcode = "";
                });
              },
            ),
            onChanged: (data) {
              _deBouncer.start(() {
                if (data.isNotEmpty) {
                  provider.barcode = data.trim();
                  provider.resetDataList();
                  resetAndRefreshScreen(pageNumber: 0);
                  provider.barcode = "";
                } else {
                  provider.barcode = "";
                  provider.resetDataList();
                  resetAndRefreshScreen(pageNumber: 0);
                }
              });
            },
          ),
        ),
        core.CshMediumButton(
          text: l10n.assignRider,
          onPressed: provider.checkIfAssignedForRider()
              ? () {
                  _getListOfRider(theme, l10n);
                }
              : null,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: core.Dimens.space_8),
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
                core.CshCheckbox(
                  isSelected: _showUrgentRequestOnly,
                ),
                Text(
                  l10n.showUrgentRequestsOnly,
                  style: theme.primaryTextTheme.headline4,
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
                    AssignedDeviceDetailsArguments args = AssignedDeviceDetailsArguments(did: item.did!);
                    Navigator.of(context).pushNamed(AssignedDeviceDetailsScreen.route, arguments: args);
                  } else {
                    core.CshSnackBar.error(context: context, message: l10n.noDidPresent);
                  }
                },
                onCheckBoxChange: (bool data) {
                  item.isAssignedToRider = data;
                  setState(() {});
                },
              );
            },
            separator: const SizedBox(height: core.Dimens.space_8),
            onNoDataFound: () {
              return Center(
                child: Text(
                  l10n.noDataFound,
                  style: theme.primaryTextTheme.subtitle1,
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
                        style: theme.primaryTextTheme.headline3,
                        textAlign: TextAlign.center,
                      ),
                    )
                  ],
                ),
              );
            },
            padding: const EdgeInsets.symmetric(horizontal: core.Dimens.space_16, vertical: core.Dimens.space_12),
          ),
        ),
      ],
    );
  }

  _getListOfRider(ThemeData theme, L10n l10n) {
    var provider = InventoryHomeProvider.of(context, listen: false);
    core.CshLoading().showLoading(context);
    provider.getListOfRiders().then(
      (value) {
        core.CshLoading().hideLoading(context);
        if (value) {
          if (!core.Validator.isListNullOrEmpty(provider.riderListResponse?.riderDataList)) {
            _listOfRider(theme, l10n);
          } else {
            core.CshSnackBar.error(context: context, message: l10n.noRiderPresent);
          }
        }
      },
      onError: (error) {
        core.CshLoading().hideLoading(context);
        core.CshSnackBar.error(context: context, message: error);
      },
    ).then((value) {
      provider.selectedRider = null;
    });
  }

  _listOfRider(ThemeData theme, L10n l10n) {
    var provider = InventoryHomeProvider.of(context, listen: false);
    List<RiderListDataResponse> dataList = provider.getSearchResults(pattern: "");

    core
        .showCshBottomSheet(
      isScrollControlled: true,
      context: context,
      child: StatefulBuilder(
        builder: (BuildContext context, setState) {
          return Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
              top: core.Dimens.space_12,
            ),
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.50,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: core.Dimens.space_16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          l10n.listOfRiders,
                          style: theme.primaryTextTheme.headline3,
                        ),
                        core.CshIcon(
                          FeatherIcons.x,
                          iconSize: core.MobileIconSize.large,
                          padding: EdgeInsets.zero,
                          onClick: () {
                            Navigator.of(context).pop();
                          },
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: core.Dimens.space_8,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: core.Dimens.space_16),
                    child: core.CshTextFormField(
                      controller: _searchRiderController,
                      hintText: l10n.searchRiderByName,
                      maxLines: 1,
                      maxLength: 50,
                      keyboardType: TextInputType.name,
                      onChanged: (data) {
                        _searchTimer.start(() {
                          if (!core.Validator.isNullOrEmpty(data)) {
                            dataList = provider.getSearchResults(pattern: data.trim());
                          } else {
                            dataList = provider.getSearchResults(pattern: "");
                          }
                          setState(() {});
                        });
                      },
                    ),
                  ),
                  const SizedBox(
                    height: core.Dimens.space_8,
                  ),
                  Expanded(
                    child: ListView.separated(
                      padding:
                          const EdgeInsets.symmetric(vertical: core.Dimens.space_8, horizontal: core.Dimens.space_16),
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            provider.selectedRider = dataList[index];
                            setState(() {});
                          },
                          child: Row(
                            children: [
                              core.CshCheckbox(
                                isSelected: dataList[index].riderId == provider.selectedRider?.riderId,
                                visualDensity: VisualDensity.compact,
                              ),
                              Expanded(
                                child: Text(
                                  dataList[index].riderName ?? "",
                                  style: theme.primaryTextTheme.headline4,
                                ),
                              )
                            ],
                          ),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return const SizedBox(height: core.Dimens.space_8);
                      },
                      itemCount: dataList.length,
                    ),
                  ),
                  const SizedBox(height: core.Dimens.space_8),
                  core.CshMediumButton(
                    text: l10n.assign,
                    onPressed: () {
                      if (provider.selectedRider != null) {
                        _assignRider(l10n);
                        Navigator.of(context).pop();
                      } else {
                        core.CshSnackBar.error(
                          context: context,
                          message: l10n.pleaseAssignRider,
                          snackBarPosition: core.SnackBarPosition.TOP,
                        );
                      }
                    },
                  ),
                  const SizedBox(height: core.Dimens.space_12),
                ],
              ),
            ),
          );
        },
      ),
    )
        .then((value) {
      _searchRiderController.clear();
    });
  }

  _assignRider(L10n l10n) {
    var provider = InventoryHomeProvider.of(context, listen: false);
    core.CshLoading().showLoading(context);
    provider.assignRider().then((value) {
      core.CshLoading().hideLoading(context);
      if (value) {
        provider.resetDataList();
        resetAndRefreshScreen(pageNumber: 0);
        core.CshSnackBar.success(context: context, message: l10n.riderAssignedSuccessfully);
      }
    }, onError: (error) {
      core.CshLoading().hideLoading(context);
      core.CshSnackBar.error(context: context, message: error);
    });
  }

  @override
  void requestApi(int pageNo,
      {Function(List<PendingDeviceDetailData>? list)? onSuccess, Function(String errorMessage)? onError}) {
    var provider = InventoryHomeProvider.of(context, listen: false);
    provider.getListOfAssignmentPendingDevices(pageNo++).then((value) {
      if (onSuccess != null) {
        onSuccess(value.data?.dataList);
      }
    }, onError: (error) {
      if (onError != null) {
        onError(error);
      }
    });
  }

  @override
  void dispose() {
    _searchBarController.dispose();
    _searchRiderController.dispose();
    _deBouncer.stop();
    _searchTimer.stop();
    super.dispose();
  }
}
