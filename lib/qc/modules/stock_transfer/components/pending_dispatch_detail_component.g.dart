// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pending_dispatch_detail_component.dart';

// **************************************************************************
// ComponentGenerator
// **************************************************************************

PendingDispatchDetailParamModel fromMap(Map<String, dynamic> map) {
  PendingDispatchDetailParamModel model = PendingDispatchDetailParamModel(
    lotName: map["lotName"],
    scannedInvoiceNo: map["invoiceNo"],
  );
  return model;
}

Widget paramBuilder(
    Widget Function(PendingDispatchDetailParamModel model) paramBuilder) {
  return Selector<PageParamProvider, Map<String, dynamic>>(
    selector: (_, provider) => {
      "lotName": provider.data["lotName"],
      "invoiceNo": provider.data["invoiceNo"],
    },
    builder: (context, data, child) {
      PendingDispatchDetailParamModel model = fromMap(data);
      return paramBuilder(model);
    },
  );
}

bool isValid(PendingDispatchDetailParamModel model) {
  var lotName = model.lotName;
  var scannedInvoiceNo = model.scannedInvoiceNo;

  return lotName != null && scannedInvoiceNo != null;
}

dynamic schema() => {
      //#admincomponent
      "type": "@@component",
      "key": "QC_pending_dispatch_detail_component",
      "componentType": "Qc Stock Transfer Pending Dispatch Detail",
      "isActive": true,
      "title": "Pending Dispatch Detail Component",
      "cpm": [
        {"key": "invoiceNo", "value": null},
        {"key": "lotName", "value": null}
      ],
      "configJson": {
        "type": "list",
        "config": [
          {
            "uiType": "input",
            "type": "String",
            "isRequired": false,
            "label": "None",
            "key": "none"
          }
        ]
      }
      //#admincomponent
    };
