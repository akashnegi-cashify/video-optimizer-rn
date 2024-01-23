// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_device_media_component.dart';

// **************************************************************************
// ComponentGenerator
// **************************************************************************

AddDeviceMediaCompParam fromMap(Map<String, dynamic> map) {
  AddDeviceMediaCompParam model = AddDeviceMediaCompParam(
    addDeviceMediaArgumentsTrc: map["arg"],
  );
  return model;
}

Widget paramBuilder(
    Widget Function(AddDeviceMediaCompParam model) paramBuilder) {
  return Selector<PageParamProvider, Map<String, dynamic>>(
    selector: (_, provider) => {
      "arg": provider.data["arg"],
    },
    builder: (context, data, child) {
      AddDeviceMediaCompParam model = fromMap(data);
      return paramBuilder(model);
    },
  );
}

bool isValid(AddDeviceMediaCompParam model) {
  var addDeviceMediaArgumentsTrc = model.addDeviceMediaArgumentsTrc;

  return addDeviceMediaArgumentsTrc != null;
}

dynamic schema() => {
      //#admincomponent
      "type": "@@component",
      "key": "TRC_add_device_media",
      "componentType": "Add Device Media",
      "isActive": true,
      "title": "Add Device Media Component",
      "cpm": [
        {"key": "arg", "value": null}
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
