import 'dart:async';

import 'package:core/core.dart';
import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/modules/inventory_manager/resources/inventory_manager_service.dart';
import 'package:provider/provider.dart';

class AssignPartBarcodeProvider extends CshChangeNotifier {
  static AssignPartBarcodeProvider of(BuildContext context, {bool listen = true}) {
    return Provider.of<AssignPartBarcodeProvider>(context, listen: listen);
  }

  int? prid;

  AssignPartBarcodeProvider(this.prid);

  Future<bool> assignPartBarcode(String barcode) {
    var completer = Completer<bool>();
    try {
      InventoryService.partLinkBarcode(prid!, barcode).listen((event) {
        if (event != null && event.isSuccess == true) {
          completer.complete(true);
        } else {
          completer.completeError("Something went wrong");
        }
      }, onError: (error) {
        String er = ApiErrorHelper.getErrorMessage(error) ?? "Something went wrong";
        Logger.debug('mydebug------AssignPartBarcodeProvider.assignPartBarcode', [er]);
        completer.completeError(er);
      }, onDone: () {
        notifyListeners();
      });
    } catch (e) {
      completer.completeError(e.toString());
    }
    return completer.future;
  }
}
