// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'd2c_video_component.dart';

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
      "key": "QC_d2c_video_component_key",
      "componentType": "QC D2C Video Component",
      "isActive": true,
      "title": "D2 C Video Component",
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
