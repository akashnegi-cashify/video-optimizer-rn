import 'dart:async';

import 'package:core/core.dart';
import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/modules/engineer/components/retrieved_part_list_component.dart';
import 'package:provider/provider.dart';

import '../../engineer/models/retrieved_part_list_response.dart';
import '../../engineer/resources/engineer_api_service.dart';
import '../../part_qc/resources/pq_services.dart';

class ActionProvider extends CshChangeNotifier {
  static ActionProvider of(BuildContext context, {bool listen = true}) {
    return Provider.of<ActionProvider>(context, listen: listen);
  }

  ListState<RetrievedPartListData> listState = ListState(status: RequestStatus.initial);

  ActionProvider(String barcode) {
    getItemData(barcode);
  }

  Future<bool> getItemData(String barcode) {
    listState = ListState(status: RequestStatus.initial);
    var completer = Completer<bool>();
    EngineerAPIService.getRetrievedPartList(0, 10, query: barcode, roleType: RoleType.partQc).listen((event) {
      if (Validator.isListNullOrEmpty(event?.retrievedPartListResponse?.retrievedPartList)) {
        listState = ListState(status: RequestStatus.failure, items: [], errorMsg: "No Data Found");
        completer.completeError("No Data Found!!");
      } else {
        listState = ListState(
            status: RequestStatus.success, items: event!.retrievedPartListResponse!.retrievedPartList!, errorMsg: null);
        completer.complete(true);
      }
    }, onError: (error, stackTrace) {
      String apiErr = ApiErrorHelper.getErrorMessage(error) ?? "Something went wrong";
      listState = ListState(status: RequestStatus.failure, items: [], errorMsg: apiErr);
      completer.completeError(apiErr);
    }, onDone: () {
      notifyListeners();
    });
    return completer.future;
  }

  Future<bool> updateRetrievedPartStatus(bool isFaulty, int partId) {
    var completer = Completer<bool>();
    PartQcServiceElss.updateRetrievedPartStatus(isFaulty, partId).listen((event) {
      if (Validator.isTrue(event?.isSuccess)) {
        completer.complete(true);
      } else {
        completer.completeError(event?.errorMsg ?? "No data found");
      }
    }, onError: (error, stackTrace) {
      Logger.debug('mydebug-----RetrievedPartListProvider.updateRetrievedPartStatus', [stackTrace]);
      completer.completeError(ApiErrorHelper.getErrorMessage(error).toString());
    });
    return completer.future;
  }

  resetListData() {
    listState = ListState(status: RequestStatus.initial, items: []);
    notifyListeners();
  }
}
