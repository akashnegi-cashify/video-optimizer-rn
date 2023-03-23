import 'package:core/core.dart';
import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/part_summary_response.dart';
import '../models/return_receive_count_response.dart';
import '../resources/inventory_manager_service.dart';

class SummaryProvider extends CshChangeNotifier {
  static SummaryProvider of(BuildContext context, {bool listen = true}) {
    return Provider.of<SummaryProvider>(context, listen: listen);
  }

  bool isDataLoading = true;
  ReturnCountResponse? returnCountResponse;
  PartSummaryResponse? partSummaryResponse;

  SummaryProvider() {
    _fetchReturnCountResponse();
  }

  _fetchReturnCountResponse() {
    InventoryService.inventoryReturnReceiveCount().listen((event) {
      if (event != null) {
        returnCountResponse = event;
      }
    }, onError: (error) {
      String er = ApiErrorHelper.getErrorMessage(error) ?? "Something went wrong";
      Logger.debug('mydebug------SummaryProvider._fetchReturnCountResponse', [er]);
    }, onDone: () {
      _fetchPartSummaryResponse();
      notifyListeners();
    });
  }

  _fetchPartSummaryResponse() {
    InventoryService.inventoryPartSummary().listen(
      (event) {
        if (event != null) {
          partSummaryResponse = event;
        }
      },
      onError: (error) {
        String erm = ApiErrorHelper.getErrorMessage(error) ?? "Something went wrong";
        Logger.debug('mydebug------SummaryProvider._fetchPartSummaryResponse', [erm]);
      },
      onDone: () {
        isDataLoading = false;
        notifyListeners();
      },
    );
  }
}
