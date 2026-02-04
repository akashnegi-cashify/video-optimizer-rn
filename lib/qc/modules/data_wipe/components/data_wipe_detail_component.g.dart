// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data_wipe_detail_component.dart';

// **************************************************************************
// ComponentGenerator
// **************************************************************************

DeviceBarcodeParamModel fromMap(Map<String, dynamic> map) {
  DeviceBarcodeParamModel model = DeviceBarcodeParamModel(
    deviceBarcode: map["dbr"],
  );
  return model;
}

Widget paramBuilder(
    Widget Function(DeviceBarcodeParamModel model) paramBuilder) {
  return Selector<PageParamProvider, Map<String, dynamic>>(
    selector: (_, provider) => {
      "dbr": provider.data["dbr"],
    },
    builder: (context, data, child) {
      DeviceBarcodeParamModel model = fromMap(data);
      return paramBuilder(model);
    },
  );
}

bool isValid(DeviceBarcodeParamModel model) {
  var deviceBarcode = model.deviceBarcode;

  return deviceBarcode != null;
}

dynamic schema() => {
      //#admincomponent
      "type": "@@component",
      "key": "QC_data_wipe_detail_component",
      "componentType": "QC Data Wipe Detail Component",
      "isActive": true,
      "title": "Data Wipe Detail Component",
      "cpm": [
        {"key": "dbr", "value": null}
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
