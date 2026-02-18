// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'device_dead_accept_reject_component.dart';

// **************************************************************************
// ComponentGenerator
// **************************************************************************

DeviceDeadAcceptRejectCompParam fromMap(Map<String, dynamic> map) {
  DeviceDeadAcceptRejectCompParam model = DeviceDeadAcceptRejectCompParam(
    header: map["h"],
    code: map["code"],
    selectedReason: map["sr"],
    markId: map["mi"],
  );
  return model;
}

Widget paramBuilder(
    Widget Function(DeviceDeadAcceptRejectCompParam model) paramBuilder) {
  return Selector<PageParamProvider, Map<String, dynamic>>(
    selector: (_, provider) => {
      "h": provider.data["h"],
      "code": provider.data["code"],
      "sr": provider.data["sr"],
      "mi": provider.data["mi"],
    },
    builder: (context, data, child) {
      DeviceDeadAcceptRejectCompParam model = fromMap(data);
      return paramBuilder(model);
    },
  );
}

bool isValid(DeviceDeadAcceptRejectCompParam model) {
  var header = model.header;
  var code = model.code;
  var selectedReason = model.selectedReason;
  var markId = model.markId;

  return header != null &&
      code != null &&
      selectedReason != null &&
      markId != null;
}

dynamic schema() => {
      //#admincomponent
      "type": "@@component",
      "key": "QC_qc_device_dead_accept_reject_component",
      "componentType": "Device Dead Accept Reject",
      "isActive": true,
      "title": "Device Dead Accept Reject Component",
      "cpm": [
        {"key": "h", "value": null},
        {"key": "code", "value": null},
        {"key": "sr", "value": null},
        {"key": "mi", "value": null}
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
