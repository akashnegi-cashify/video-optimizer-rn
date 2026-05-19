import 'dart:async';

import 'package:core/core.dart';
import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/common/searchable.dart';
import 'package:flutter_trc/src/modules/trc_executive/models/tl_list_response.dart';
import 'package:flutter_trc/src/modules/trc_executive/resources/device_scanner_service.dart';
import 'package:provider/provider.dart';

class TlListProvider extends CshChangeNotifier with Searchable {
  static TlListProvider of(BuildContext context, {bool listen = true}) {
    return Provider.of<TlListProvider>(context, listen: listen);
  }

  Future<List<TlListData>> getTlList(int pageNo, int pageSize) {
    var completer = Completer<List<TlListData>>();
    DeviceScannerService.getTlList(pageNo, pageSize, searchQuery: searchQuery).listen((event) {
      if (!Validator.isListNullOrEmpty(event?.tlList)) {
        completer.complete(event?.tlList);
      } else {
        completer.completeError("No Team Lead found");
      }
    }, onError: (error) {
      completer.completeError(ApiErrorHelper.getErrorMessage(error).toString());
    });
    return completer.future;
  }
}
