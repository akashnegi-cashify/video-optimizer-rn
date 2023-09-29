// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'assigned_device_details_component.dart';

// **************************************************************************
// ComponentGenerator
// **************************************************************************

AssignedDeviceDetailsCompParam fromMap(Map<String, dynamic> map) {
  AssignedDeviceDetailsCompParam model = AssignedDeviceDetailsCompParam(
    did: map["did"],
  );
  return model;
}

Widget paramBuilder(
    Widget Function(AssignedDeviceDetailsCompParam model) paramBuilder) {
  return Selector<PageParamProvider, Map<String, dynamic>>(
    selector: (_, provider) => {
      "did": provider.data["did"],
    },
    builder: (context, data, child) {
      AssignedDeviceDetailsCompParam model = fromMap(data);
      return paramBuilder(model);
    },
  );
}

bool isValid(AssignedDeviceDetailsCompParam model) {
  var did = model.did;

  return did != null;
}

dynamic schema() => {
      //#admincomponent
      "type": "@@component",
      "key": "TRC_assigned_device_details",
      "componentType": "Assigned device Details",
      "isActive": true,
      "title": "Assigned Device Details Component",
      "cpm": [
        {"key": "did", "value": null}
      ],
      "configJson": {
        "type": "map",
        "config": {
          "none": {
            "uiType": "input",
            "type": "String",
            "isRequired": false,
            "label": "None",
            "key": "none"
          }
        }
      }
      //#admincomponent
    };
