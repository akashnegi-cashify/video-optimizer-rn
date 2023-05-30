import 'dart:async';

import 'package:core/core.dart';
import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/modules/part_qc/resources/pq_services.dart';
import 'package:provider/provider.dart';

import '../models/qc_parts_list_response.dart';

class PartQcProvider extends CshChangeNotifier {
  static PartQcProvider of(BuildContext context, {bool listen = true}) {
    return Provider.of<PartQcProvider>(context, listen: listen);
  }

  bool isDataLoading = true;
  String errorMessage = "";
  QcPartsListResponse? qcPartsListResponse;

  Future<QcPartsListResponse?> fetchQcPartList({String? pbr}) {
    var completer = Completer<QcPartsListResponse?>();
    try {
      PartQCService.getQcPartList(pbr: pbr).listen(
        (event) {
          if (event != null && event.isSuccess == true) {
            qcPartsListResponse = event;
            completer.complete(event);
          } else {
            completer.completeError("Something went wrong");
          }
        },
        onError: (error) {
          String er = ApiErrorHelper.getErrorMessage(error) ?? "Something went wrong";
          Logger.debug('mydebug------QcProvider._fetchQcPartsList', [er]);
          errorMessage = er;
          completer.completeError(er);
        },
        onDone: () {
          isDataLoading = false;
          notifyListeners();
        },
      );
    } catch (e) {
      completer.completeError(e.toString());
    }
    return completer.future;
  }
}
