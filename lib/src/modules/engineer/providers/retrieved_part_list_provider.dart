import 'dart:async';

import 'package:core/core.dart';
import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/common/searchable.dart';
import 'package:flutter_trc/src/modules/engineer/models/retrieved_part_list_response.dart';
import 'package:flutter_trc/src/modules/engineer/resources/engineer_api_service.dart';
import 'package:provider/provider.dart';

class RetrievedPartListProvider extends CshChangeNotifier with Searchable {
  static RetrievedPartListProvider of(BuildContext context, {bool listen = true}) {
    return Provider.of<RetrievedPartListProvider>(context, listen: listen);
  }

  Future<List<RetrievedPartListData>> getList(int pageNo, int pageSize) {
    var completer = Completer<List<RetrievedPartListData>>();
    EngineerAPIService.getRetrievedPartList(pageNo, pageSize).listen((event) {
      if (Validator.isListNullOrEmpty(event?.retrievedPartListData)) {
        completer.completeError("No data found");
      } else {
        completer.complete(event?.retrievedPartListData);
      }
    }, onError: (error) {
      completer.completeError(ApiErrorHelper.getErrorMessage(error).toString());
    });
    return completer.future;
  }
}
