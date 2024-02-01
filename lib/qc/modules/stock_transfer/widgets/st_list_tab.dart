import 'package:core_widgets/core_widgets.dart' hide iterate;
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_trc/qc/modules/stock_transfer/resources/stock_transfer_list_response.dart';
import 'package:flutter_trc/qc/modules/stock_transfer/resources/stock_transfer_status_filter_response.dart';
import 'package:flutter_trc/qc/modules/stock_transfer/providers/stock_transfer_list_provider.dart';
import 'package:flutter_trc/qc/modules/stock_transfer/screens/pending_dispatch_detail%20screen.dart';
import 'package:flutter_trc/qc/modules/stock_transfer/screens/pending_lot_detail_screen.dart';
import 'package:flutter_trc/qc/modules/stock_transfer/screens/st_store_out_screen.dart';
import 'package:flutter_trc/qc/modules/stock_transfer/widgets/stock_transfer_list_item_widget.dart';
import 'package:flutter_trc/src/common/utils/csh_ml_scanner_util.dart';
import 'package:flutter_trc/src/common/widgets/my_search_bar_widget.dart';
import 'package:flutter_trc/src/utils/paginate_list_abstract.dart';
import '../l10n.dart';

enum StockTransferListTab {
  pending("PENDING"),
  dispatchPending("DISPATCH_PENDING"),
  storeOut("STORE_OUT");

  final String value;

  const StockTransferListTab(this.value);
}

class StListTab extends StatefulWidget {
  final StockTransferListTab tabType;

  const StListTab({super.key, required this.tabType});

  @override
  State<StListTab> createState() => StListTabState();
}

class StListTabState extends PaginatedListState<StockTransferListData, StListTab> {
  @override
  Widget build(BuildContext context) {
    var provider = StockTransferListProvider.of(context);
    var theme = Theme.of(context);
    return Stack(
      children: [
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(Dimens.space_16, Dimens.space_16, Dimens.space_16, 0),
              child: MySearchBarWidget(
                onQuery: (String query) {
                  provider.searchQuery = query;
                  resetAndRefreshScreen();
                },
              ),
            ),
            Expanded(
              child: iterate(
                (item, index) {
                  return GestureDetector(
                    onTap: () => _onItemClicked(widget.tabType, item),
                    child: StockTransferListItemWidget(item, index),
                  );
                },
                separator: const SizedBox(height: Dimens.space_16),
                padding: const EdgeInsets.all(Dimens.space_16),
                onNoDataFound: () {
                  return Center(child: CshTextNew.bodyText1("No data found"));
                },
                onRefresh: () async {},
              ),
            )
          ],
        ),
        Positioned(
            bottom: Dimens.space_16,
            right: Dimens.space_16,
            child: FloatingActionButton(
              backgroundColor: theme.primaryColor,
              onPressed: () => _onFilterIconPressed(provider),
              child: CshIcon(FeatherIcons.filter, iconColor: theme.colorScheme.background),
            ))
      ],
    );
  }

  void _onFilterIconPressed(StockTransferListProvider provider) {
    CshLoading().showLoading(context);
    provider.getStatusFilterList(widget.tabType).then((value) {
      CshLoading().hideLoading(context);
      List<StockTransferStatusFilterData> cloneList = value.map((e) => e.clone()).toList();
      _showFilterDialog(cloneList, provider);
    }, onError: (error) {
      CshLoading().hideLoading(context);
      CshSnackBar.error(context: context, message: error.toString());
    });
  }

  void _onItemClicked(StockTransferListTab tabType, StockTransferListData item) async {
    switch (tabType) {
      case StockTransferListTab.pending:
        Navigator.pushNamed(context, PendingLotDetailScreen.route,
            arguments: PendingLotDetailScreen.arguments(item.lotId!));
        break;
      case StockTransferListTab.dispatchPending:
        CshMlScannerUtil().openScanner(context, hintText: "Scan Invoice", header: "Scan Invoice",
            onScanned: (scannedData, controller) async {
          if (scannedData.isNotEmpty) {
            Navigator.pop(context); // dismiss scanner screen
            var isRefresh = await Navigator.pushNamed(context, PendingDispatchDetailScreen.route,
                arguments: PendingDispatchDetailScreen.arguments(item.lotName ?? "", scannedData));
            if (isRefresh == true) {
              resetAndRefreshScreen();
            }
          }
        });
        break;

      case StockTransferListTab.storeOut:
        var isRefresh = await Navigator.pushNamed(context, StStoreOutScreen.route,
            arguments: StStoreOutScreen.arguments(item.lotId!));
        if (isRefresh == true) {
          resetAndRefreshScreen();
        }
        break;
    }
  }

  @override
  void requestApi(int pageNo,
      {Function(List<StockTransferListData>? list)? onSuccess, Function(String errorMessage)? onError}) {
    var provider = StockTransferListProvider.of(context, listen: false);
    provider.getPaginatedList(pageNo * pageSize, pageSize, widget.tabType).then((value) {
      onSuccess?.call(value);
    }, onError: (error) {
      onError?.call(error);
    });
  }

  _showFilterDialog(List<StockTransferStatusFilterData> filterList, StockTransferListProvider provider) {
    var l10n = L10n(context, listen: false);
    showCshBottomSheet(
      context: context,
      child: StatefulBuilder(builder: (_, setState) {
        return Container(
          padding: const EdgeInsets.all(8.0),
          height: MediaQuery.of(context).size.height * 0.8,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(Dimens.space_16),
                child: CshTextNew.h2(l10n.filter),
              ),
              Expanded(
                child: ListView.separated(
                    padding: const EdgeInsets.all(Dimens.space_16),
                    itemBuilder: (context, index) {
                      var item = filterList[index];
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            item.isSelected = !(item.isSelected ?? false);
                          });
                          // provider.updateFilterSelectionState(item.key);
                        },
                        child: CshCard(
                          child: CshCheckbox(
                            title: CshTextNew.bodyText1(item.name ?? ""),
                            onChanged: (value) {
                              setState(() {
                                item.isSelected = !(item.isSelected ?? false);
                              });
                            },
                            isSelected: item.isSelected ?? false,
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const SizedBox(height: Dimens.space_16);
                    },
                    itemCount: filterList.length),
              ),
              ComboButton(
                firstBtnText: l10n.cancel,
                secondBtnText: l10n.apply,
                isFirstPrimary: true,
                firstBtnClick: () => Navigator.pop(context),
                secondBtnClick: () {
                  Navigator.pop(context);
                  provider.updateFilterSelectionState(filterList);
                  resetAndRefreshScreen();
                },
              ),
            ],
          ),
        );
      }),
    );
  }
}
