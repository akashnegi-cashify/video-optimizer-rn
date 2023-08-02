import 'dart:async';

import 'package:core/core.dart';
import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/shipex/modules/create_shipment/resources/doc_type_enum.dart';
import 'package:provider/provider.dart';

import '../resources/create_shipment_service.dart';

class DocumentDownloadProvider extends CshChangeNotifier {
  static DocumentDownloadProvider of(BuildContext context, {bool listen = true}) {
    return Provider.of<DocumentDownloadProvider>(context, listen: listen);
  }

  String documentType = DocTypeEnum.awbInvoice.value;

  Future<String> getDocumentDownloadLink({String? courierAwb, String? shipmentId}) {
    var completer = Completer<String>();
    try {
      CreateShipmentService.getDocumentLink(documentType, courierAwb, shipmentId).listen((event) {
        if (!Validator.isNullOrEmpty(event?.documentLink)) {
          completer.complete(event!.documentLink!);
        } else {
          completer.completeError("Something went wrong");
        }
      }, onError: (error) {
        String em = ApiErrorHelper.getErrorMessage(error) ?? "Something went wrong";
        Logger.debug('mydebug------DocumentDownloadProvider.getDocumentDonwloadLink', [em]);
        completer.completeError(em);
      }, onDone: () {
        notifyListeners();
      });
    } catch (e) {
      completer.completeError(e.toString());
    }
    return completer.future;
  }

  void onDocTypeChange(String data) {
    documentType = data;
    notifyListeners();
  }
}
