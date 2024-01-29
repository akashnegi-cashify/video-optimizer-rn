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

  Future<List<ReQcListData>?> getReQcList(int pageSize, int offset) {
    var completer = Completer<List<ReQcListData>?>();
    ReQcService.getReQcList(pageSize, offset,
            searchQuery: _lotName, lotType: _lotTypeFilters, deviceBarcode: _deviceBarcode)
        .listen((response) {
      if (!Validator.isListNullOrEmpty(response?.list)) {
        completer.complete(response?.list);
      } else {
        completer.completeError("No Data found");
      }
    }, onError: (error) {
      var errorMessage = ApiErrorHelper.getErrorMessage(error);
      completer.completeError(errorMessage.toString());
    });
    return completer.future;
  }

  Future<void> skipReQc(String? lotName) {
    var completer = Completer<void>();
    ReQcService.skipReQc(lotName).listen((event) {
      completer.complete();
    }, onError: (error) {
      var errorMessage = ApiErrorHelper.getErrorMessage(error);
      completer.completeError(errorMessage.toString());
    });
    return completer.future;
  }

  Future<void> completeReQc(String? lotGroupName) {
    var completer = Completer<void>();
    ReQcService.completeReQc(lotGroupName).listen((event) {
      if (Validator.isTrue(event?.isSuccess)) {
        completer.complete();
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
