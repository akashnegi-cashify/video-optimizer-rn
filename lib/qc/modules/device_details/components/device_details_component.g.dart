// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'device_details_component.dart';

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
      "key": "QC_device_details_component",
      "componentType": "QC Device Details Component",
      "isActive": true,
      "title": "Device Details Component",
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
