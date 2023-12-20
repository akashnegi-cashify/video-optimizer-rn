import 'dart:async';

import 'package:core/core.dart';
import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/qc/modules/stock_transfer/models/stock_transfer_list_response.dart';
import 'package:flutter_trc/qc/modules/stock_transfer/models/stock_transfer_status_filter_response.dart';
import 'package:flutter_trc/qc/modules/stock_transfer/resources/stock_transfer_service.dart';
import 'package:flutter_trc/qc/modules/stock_transfer/widgets/st_list_tab.dart';
import 'package:flutter_trc/src/common/searchable.dart';
import 'package:provider/provider.dart';

class StockTransferListProvider extends CshChangeNotifier with Searchable {
  List<StockTransferStatusFilterData>? _filterList;

  static StockTransferListProvider of(BuildContext context, {bool listen = true}) {
    return Provider.of<StockTransferListProvider>(context, listen: listen);
  }

  Future<List<StockTransferListData>> getPaginatedList(int offset, int pageSize, StockTransferListTab tabType) {
    var completer = Completer<List<StockTransferListData>>();

    StockTransferService.getStockTransferList(
            tabType: tabType.value,
            offset: offset,
            pageSize: pageSize,
            searchQuery: searchQuery,
            statusListFilter: _getSelectedFilters())
        .listen((event) {
      if (!Validator.isListNullOrEmpty(event?.lotList)) {
        completer.complete(event?.lotList);
      } else {
        completer.completeError("No data found");
      }
    }, onError: (error) {
      completer.completeError(ApiErrorHelper.getErrorMessage(error).toString());
    });
    return completer.future;
  }

  List<int>? _getSelectedFilters() {
    var selectedFilterList = _filterList?.where((element) => element.isSelected == true);
    return selectedFilterList?.map((e) => e.id!).toList();
  }

  Future<List<StockTransferStatusFilterData>> getStatusFilterList(StockTransferListTab tabType) {
    if (_filterList != null) {
      return Future.value(_filterList);
    }
    var completer = Completer<List<StockTransferStatusFilterData>>();
    StockTransferService.getStatusFilterList(tabType.value).listen((event) {
      if (event?.filterList != null) {
        _filterList = event?.filterList;
        completer.complete(_filterList);
      } else {
        completer.completeError("No data found");
      }
    }, onError: (error) {
      completer.completeError(ApiErrorHelper.getErrorMessage(error).toString());
    });
    return completer.future;
  }

  void updateFilterSelectionState(List<StockTransferStatusFilterData> value) {
    _filterList = value;
  }
}
