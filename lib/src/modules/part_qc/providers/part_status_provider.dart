import 'dart:async';

import 'package:core/core.dart';
import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/modules/part_qc/resources/pq_services.dart';
import 'package:provider/provider.dart';

class PartStatusProvider extends CshChangeNotifier {
  static PartStatusProvider of(BuildContext context, {bool listen = true}) {
    return Provider.of<PartStatusProvider>(context, listen: listen);
  }

  int? prid;

  PartStatusProvider(this.prid);

  Future<bool> updatePartStatus(bool isFaulty) {
    var completer = Completer<bool>();
    try {
      PartQcServiceElss.submitPartStatus(isFaulty, prid!).listen((event) {
        if (event != null && event.isSuccess == true) {
          completer.complete(true);
        } else {
          completer.completeError("Something went wrong");
        }
      }, onError: (error) {
        String err = ApiErrorHelper.getErrorMessage(error) ?? "Something went wrong";
        Logger.debug('mydebug------PartStatusProvider.updatePartStatus', [err]);
        completer.completeError(err);
      }, onDone: () {
        notifyListeners();
      });
    } catch (e) {
      completer.completeError(e.toString());
    }
    return completer.future;
  }
}
