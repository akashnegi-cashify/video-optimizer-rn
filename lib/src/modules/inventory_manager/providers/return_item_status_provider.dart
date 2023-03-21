import 'dart:async';

import 'package:core/core.dart';
import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/modules/inventory_manager/resources/inventory_manager_service.dart';
import 'package:provider/provider.dart';

class ReturnItemStatusProvider extends CshChangeNotifier {
  static ReturnItemStatusProvider of(BuildContext context, {bool listen = true}) {
    return Provider.of<ReturnItemStatusProvider>(context, listen: listen);
  }

  int? prid;

  ReturnItemStatusProvider(this.prid);

  Future<bool> updateReturnPartItemStatus(bool isFaulty) {
    var completer = Completer<bool>();
    try {
      InventoryService.updateReturnPartStatus(prid!, isFaulty).listen((event) {
        if (event != null && event.isSuccess == true) {
          completer.complete(true);
        } else {
          completer.completeError("Something went wrong!!");
        }
      }, onError: (error) {
        String em = ApiErrorHelper.getErrorMessage(error) ?? "Something wnet wrong";
        Logger.debug('mydebug------ReturnItemStatusProvider.updateReturnPartItemStatus', [em]);
        completer.completeError(em);
      }, onDone: () {
        notifyListeners();
      });
    } catch (e) {
      completer.completeError(e.toString());
    }
    return completer.future;
  }
}
