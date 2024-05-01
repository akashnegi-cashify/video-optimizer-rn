import 'dart:async';

import 'package:core/core.dart';
import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/modules/part_qc/resources/pq_services.dart';
import 'package:flutter_trc/src/modules/part_qc/retrieved_part_qc/providers/base_part_qc_retrieved_part_provider.dart';
import 'package:provider/provider.dart';

class PartQcRetrievedPartDashboardProvider extends BasePartQcRetrievedPartProvider {
  static PartQcRetrievedPartDashboardProvider of(BuildContext context, {bool listen = true}) {
    return Provider.of<PartQcRetrievedPartDashboardProvider>(context, listen: listen);
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
      completer.completeError(ApiErrorHelper.getErrorMessage(error).toString());
    });
    return completer.future;
  }

  @override
  Map<String, dynamic>? getFilterData() {
    return null;
  }
}
