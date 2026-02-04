// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'guard_upload_invoice_component.dart';

// **************************************************************************
// ComponentGenerator
// **************************************************************************

UploadInvoiceCompParam fromMap(Map<String, dynamic> map) {
  UploadInvoiceCompParam model = UploadInvoiceCompParam(
    selectedAgent: map["selectedAgent"],
    deviceCount: map["deviceCount"],
  );
  return model;
}

Widget paramBuilder(
    Widget Function(UploadInvoiceCompParam model) paramBuilder) {
  return Selector<PageParamProvider, Map<String, dynamic>>(
    selector: (_, provider) => {
      "selectedAgent": provider.data["selectedAgent"],
      "deviceCount": provider.data["deviceCount"],
    },
    builder: (context, data, child) {
      UploadInvoiceCompParam model = fromMap(data);
      return paramBuilder(model);
    },
  );
}

bool isValid(UploadInvoiceCompParam model) {
  var selectedAgent = model.selectedAgent;
  var deviceCount = model.deviceCount;

  return selectedAgent != null && deviceCount != null;
}

dynamic schema() => {
      //#admincomponent
      "type": "@@component",
      "key": "QC_guard_upload_invoice_component",
      "componentType": "QC Guard Upload Invoice Component",
      "isActive": true,
      "title": "Guard Upload Invoice Component",
      "cpm": [
        {"key": "deviceCount", "value": null},
        {"key": "selectedAgent", "value": null}
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
