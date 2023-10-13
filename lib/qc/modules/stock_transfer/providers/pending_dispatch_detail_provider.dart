import 'dart:async';

import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/qc/modules/stock_transfer/resources/stock_transfer_service.dart';
import 'package:provider/provider.dart';

class PendingDispatchDetailProvider extends CshChangeNotifier {
  static PendingDispatchDetailProvider of(BuildContext context, {bool listen = true}) {
    return Provider.of<PendingDispatchDetailProvider>(context, listen: listen);
  }

  String? scannedInvoiceNo;
  String? lotName;
  String? _invoiceUrl;

  PendingDispatchDetailProvider(this.scannedInvoiceNo, this.lotName);

  String? get invoiceUrl => _invoiceUrl;

  set invoiceUrl(String? value) {
    _invoiceUrl = value;
    notifyListeners();
  }

  void _resetAllData() {
    _invoiceUrl = null;
    scannedInvoiceNo = null;
  }

  void onNewInvoiceScanned(String scannedData) {
    _resetAllData();
    scannedInvoiceNo = scannedData;
    notifyListeners();
  }

  Future<void> completeDispatch(String? awbNo) {
    var completer = Completer<void>();

    StockTransferService.completePendingDispatch(scannedInvoiceNo!, awbNo!, invoiceUrl!).listen((event) {
      completer.complete();
    }, onError: (error) {
      completer.completeError(ApiErrorHelper.getErrorMessage(error).toString());
    });
    return completer.future;
  }

  bool isAllDataFilled(String? awbNo) {
    return !Validator.isNullOrEmpty(invoiceUrl) &&
        !Validator.isNullOrEmpty(awbNo) &&
        !Validator.isNullOrEmpty(scannedInvoiceNo);
  }
}
