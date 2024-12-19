import 'dart:async';

import 'package:core/core.dart';
import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/qc/modules/data_wipe/resources/data_wipe_filter_list_response.dart';
import 'package:flutter_trc/qc/modules/data_wipe/resources/data_wipe_list_response.dart';
import 'package:flutter_trc/qc/modules/data_wipe/resources/data_wipe_service.dart';
import 'package:provider/provider.dart';

class DataWipeListProvider extends CshChangeNotifier {
  Map<String, List<DataWipFilterListItem>>? _selectedFilter;
  List<DataWipFilterListItem>? _bulkEraseStatusAllowed;
  bool forceHideBulkErase = false;

  static DataWipeListProvider of(BuildContext context, {bool listen = true}) {
    return Provider.of<DataWipeListProvider>(context, listen: listen);
  }

  DataWipeListProvider() {
    _getBulkEraseStatus();
  }

  List<DataWipFilterListItem>? get bulkEraseStatusAllowed => _bulkEraseStatusAllowed;

  Map<String, List<DataWipFilterListItem>>? get selectedFilter => _selectedFilter;

  Future<List<DataWipeListItem>> getDataList(int pageNo, int pageSize) {
    var completer = Completer<List<DataWipeListItem>>();
    DataWipeService.getDataWipeList(pageNo, pageSize, filters: _getFormatedFilter()).listen((event) {
      completer.complete(event.dataWipeList);
    }, onError: (error) {
      completer.completeError(ApiErrorHelper.getErrorMessage(error).toString());
    });
    return completer.future;
  }

  Map<String, List<int>>? _getFormatedFilter() {
    if (_selectedFilter == null) {
      return null;
    }

    Map<String, List<int>> formatedFilter = {};
    _selectedFilter!.forEach((key, value) {
      formatedFilter[key] = value.map((e) => e.id!).toList();
    });
    return formatedFilter;
  }

  void saveSelectedFilters(Map<String, List<DataWipFilterListItem>> selectedFilter) {
    _selectedFilter = selectedFilter;
  }

  _getBulkEraseStatus() {
    DataWipeService.getDataWipeListFilters().listen((event) {
      if (event.dataWipeFilterMap != null && event.dataWipeFilterMap!.containsKey("qf")) {
        _bulkEraseStatusAllowed = event.dataWipeFilterMap!["qf"]!.filterList;
      }
    });
  }

  void initiateBulkErase(int? id) {
    // Implement the logic to initiate bulk erase
  }
}
