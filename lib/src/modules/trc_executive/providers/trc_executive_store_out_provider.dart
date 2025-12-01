import 'dart:async';

import 'package:core/core.dart';
import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/modules/trc_executive/models/tl_list_response.dart';
import 'package:flutter_trc/src/modules/trc_executive/resources/device_scanner_service.dart';
import 'package:provider/provider.dart';

class TrcExecutiveStoreOutProvider extends CshChangeNotifier {
  final TlListData tlData;

  TrcExecutiveStoreOutProvider(this.tlData);

  static TrcExecutiveStoreOutProvider of(BuildContext context, {bool listen = true}) {
    return Provider.of<TrcExecutiveStoreOutProvider>(context, listen: listen);
  }

  String? get tlName => tlData.name;

  Future<void> storeOut(String barcode) {
    var completer = Completer<void>();
    DeviceScannerService.storeOut(barcode, tlData.id).listen((event) {
      completer.complete();
    }, onError: (error) {
      var message = ApiErrorHelper.getErrorMessage(error);
      completer.completeError(message.toString());
    });
    return completer.future;
  }
}
