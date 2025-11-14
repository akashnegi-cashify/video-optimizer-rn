import 'package:components/components.dart';
import 'package:core_widgets/core_widgets.dart' hide iterate;
import 'package:flutter/material.dart';
import 'package:flutter_trc/qc/modules/stock_transfer/resources/stock_transfer_list_response.dart';
import 'package:flutter_trc/qc/modules/stock_transfer/screens/pending_dispatch_detail%20screen.dart';
import 'package:flutter_trc/qc/modules/stock_transfer/screens/pending_lot_detail_screen.dart';
import 'package:flutter_trc/qc/modules/stock_transfer/screens/st_store_out_screen.dart';
import 'package:flutter_trc/qc/modules/stock_transfer/widgets/stock_transfer_list_item_widget.dart';
import 'package:flutter_trc/src/common/utils/csh_ml_scanner_util.dart';
import 'package:flutter_trc/src/services/service_groups.dart';
import 'package:flutter_trc/src/interceptors/auth/request_headers.dart';

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

class StListTabState extends State<StListTab> {
  @override
  Widget build(BuildContext context) {
    return CshApiList<StockTransferListData>(
      apiConfig: ListApiConfig(
        apiUrl: "/v1/transfer-lot/list-lots?requestTab=${widget.tabType.value}&",
        serviceGroup: TRCServiceGroups.qcTransferLot,
         headers: {
                "X-User-Auth": "${AuthHandler().userAuth}" ,
                'X-SSO-TOKEN' : 'false'           
              }
      ),
      shimmerLoaderWidget: const CshShimmer(height: Dimens.space_60),
      listPadding: const EdgeInsets.all(Dimens.space_16),
      verticalRowSpacing: Dimens.space_16,
      itemFromJson: StockTransferListData.fromJson,
      getRowWidget: (item, index) {
        return GestureDetector(
          onTap: () => _onItemClicked(widget.tabType, item!),
          child: StockTransferListItemWidget(item, index),
        );
      },
    );
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
          }
        });
        break;

      case StockTransferListTab.storeOut:
        var isRefresh = await Navigator.pushNamed(context, StStoreOutScreen.route,
            arguments: StStoreOutScreen.arguments(item.lotId!));
        break;
    }
  }
}
