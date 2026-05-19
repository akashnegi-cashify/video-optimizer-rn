import 'dart:async';

import 'package:core/core.dart';
import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/modules/engineer/my_devices/wip_devices/view_parts/part_detail/models/retrieved_part_reason_list_response.dart';
import 'package:flutter_trc/src/modules/engineer/resources/engineer_api_service.dart';
import 'package:provider/provider.dart';

class CaptureConsumePartsMediaProvider extends CshChangeNotifier {
  List<RetrievedPartReasonListData>? reasonList;

  static CaptureConsumePartsMediaProvider of(BuildContext context, {bool listen = true}) {
    return Provider.of<CaptureConsumePartsMediaProvider>(context, listen: listen);
  }

  Future<List<RetrievedPartReasonListData>> getReasonsList(int? partRequestId) {
    if (reasonList != null) {
      return Future.value(reasonList);
    }
    var completer = Completer<List<RetrievedPartReasonListData>>();
    EngineerAPIService.getRetrievedPartReasonList(partRequestId).listen((event) {
      if (Validator.isListNullOrEmpty(event?.reasonList)) {
        completer.completeError("No Data found");
      } else {
        reasonList = event?.reasonList;
        completer.complete(event!.reasonList!);
      }
    }, onError: (error) {
      completer.completeError(ApiErrorHelper.getErrorMessage(error).toString());
    });
    return completer.future;
  }
}
