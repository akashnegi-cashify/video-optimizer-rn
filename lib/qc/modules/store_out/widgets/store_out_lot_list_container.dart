import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_trc/qc/modules/store_out/widgets/store_out_in_progress_dialog.dart';
import 'package:flutter_trc/qc/qc_common/lot_type_filters/screens/store_out_lot_filter_screen.dart';
import 'package:flutter_trc/src/common/widgets/my_search_bar_widget.dart';
import 'package:provider/provider.dart';

import '../l10n.dart';
import '../providers/store_out_provider.dart';
import 'index.dart';

class StoreOutLotListContainer extends StatelessWidget {
  final Function(String? lotName)? onItemClick;

  StoreOutLotListContainer({super.key, this.onItemClick});

  final GlobalKey<StoreOutLotListWidgetState> listKey = GlobalKey<StoreOutLotListWidgetState>();

  void onItemClicked(BuildContext context, String? lotName, int? lotId) {
    var provider = StoreOutProvider.of(context, listen: false);
    CshLoading().showLoading(context);
    provider.getStoreOutProcessStatus(lotId).then((value) {
      CshLoading().hideLoading(context);
      if (value) {
        showInProgressDialog(context, onProceed: () {
          Navigator.pop(context);
          onItemClick?.call(lotName);
        }, onCancel: () {
          listKey.currentState?.resetAndRefreshScreen();
        });
      } else {
        onItemClick?.call(lotName);
      }
    }, onError: (error) {
      CshLoading().hideLoading(context);
      CshSnackBar.error(context: context, message: error);
    });
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var l10n = L10n(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Selector<StoreOutProvider, ({bool showSearchBox, bool isStoreOutInProgress})>(
          builder: (BuildContext selectorContext, value, Widget? child) {
            var provider = StoreOutProvider.of(selectorContext, listen: false);
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: Dimens.space_16, vertical: Dimens.space_16),
              child: Column(
                children: [
                  if (value.showSearchBox)
                    MySearchBarWidget(
                      isAutoFocus: true,
                      showBorder: false,
                      onQuery: (query) {
                        provider.setSearchQuery(query);
                        listKey.currentState?.resetAndRefreshScreen();
                      },
                    ),
                  CshCard(
                    padding: const EdgeInsets.only(left: Dimens.space_16, right: Dimens.space_8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CshTextNew.subTitle2(l10n.inProcessLot),
                        CshSwitch(
                          isSelected: value.isStoreOutInProgress,
                          onChanged: (value) {
                            provider.isStoreOutInProgress = value;
                            listKey.currentState?.resetAndRefreshScreen();
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
          selector: (_, StoreOutProvider provider) {
            return (showSearchBox: provider.showSearchBox, isStoreOutInProgress: provider.isStoreOutInProgress);
          },
        ),
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
                left: 0,
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
                      Selector<StoreOutProvider, bool>(
                        builder: (BuildContext context, value, Widget? child) {
                          return FloatingActionButton(
                            onPressed: () => _showSearchBox(context),
                            backgroundColor: theme.primaryColor,
                            heroTag: 'searchQuery',
                            child: CshIcon(
                              value ? FeatherIcons.x : FeatherIcons.search,
                              iconColor: theme.colorScheme.background,
                            ),
                          );
                        },
                        selector: (_, StoreOutProvider provider) {
                          return provider.showSearchBox;
                        },
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

  void _showSearchBox(BuildContext context) {
    var provider = StoreOutProvider.of(context, listen: false);
    provider.showSearchBox = !provider.showSearchBox;
    if (isNotEmpty(provider.searchQuery)) {
      provider.setSearchQuery("");
      listKey.currentState?.resetAndRefreshScreen();
    }
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
