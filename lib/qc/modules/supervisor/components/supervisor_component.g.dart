// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'supervisor_component.dart';

// **************************************************************************
// ComponentGenerator
// **************************************************************************

SupervisorParamModel fromMap(Map<String, dynamic> map) {
  SupervisorParamModel model = SupervisorParamModel(
    deviceBarcode: map["db"],
  );
  return model;
}

Widget paramBuilder(Widget Function(SupervisorParamModel model) paramBuilder) {
  return Selector<PageParamProvider, Map<String, dynamic>>(
    selector: (_, provider) => {
      "db": provider.data["db"],
    },
    builder: (context, data, child) {
      SupervisorParamModel model = fromMap(data);
      return paramBuilder(model);
    },
  );
}

bool isValid(SupervisorParamModel model) {
  var deviceBarcode = model.deviceBarcode;

  return deviceBarcode != null;
}

dynamic schema() => {
      //#admincomponent
      "type": "@@component",
      "key": "QC_supervisor_component",
      "componentType": "QC Supervisor Device Detail Component",
      "isActive": true,
      "title": "Supervisor Component",
      "cpm": [
        {"key": "db", "value": null}
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
