import 'dart:async';
import 'package:core/core.dart';
import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/modules/inventory_manager/resources/inventory_manager_service.dart';
import 'package:provider/provider.dart';
import '../models/alternate_part_request_response.dart';

class AlternatePartListProvider extends CshChangeNotifier {
  static AlternatePartListProvider of(BuildContext context, {bool listen = true}) {
    return Provider.of<AlternatePartListProvider>(context, listen: listen);
  }

  int? prid;
  AlternatePartRequestResponse? alternatePartRequestResponse;

  AlternatePartListProvider(this.prid);

  Future<bool> alternatePartRequest(int partId, String productName, String sku, int did, String partVariantName) {
    var completer = Completer<bool>();

    try {
      InventoryService.alternatePartRequest(partId, productName, sku, did, partVariantName).listen((event) {
        if (event != null && event.isSuccess == true) {
          completer.complete(true);
        } else {
          completer.completeError("Something went wrong");
        }
      }, onError: (error) {
        String er = ApiErrorHelper.getErrorMessage(error) ?? "Something went wrong";
        Logger.debug('mydebug------AlternatePartListProvider.alternatePartRequest', [er]);
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
