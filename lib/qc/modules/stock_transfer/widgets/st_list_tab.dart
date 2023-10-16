import 'dart:async';

import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/qc/modules/stock_transfer/models/stock_transfer_list_response.dart';
import 'package:flutter_trc/qc/modules/stock_transfer/providers/stock_transfer_list_provider.dart';
import 'package:flutter_trc/qc/modules/stock_transfer/widgets/stock_transfer_list_item_widget.dart';
import 'package:flutter_trc/src/common/widgets/shimmer_list_widget.dart';

enum StockTransferListTab { pending, dispatchPending, storeOut }

class StListTab extends StatefulWidget {
  final StockTransferListTab tabType;
  final Function(StockTransferListData item) onItemClicked;

  const StListTab({super.key, required this.tabType, required this.onItemClicked});

  @override
  State<StListTab> createState() => _StListTabState();
}

class _StListTabState extends State<StListTab> {
  @override
  void initState() {
    scheduleMicrotask(() {
      var provider = StockTransferListProvider.of(context, listen: false);
      provider.getList(widget.tabType);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var provider = StockTransferListProvider.of(context);
    if (provider.isLoading) {
      return const ShimmerListWidget();
    }
    List<StockTransferListData>? list;
    switch (widget.tabType) {
      case StockTransferListTab.pending:
        list = provider.pendingList;
        break;
      case StockTransferListTab.dispatchPending:
        list = provider.dispatchPendingList;
        break;
      case StockTransferListTab.storeOut:
        list = provider.storeOutList;
        break;
    }

    return CshList(
      rowCount: list?.length ?? 0,
      getRowWidget: (index) {
        var item = list?[index];
        return GestureDetector(
          onTap: () => widget.onItemClicked(item!),
          child: StockTransferListItemWidget(item, index),
        );
      },
      onRefresh: () {
        provider.getList(widget.tabType, isForceRefresh: true);
      },
      errorMsg: provider.errorMessage,
      noDataFoundWidget: ({isListEmpty, serverErrorMsg}) => CshTextNew.bodyText1(
          Validator.isTrue(isListEmpty) ? "No data found" : serverErrorMsg ?? "Something went wrong"),
    );
  }
}
