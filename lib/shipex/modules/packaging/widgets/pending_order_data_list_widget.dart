import 'package:core_widgets/core_widgets.dart' hide iterate;
import 'package:flutter/material.dart';
import 'package:flutter_trc/shipex/modules/packaging/modal/packaging_video_selection_dialog.dart';
import 'package:flutter_trc/shipex/modules/packaging/models/group_lot_list_repsonse.dart';
import 'package:flutter_trc/shipex/modules/packaging/providers/group_list_provider.dart';
import 'package:flutter_trc/shipex/modules/packaging/widgets/group_list_data_card_widget.dart';
import 'package:flutter_trc/src/utils/paginate_list_abstract.dart';

import '../l10n.dart';
import '../packaging_process_screen.dart';

class PendingOrderDataList extends StatefulWidget {
  const PendingOrderDataList({super.key});

  @override
  State<PendingOrderDataList> createState() => _PendingOrderDataListState();
}

class _PendingOrderDataListState extends PaginatedListState<GroupLotListData, PendingOrderDataList> {
  String? _query;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var l10n = L10n(context);
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(Dimens.space_16),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: theme.primaryColor),
              borderRadius: BorderRadius.circular(Dimens.space_4),
            ),
            child: SearchBarWidget(
              hintText: "Search by name",
              onQuery: (query) {
                setState(() {
                  _query = query;
                  resetAndRefreshScreen();
                });
              },
            ),
          ),
        ),
        Expanded(
          child: iterate(
            (item, index) {
              return GroupListDataCardWidget(dataModel: item, onCardTap: () => _onItemSelected(item));
            },
            onRefresh: () async {},
            separator: const SizedBox(height: Dimens.space_12),
            onNoDataFound: () {
              return Center(
                child: Text(
                  l10n.noNewDataFound,
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
            padding: const EdgeInsets.symmetric(horizontal: Dimens.space_16, vertical: Dimens.space_12),
          ),
        )
      ],
    );
  }

  _onItemSelected(GroupLotListData item) {
    _showPackagingVideoSelectionDialog(item, onProceed: (isCCTCSelected) {
      PackagingProcessScreenArguments args = PackagingProcessScreenArguments(
          dataModel: item, isPendingGroupLot: true, isCCTCCameraSelected: isCCTCSelected);
      Navigator.of(context).pushNamed(PackagingProcessScreen.route, arguments: args).whenComplete(() {
        resetAndRefreshScreen();
      });
    });
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

  @override
  void requestApi(int pageNo,
      {Function(List<GroupLotListData>? list)? onSuccess, Function(String errorMessage)? onError}) {
    var provider = GroupListProvider.of(context, listen: false);
    provider.fetchPendingDataList(++pageNo, query: _query).then((value) {
      if (onSuccess != null) {
        onSuccess(value);
      }
    }, onError: (error) {
      if (onError != null) {
        onError(error);
      }
    });
  }
}
