// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'device_scanner_comp.dart';

// **************************************************************************
// ComponentGenerator
// **************************************************************************

DeviceScannerScreenArgumentsModel fromMap(Map<String, dynamic> map) {
  DeviceScannerScreenArgumentsModel model = DeviceScannerScreenArgumentsModel(
    storageBarcode: map["sbr"],
  );
  return model;
}

Widget paramBuilder(
    Widget Function(DeviceScannerScreenArgumentsModel model) paramBuilder) {
  return Selector<PageParamProvider, Map<String, dynamic>>(
    selector: (_, provider) => {
      "sbr": provider.data["sbr"],
    },
    builder: (context, data, child) {
      DeviceScannerScreenArgumentsModel model = fromMap(data);
      return paramBuilder(model);
    },
  );
}

bool isValid(DeviceScannerScreenArgumentsModel model) {
  var storageBarcode = model.storageBarcode;

  return storageBarcode != null;
}

dynamic schema() => {
      //#admincomponent
      "type": "@@component",
      "key": "TRC_device_scanner_widget",
      "componentType": "Device Scanner",
      "isActive": true,
      "title": "Device Scanner Component",
      "cpm": [
        {"key": "sbr", "value": null}
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
