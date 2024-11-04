// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'device_scanner_comp.dart';

// **************************************************************************
// ComponentGenerator
// **************************************************************************

DeviceScannerScreenArgumentsModel fromMap(Map<String, dynamic> map) {
  DeviceScannerScreenArgumentsModel model = DeviceScannerScreenArgumentsModel(
    tlUserData: map["tlUser"],
  );
  return model;
}

Widget paramBuilder(
    Widget Function(DeviceScannerScreenArgumentsModel model) paramBuilder) {
  return Selector<PageParamProvider, Map<String, dynamic>>(
    selector: (_, provider) => {
      "tlUser": provider.data["tlUser"],
    },
    builder: (context, data, child) {
      DeviceScannerScreenArgumentsModel model = fromMap(data);
      return paramBuilder(model);
    },
  );
}

bool isValid(DeviceScannerScreenArgumentsModel model) {
  var tlUserData = model.tlUserData;

  return tlUserData != null;
}

dynamic schema() => {
      //#admincomponent
      "type": "@@component",
      "key": "TRC_device_scanner_widget",
      "componentType": "Device Scanner",
      "isActive": true,
      "title": "Device Scanner Component",
      "cpm": [
        {"key": "tlUser", "value": null}
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
