// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'device_report_component.dart';

// **************************************************************************
// ComponentGenerator
// **************************************************************************

DeviceReportCompParam fromMap(Map<String, dynamic> map) {
  DeviceReportCompParam model = DeviceReportCompParam(
    deviceId: map["did"],
  );
  return model;
}

Widget paramBuilder(Widget Function(DeviceReportCompParam model) paramBuilder) {
  return Selector<PageParamProvider, Map<String, dynamic>>(
    selector: (_, provider) => {
      "did": provider.data["did"],
    },
    builder: (context, data, child) {
      DeviceReportCompParam model = fromMap(data);
      return paramBuilder(model);
    },
  );
}

bool isValid(DeviceReportCompParam model) {
  var deviceId = model.deviceId;

  return deviceId != null;
}

dynamic schema() => {
      //#admincomponent
      "type": "@@component",
      "key": "TRC_device_report_component",
      "componentType": "Trc Device Report Component",
      "isActive": true,
      "title": "Device Report Component",
      "cpm": [
        {"key": "did", "value": null}
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
