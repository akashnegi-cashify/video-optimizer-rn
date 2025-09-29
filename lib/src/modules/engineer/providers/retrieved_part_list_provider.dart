import 'dart:async';

import 'package:core/core.dart';
import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/common/searchable.dart';
import 'package:flutter_trc/src/modules/engineer/components/retrieved_part_list_component.dart';
import 'package:flutter_trc/src/modules/engineer/models/retrieved_part_list_response.dart';
import 'package:flutter_trc/src/modules/engineer/resources/engineer_api_service.dart';
import 'package:flutter_trc/src/modules/part_qc/resources/pq_services.dart';
import 'package:provider/provider.dart';

class RetrievedPartListProvider extends CshChangeNotifier with Searchable {
  final RoleType roleType;

  RetrievedPartListProvider(this.roleType);

  static RetrievedPartListProvider of(BuildContext context, {bool listen = true}) {
    return Provider.of<RetrievedPartListProvider>(context, listen: listen);
  }

  Future<List<RetrievedPartListData>> getList(int pageNo, int pageSize) {
    var completer = Completer<List<RetrievedPartListData>>();
    EngineerAPIService.getRetrievedPartList(pageNo, pageSize, query: searchQuery, roleType: roleType).listen((event) {
      if (Validator.isListNullOrEmpty(event?.retrievedPartListResponse?.retrievedPartList)) {
        completer.completeError("No data found");
      } else {
        completer.complete(event!.retrievedPartListResponse!.retrievedPartList);
      }
    }, onError: (error, stackTrace) {
      Logger.debug('mydebug-----RetrievedPartListProvider.getList', [stackTrace]);
      completer.completeError(ApiErrorHelper.getErrorMessage(error).toString());
    });
    return completer.future;
  }

  Future<bool> receivePart(String partBarcode) {
    var completer = Completer<bool>();
    PartQcServiceElss.receiveRetrievedParts(partBarcode).listen((event) {
      if (Validator.isTrue(event?.isSuccess)) {
        completer.complete(true);
      } else {
        completer.completeError(event?.errorMsg ?? "No data found");
      }
    }, onError: (error, stackTrace) {
      Logger.debug('mydebug-----RetrievedPartListProvider.receivePart', [stackTrace]);
      completer.completeError(ApiErrorHelper.getErrorMessage(error).toString());
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
}
