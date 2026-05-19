import 'package:core_widgets/core_widgets.dart' hide iterate;
import 'package:flutter/material.dart';
import 'package:flutter_trc/shipex/modules/packaging/modal/packaging_video_selection_dialog.dart';
import 'package:flutter_trc/shipex/modules/packaging/providers/group_list_provider.dart';
import 'package:flutter_trc/shipex/modules/packaging/resouces/packaging_status_type.dart';
import 'package:flutter_trc/src/common/widgets/search_with_dropdown_widget.dart';

import '../../../../src/utils/paginate_list_abstract.dart';
import '../l10n.dart';
import '../models/group_lot_list_repsonse.dart';
import '../packaging_process_screen.dart';
import 'group_list_data_card_widget.dart';

class NewOrderDataList extends StatefulWidget {
  final PackagingStatusType type;

  const NewOrderDataList(this.type, {super.key});

  @override
  State<NewOrderDataList> createState() => _NewOrderDataListState();
}

class _NewOrderDataListState extends PaginatedListState<GroupLotListData, NewOrderDataList> {
  _NewOrderDataListState() : super(initialScrollOffset: 10, pageSize: 10);

  String? _awbNumber;
  String? _lotName;

  String? get awbNumber => _awbNumber;

  set awbNumber(String? value) {
    _awbNumber = value;
    _lotName = null;
  }

  String? get lotName => _lotName;

  set lotName(String? value) {
    _lotName = value;
    _awbNumber = null;
  }

  @override
  Widget build(BuildContext context) {
    var l10n = L10n(context);
    var theme = Theme.of(context);
    var provider = GroupListProvider.of(context, listen: false);
    return Column(
      children: [
        SearchWithDropdownWidget(
          padding: const EdgeInsets.only(left: Dimens.space_16, right: Dimens.space_16, top: Dimens.space_16),
          key: ValueKey(widget.type),
          searchTypeValues: GroupNameSearchType.values,
          onDropDownChange: (item) {
            _awbNumber = null;
            _lotName = null;
            resetAndRefreshScreen();
          },
          onSearch: (type, value) {
            if (type == GroupNameSearchType.awbNumber) {
              awbNumber = value;
            } else {
              lotName = value;
            }
            resetAndRefreshScreen();
          },
        ),
        Expanded(
          child: iterate(
            (item, index) {
              return GroupListDataCardWidget(
                dataModel: item,
                onCardTap: () {
                  _onItemSelected(item);
                },
              );
            },
            onRefresh: () async {},
            separator: const SizedBox(height: Dimens.space_12),
            onNoDataFound: () {
              return Center(
                child: Text(
                  l10n.noNewDataFound,
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
        )
      ],
    );
  }

  @override
  void requestApi(int pageNo,
      {Function(List<GroupLotListData>? list)? onSuccess, Function(String errorMessage)? onError}) {
    var provider = GroupListProvider.of(context, listen: false);

    provider.fetchNewDataListData(widget.type, pageNo, lotName, awbNumber).then((value) {
      if (onSuccess != null) {
        onSuccess(value);
      }
    }, onError: (error) {
      if (onError != null) {
        onError(error);
      }
    });
  }

  _onItemSelected(GroupLotListData item) {
    if (widget.type == PackagingStatusType.packagingPending) {
      PackagingProcessScreenArguments args = PackagingProcessScreenArguments(dataModel: item);
      Navigator.of(context).pushNamed(PackagingProcessScreen.route, arguments: args);
    } else {
      _showPackagingVideoSelectionDialog(item, onProceed: (isCCTCSelected) {
        PackagingProcessScreenArguments args = PackagingProcessScreenArguments(
            dataModel: item, isPendingGroupLot: true, isCCTCCameraSelected: isCCTCSelected);
        Navigator.of(context).pushNamed(PackagingProcessScreen.route, arguments: args).whenComplete(() {
          resetAndRefreshScreen();
        });
      });
    }
  }

  _showPackagingVideoSelectionDialog(GroupLotListData item, {required Function(bool isCCTCSelected) onProceed}) {
    var provider = GroupListProvider.of(context, listen: false);
    showPackagingVideoSelectionDialog(
      context,
      isCheckValidation: true,
      cameraBarcode: item.monitoringCameraBarcode,
      onMonitoringAppSelected: (bool? isSelectResetOption) {
        if (Validator.isTrue(isSelectResetOption)) {
          CshLoading().showLoading(context);
          provider.resetItemPackaging(item.packagingBarcode).then((value) {
            CshLoading().hideLoading(context);
            onProceed(false);
          }, onError: (error) {
            CshLoading().hideLoading(context);
            CshSnackBar.error(context: context, message: error.toString());
          });
        } else {
          onProceed(false);
        }
      },
      onCCTVCameraSelected: (scannedCameraBarcode, {bool? isSelectResetOption}) {
        CshLoading().showLoading(context);
        provider.addCCTVCameraBarcode(scannedCameraBarcode, item.packagingBarcode, isSelectResetOption).then((value) {
          CshLoading().hideLoading(context);
          onProceed(true);
        }, onError: (error) {
          CshLoading().hideLoading(context);
          CshSnackBar.error(context: context, message: error.toString());
        });
      },
    );
  }
}

enum GroupNameSearchType with SearchType {
  lotName("ln", "Lot Name", "Search by name"),
  awbNumber("br", "Awb No", "Search by awbNumber");

  @override
  final String code;

  @override
  final String label;

  @override
  final String hintName;

  const GroupNameSearchType(this.code, this.label, this.hintName);
}
