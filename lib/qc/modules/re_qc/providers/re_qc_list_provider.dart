import 'dart:async';

import 'package:core/core.dart';
import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/qc/modules/re_qc/models/re_qc_list_response.dart';
import 'package:flutter_trc/qc/modules/re_qc/resources/re_qc_service.dart';
import 'package:provider/provider.dart';

class ReQcListProvider extends CshChangeNotifier {
  String? _lotName;

  String? _deviceBarcode;

  List<int>? _lotTypeFilters;

  set lotName(String? value) {
    _deviceBarcode = null;
    _lotName = value;
  }

  set deviceBarcode(String? value) {
    _lotName = null;
    _deviceBarcode = value;
  }

  set lotTypeFilters(List<int>? value) {
    _lotTypeFilters = value;
  }

  List<int>? get lotTypeFilters => _lotTypeFilters;

  static ReQcListProvider of(BuildContext context, {bool listen = true}) {
    return Provider.of<ReQcListProvider>(context, listen: listen);
  }

  Future<void> skipReQc(int? lotId) {
    var completer = Completer<void>();
    ReQcService.skipReQc(lotId).listen((event) {
      completer.complete();
    }, onError: (error) {
      var errorMessage = ApiErrorHelper.getErrorMessage(error);
      completer.completeError(errorMessage.toString());
    });
    return completer.future;
  }

  Future<List<String>> completeReQc(int? lotId) {
    var completer = Completer<List<String>>();
    ReQcService.completeReQc(lotId).listen((event) {
      if (Validator.isTrue(event?.isSuccess)) {
        List<String> deviceList = [];
        if (!Validator.isListNullOrEmpty(event?.d2cLotDeviceList)) {
          deviceList = event!.d2cLotDeviceList!.map((e) => e.deviceBarcode ?? "").toList();
        }
        completer.complete(deviceList);
      } else {
        completer.completeError(event?.errorMsg.toString() ?? "Something went wrong");
      }
    }, onError: (error) {
      var errorMessage = ApiErrorHelper.getErrorMessage(error);
      completer.completeError(errorMessage.toString());
    });
    return completer.future;
  }

  void resetSearchFilters() {
    _lotName = null;
    _deviceBarcode = null;
  }
}
