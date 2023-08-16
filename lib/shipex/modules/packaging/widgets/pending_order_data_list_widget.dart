import 'dart:async';

import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/shipex/modules/packaging/modal/packaging_video_selection_dialog.dart';
import 'package:flutter_trc/shipex/modules/packaging/models/group_lot_list_repsonse.dart';
import 'package:flutter_trc/shipex/modules/packaging/providers/group_list_provider.dart';

import '../l10n.dart';
import '../packaging_process_screen.dart';
import 'group_list_data_card_widget.dart';

class PendingOrderDataList extends StatefulWidget {
  const PendingOrderDataList({super.key});

  @override
  State<PendingOrderDataList> createState() => _PendingOrderDataListState();
}

class _PendingOrderDataListState extends State<PendingOrderDataList> {
  @override
  void initState() {
    scheduleMicrotask(() {
      var provider = GroupListProvider.of(context, listen: false);
      provider.fetchPendingDataList();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var provider = GroupListProvider.of(context);
    var theme = Theme.of(context);
    var l10n = L10n(context);
    if (Validator.isTrue(provider.pendingDataLoading)) {
      return const Center(
        child: SizedBox(
          height: Dimens.space_30,
          width: Dimens.space_30,
          child: CircularProgressIndicator(),
        ),
      );
    } else if (!Validator.isNullOrEmpty(provider.pendingErrorListMessage)) {
      return Center(
        child: Row(
          children: [
            const SizedBox.shrink(),
            Expanded(
              child: Text(
                provider.pendingErrorListMessage!,
                style: theme.primaryTextTheme.headlineMedium,
                textAlign: TextAlign.center,
              ),
            )
          ],
        ),
      );
    } else {
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
                  provider.setQuery(query);
                },
              ),
            ),
          ),
          Validator.isListNullOrEmpty(provider.groupDataPendingList)
              ? Center(
                  child: Row(
                    children: [
                      const SizedBox.shrink(),
                      Expanded(
                        child: Text(
                          l10n.noPendingListDataFound,
                          style: theme.primaryTextTheme.headlineMedium,
                          textAlign: TextAlign.center,
                        ),
                      )
                    ],
                  ),
                )
              : Expanded(
                  child: ListView.separated(
                    padding: const EdgeInsets.symmetric(vertical: Dimens.space_12, horizontal: Dimens.space_16),
                    itemBuilder: (context, index) {
                      var item = provider.groupDataPendingList![index];
                      return GroupListDataCardWidget(dataModel: item, onCardTap: () => _onItemSelected(item));
                    },
                    separatorBuilder: (context, index) {
                      return const SizedBox(height: Dimens.space_12);
                    },
                    itemCount: provider.groupDataPendingList!.length,
                  ),
                )
        ],
      );
    }
  }

  _onItemSelected(GroupLotListData item) {
    _showPackagingVideoSelectionDialog(item, onProceed: (isCCTCSelected) {
      PackagingProcessScreenArguments args = PackagingProcessScreenArguments(
          dataModel: item, isPendingGroupLot: true, isCCTCCameraSelected: isCCTCSelected);
      Navigator.of(context).pushNamed(PackagingProcessScreen.route, arguments: args).whenComplete(() {
        var provider = GroupListProvider.of(context, listen: false);
        provider.fetchPendingDataList();
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
}
