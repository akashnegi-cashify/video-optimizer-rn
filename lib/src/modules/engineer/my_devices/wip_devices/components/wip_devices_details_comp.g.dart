// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wip_devices_details_comp.dart';

// **************************************************************************
// ComponentGenerator
// **************************************************************************

WipDetailsCompParam fromMap(Map<String, dynamic> map) {
  WipDetailsCompParam model = WipDetailsCompParam(
    engineerDeviceInfo: map["edi"],
  );
  return model;
}

Widget paramBuilder(Widget Function(WipDetailsCompParam model) paramBuilder) {
  return Selector<PageParamProvider, Map<String, dynamic>>(
    selector: (_, provider) => {
      "edi": provider.data["edi"],
    },
    builder: (context, data, child) {
      WipDetailsCompParam model = fromMap(data);
      return paramBuilder(model);
    },
  );
}

bool isValid(WipDetailsCompParam model) {
  var engineerDeviceInfo = model.engineerDeviceInfo;

  return engineerDeviceInfo != null;
}

dynamic schema() => {
      //#admincomponent
      "type": "@@component",
      "key": "TRC_wip_devices_details_comp",
      "componentType": "WIP Devices",
      "isActive": true,
      "title": "Wip Device Details Component",
      "cpm": [
        {"key": "edi", "value": null}
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
