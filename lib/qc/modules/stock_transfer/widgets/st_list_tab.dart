import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/qc/modules/stock_transfer/models/stock_transfer_list_response.dart';
import 'package:flutter_trc/qc/modules/stock_transfer/providers/stock_transfer_list_provider.dart';
import 'package:flutter_trc/qc/modules/stock_transfer/widgets/stock_transfer_list_item_widget.dart';
import 'package:flutter_trc/src/common/widgets/shimmer_list_widget.dart';

enum StockTransferListTab { pending, dispatchPending, storeOut }

class StListTab extends StatelessWidget {
  final StockTransferListTab tabType;
  final Function(StockTransferListData item) onItemClicked;

  const StListTab({super.key, required this.tabType, required this.onItemClicked});

  @override
  Widget build(BuildContext context) {
    var provider = StockTransferListProvider.of(context);

    return FutureBuilder<List<StockTransferListData>>(
      future: provider.getList(tabType),
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const ShimmerListWidget();
        }

        if (snapshot.hasError) {
          return CshTextNew.bodyText1(snapshot.error.toString());
        }

        if (snapshot.connectionState == ConnectionState.done && snapshot.hasData) {
          var list = snapshot.data;

          return CshList(
            rowCount: list?.length ?? 0,
            getRowWidget: (index) {
              var item = list?[index];
              return GestureDetector(
                onTap: () => onItemClicked(item!),
                child: StockTransferListItemWidget(item, index),
              );
            },
            onRefresh: () {
              provider.getList(tabType, isForceRefresh: true);
            },
            errorMsg: provider.errorMessage,
            noDataFoundWidget: ({isListEmpty, serverErrorMsg}) => CshTextNew.bodyText1(
                Validator.isTrue(isListEmpty) ? "No data found" : serverErrorMsg ?? "Something went wrong"),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
