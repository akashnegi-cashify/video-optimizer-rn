import 'package:core/core.dart';
import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/modules/inventory_manager/resources/inventory_manager_service.dart';
import 'package:provider/provider.dart';

import '../models/list_alternate_parts_response.dart';

class AlternatePartListProvider extends CshChangeNotifier {
  static AlternatePartListProvider of(BuildContext context, {bool listen = true}) {
    return Provider.of<AlternatePartListProvider>(context, listen: listen);
  }

  int? prid;
  bool isDataLoading = true;
  String errorMessage = "";
  ListAlternatePartsResponse? listAlternatePartsResponse;

  AlternatePartListProvider(this.prid) {
    _fetchListAlternatePartsData();
  }

  _fetchListAlternatePartsData() {
    InventoryService.listAlternatePartApi(prid!).listen((event) {
      if (event != null) {
        listAlternatePartsResponse = event;
      }
    }, onError: (error) {
      String er = ApiErrorHelper.getErrorMessage(error) ?? "Something went wrong";
      Logger.debug('mydebug------AlternatePartListProvider._fetchListAlternatePartsData', [er]);
      errorMessage = er;
    }, onDone: () {
      isDataLoading = false;

      notifyListeners();
    });
  }
}
