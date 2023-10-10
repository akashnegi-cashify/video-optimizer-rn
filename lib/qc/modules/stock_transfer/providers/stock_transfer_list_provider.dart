import 'dart:async';

import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/qc/modules/stock_transfer/models/stock_transfer_list_response.dart';
import 'package:flutter_trc/qc/modules/stock_transfer/resources/stock_transfer_service.dart';
import 'package:flutter_trc/qc/modules/stock_transfer/widgets/st_list_tab.dart';
import 'package:provider/provider.dart';

class StockTransferListProvider extends CshChangeNotifier {
  bool isLoading = true;
  String? errorMessage;
  List<StockTransferListData>? dispatchPendingList = [];
  List<StockTransferListData>? pendingList = [];
  List<StockTransferListData>? storeOutList;

  static StockTransferListProvider of(BuildContext context, {bool listen = true}) {
    return Provider.of<StockTransferListProvider>(context, listen: listen);
  }

  Future<List<StockTransferListData>> getList(StockTransferListTab tabType, {bool isForceRefresh = false}) async {
    switch (tabType) {
      case StockTransferListTab.pending:
        if (!Validator.isListNullOrEmpty(pendingList) && !isForceRefresh) {
          return Future.value(pendingList);
        }
        try {
          await _getStockTransferList();
          return Future.value(pendingList);
        } catch (e) {
          return Future.error(e);
        }

      case StockTransferListTab.dispatchPending:
        if (!Validator.isListNullOrEmpty(dispatchPendingList) && !isForceRefresh) {
          return Future.value(dispatchPendingList);
        }
        try {
          await _getStockTransferList();
          return Future.value(dispatchPendingList);
        } catch (e) {
          return Future.error(e);
        }
      case StockTransferListTab.storeOut:
        try {
          await _getStockTransferList(isStoreOut: true);
          return Future.value(storeOutList);
        } catch (e) {
          return Future.error(e);
        }
    }
  }

  Future<bool> _getStockTransferList({bool isStoreOut = false}) {
    var completer = Completer<bool>();
    StockTransferService.getStockTransferList(isStoreOut: isStoreOut).listen((event) {
      if (Validator.isListNullOrEmpty(event?.lotList)) {
        completer.completeError("No data found");
      } else {
        if (isStoreOut) {
          storeOutList = event?.lotList;
        } else {
          for (var item in event!.lotList!) {
            if (item.statusCode == 3) {
              dispatchPendingList?.add(item);
            } else {
              pendingList?.add(item);
            }
          }
        }
        completer.complete(true);
      }
    }, onError: (error) {
      completer.completeError(ApiErrorHelper.getErrorMessage(error).toString());
    });
    return completer.future;
  }
}
