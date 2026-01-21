import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_trc/qc/modules/store_out/widgets/store_out_in_progress_dialog.dart';
import 'package:flutter_trc/qc/qc_common/lot_type_filters/screens/store_out_lot_filter_screen.dart';

import '../providers/store_out_provider.dart';
import 'index.dart';

class StoreOutLotListContainer extends StatelessWidget {
  final Function(String? lotName, int? lotId)? onItemClick;

  StoreOutLotListContainer({super.key, this.onItemClick});

  final GlobalKey<StoreOutLotListWidgetState> listKey = GlobalKey<StoreOutLotListWidgetState>();

  void onItemClicked(BuildContext context, String? lotName, int? lotId) {
    var provider = StoreOutProvider.of(context, listen: false);
    CshLoading().showLoading(context);
    provider.getStoreOutProcessStatus(lotId, lotName).then((value) {
      CshLoading().hideLoading(context);
      if (value) {
        showInProgressDialog(context, onProceed: () {
          Navigator.pop(context);
          onItemClick?.call(lotName, lotId);
        }, onCancel: () {
          listKey.currentState?.resetAndRefreshScreen();
        });
      } else {
        onItemClick?.call(lotName, lotId);
      }
    }, onError: (error) {
      CshLoading().hideLoading(context);
      CshSnackBar.error(context: context, message: error);
    });
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          child: Stack(
            children: [
              Positioned.fill(
                child: StoreOutLotListWidget(
                  onItemClick: (String? lotName, int? lotId) => onItemClicked(context, lotName, lotId),
                  key: listKey,
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: Dimens.space_20, vertical: Dimens.space_16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      FloatingActionButton(
                        onPressed: () => _openFilterScreen(context),
                        backgroundColor: theme.primaryColor,
                        heroTag: 'filter',
                        child: CshIcon(
                          FeatherIcons.filter,
                          iconColor: theme.colorScheme.background,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  void _openFilterScreen(BuildContext context) {
    var provider = StoreOutProvider.of(context, listen: false);
    StoreOutLotFilterScreen.navigate(context, selectedLotType: provider.selectedLotTypeList).then((value) {
      if (value != null && value is List<int>) {
        provider.selectedLotTypeList = value;
        listKey.currentState?.resetAndRefreshScreen();
      }
    });
  }
}
