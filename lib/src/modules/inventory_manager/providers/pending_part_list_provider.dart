import 'package:core/core.dart';
import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/modules/inventory_manager/resources/inventory_manager_service.dart';
import 'package:provider/provider.dart';

import '../models/pending_part_list_response.dart';

class PendingPartListProvider extends CshChangeNotifier {
  static PendingPartListProvider of(BuildContext context, {bool listen = true}) {
    return Provider.of<PendingPartListProvider>(context, listen: listen);
  }

  int did;
  bool isDataLoading = true;
  String errorMessage = "";
  PendingPartListResponse? pendingPartListResponse;

  PendingPartListProvider(this.did) {
    _fetchPendingPartsDataList();
  }

  _fetchPendingPartsDataList() {
    InventoryService.getPendingPartListData(did).listen((event) {
      if (event != null) {
        pendingPartListResponse = event;
      }
    }, onError: (error) {
      String errMessage = ApiErrorHelper.getErrorMessage(error) ?? "Something Went Wrong!!";
      errorMessage = errMessage;
      Logger.debug('mydebug------PendingPartListProvider._fetchPendingPartsDataList', [errMessage]);
    }, onDone: () {
      isDataLoading = false;
      notifyListeners();
    });
  }

  refreshList() {
    isDataLoading = true;
    notifyListeners();
    _fetchPendingPartsDataList();
  }
}
