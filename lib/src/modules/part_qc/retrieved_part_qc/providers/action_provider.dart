import 'dart:async';

import 'package:core/core.dart';
import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/modules/engineer/components/retrieved_part_list_component.dart';
import 'package:provider/provider.dart';

import '../../../engineer/models/retrieved_part_list_response.dart';
import '../../../engineer/resources/engineer_api_service.dart';
import '../../resources/pq_services.dart';



class ActionProvider extends CshChangeNotifier {
  static ActionProvider of(BuildContext context, {bool listen = true}) {
    return Provider.of<ActionProvider>(context, listen: listen);
  }

  ListState<RetrievedPartListData> listState = ListState(status: RequestStatus.initial);

  ActionProvider(String barcode) {
  }

  Future<bool> updateRetrievedPartStatus(bool isFaulty, int partId, String? remarks) {
    var completer = Completer<bool>();
    PartQcServiceElss.updateRetrievedPartStatus(isFaulty, partId, remarks: remarks).listen((event) {
      if (event != null) {
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
