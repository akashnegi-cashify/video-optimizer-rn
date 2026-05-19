import 'dart:async';

import 'package:core/core.dart';
import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/qc/modules/data_wipe/resources/data_wipe_filter_list_response.dart';
import 'package:flutter_trc/qc/modules/data_wipe/resources/data_wipe_service.dart';
import 'package:provider/provider.dart';

class DataWipeListProvider extends CshChangeNotifier {
  List<DataWipFilterListItem>? _bulkEraseStatusAllowed;
  bool forceHideBulkErase = false;

  static DataWipeListProvider of(BuildContext context, {bool listen = true}) {
    return Provider.of<DataWipeListProvider>(context, listen: listen);
  }

  List<DataWipFilterListItem>? get bulkEraseStatusAllowed => _bulkEraseStatusAllowed;

  void setBulkEraseStatusAllowedFromFilters(DataWipeFilterListResponse response) {
    if (response.dataWipeFilterMap != null && response.dataWipeFilterMap!.containsKey("qf")) {
      _bulkEraseStatusAllowed = response.dataWipeFilterMap!["qf"]!.filterList;
    }
  }

  Future<String> initiateBulkErase(int id) async {
    try {
      final resp = await DataWipeService.bulkInitiate(id).first;
      forceHideBulkErase = true;
      return resp.successMessage ?? "Bulk process initiated";
    } catch (error) {
      throw ApiErrorHelper.getErrorMessage(error).toString();
    }
  }
}
